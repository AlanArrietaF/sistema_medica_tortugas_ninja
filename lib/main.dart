import 'package:flutter/material.dart';
import 'home.dart'; // Esto llama a tu archivo de las tortugas ninja

//librerias para h1
import 'package:provider/provider.dart';
import 'H2/h2_proveedor_autenticacion.dart';
import 'H2/h2_servicio_autenticacion.dart';


void main() {
  // Asegúrate de que llame a MiAppMedica, NO a HomePage directamente
  runApp(const MiAppMedica()); 
}

class MiAppMedica extends StatelessWidget {
  const MiAppMedica({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // El proveedor sigue en la raíz para que el estado de sesión exista en toda la app
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => H2ProveedorAutenticacion(
            H2ServicioAutenticacionSimulado(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Sistema Médico',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF1D5A8C),
          fontFamily: 'Roboto', 
        ),
        // Ahora el Home SIEMPRE es la pantalla inicial
        home: const HomePage(),
      ),
    );
  }
}