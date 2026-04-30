import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'h2_proveedor_autenticacion.dart';

/// Pantalla principal de Inicio de Sesión (H2)
class H2 extends StatefulWidget {
  const H2({Key? key}) : super(key: key);

  @override
  State<H2> createState() => _H2State();
}

class _H2State extends State<H2> {
  final _claveFormulario = GlobalKey<FormState>();
  final _controladorCorreo = TextEditingController();
  final _controladorContrasena = TextEditingController();
  bool _ocultarContrasena = true;

  @override
  void dispose() {
    _controladorCorreo.dispose();
    _controladorContrasena.dispose();
    super.dispose();
  }

  void _procesarFormulario() async {
    if (_claveFormulario.currentState!.validate()) {
      final proveedorAutenticacion = Provider.of<H2ProveedorAutenticacion>(context, listen: false);
      final exito = await proveedorAutenticacion.iniciarSesion(
        _controladorCorreo.text.trim(),
        _controladorContrasena.text,
      );

      if (exito && mounted) {
        // Mostramos el mensaje
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bienvenido al Portal Médico')),
        );
        // Cerramos la pantalla de Login y volvemos al Home
        Navigator.pop(context); 
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final proveedorAutenticacion = Provider.of<H2ProveedorAutenticacion>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFEAF4F8), 
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Form(
                  key: _claveFormulario,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_hospital, size: 64, color: Color(0xFF102E4A)),
                      const SizedBox(height: 16),
                      const Text(
                        'Portal de Acceso',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF102E4A),
                        ),
                      ),
                      const SizedBox(height: 32),
                      
                      TextFormField(
                        controller: _controladorCorreo,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Correo Electrónico',
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Por favor ingresa tu correo';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _controladorContrasena,
                        // DoD 2.2: Evitar que la contraseña se vea en texto plano[cite: 1]
                        obscureText: _ocultarContrasena, 
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _ocultarContrasena ? Icons.visibility : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _ocultarContrasena = !_ocultarContrasena;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        validator: (valor) {
                          if (valor == null || valor.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      if (proveedorAutenticacion.mensajeError.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Text(
                            proveedorAutenticacion.mensajeError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1D5A8C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          onPressed: proveedorAutenticacion.estaCargando ? null : _procesarFormulario,
                          child: proveedorAutenticacion.estaCargando
                              ? const CircularProgressIndicator(color: Colors.white)
                              : const Text(
                                  'Iniciar Sesión',
                                  style: TextStyle(fontSize: 16, color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}