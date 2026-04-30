// En el archivo main se necesita importar este archivo para que se pueda usar la clase RegistroPage
// import 'registro.dart'; // Esto llama a tu archivo de registro
// Ahora, para navegar a la página de registro desde tu página principal, puedes usar un ElevatedButton como este (en main.dart):
// ElevatedButton(
//       onPressed: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => const RegistroPage()),
//         );
//       },
//      child: const Text('Ir a Registro'),
//    )
//    ```
import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  const RegistroPage({super.key});

  @override
  State<RegistroPage> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  // Variable para controlar qué tipo de registro estamos viendo
  bool esDoctor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(esDoctor ? 'Registro de Doctores' : 'Registro de Pacientes'),
        backgroundColor: esDoctor ? Colors.teal[700] : Colors.blueGrey[900],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // Switch para cambiar entre Paciente y Doctor
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Paciente"),
                Switch(
                  value: esDoctor,
                  onChanged: (value) {
                    setState(() {
                      esDoctor = value;
                    });
                  },
                  activeColor: Colors.teal,
                ),
                const Text("Doctor"),
              ],
            ),
            const SizedBox(height: 20),
            
            // Campos comunes
            const TextField(decoration: InputDecoration(labelText: 'Nombre Completo', icon: Icon(Icons.person))),
            const TextField(decoration: InputDecoration(labelText: 'Correo', icon: Icon(Icons.email))),
            
            // Campos dinámicos para Doctor
            if (esDoctor) ...[
              const TextField(decoration: InputDecoration(labelText: 'Cédula Profesional', icon: Icon(Icons.badge))),
              const TextField(decoration: InputDecoration(labelText: 'Especialidad', icon: Icon(Icons.medical_services))),
            ],
            
            // Campos dinámicos para Paciente
            if (!esDoctor) ...[
              const TextField(decoration: InputDecoration(labelText: 'Número de Seguro', icon: Icon(Icons.health_and_safety))),
            ],

            const TextField(
              obscureText: true, 
              decoration: InputDecoration(labelText: 'Contraseña', icon: Icon(Icons.lock))
            ),
            
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: esDoctor ? Colors.teal : Colors.blueGrey[900],
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                // Aquí conectarás con PostgreSQL más adelante
              },
              child: const Text('Completar Registro', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}