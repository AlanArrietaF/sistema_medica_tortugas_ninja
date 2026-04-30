/// Servicio de autenticación.
/// DoD 2.1: Código documentado y preparado para inyección de dependencias[cite: 1].
abstract class H2ServicioAutenticacion {
  Future<String?> iniciarSesion(String correo, String contrasena);
  Future<void> cerrarSesion();
}

class H2ServicioAutenticacionSimulado implements H2ServicioAutenticacion {
  @override
  Future<String?> iniciarSesion(String correo, String contrasena) async {
    // Simulamos el tiempo de respuesta del servidor
    await Future.delayed(const Duration(seconds: 2));
    
    if (correo == 'medico@hospital.com' && contrasena == 'Segura123!') {
      return 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.simulado';
    }
    throw Exception('Credenciales inválidas');
  }

  @override
  Future<void> cerrarSesion() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}