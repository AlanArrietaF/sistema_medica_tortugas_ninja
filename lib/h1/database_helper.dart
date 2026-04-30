// Modificación en el archivo pubspec.yaml
/*
dependencies:
  flutter:
    sdk: flutter
  postgres: ^3.0.0 # Añade esta línea
*/
import 'package:postgres/postgres.dart';

class DatabaseService {
  static Future<void> conectar() async {
    final conn = await Connection.open(
      Endpoint(
        host: 'tu_host_aqui',
        database: 'nombre_bd',
        username: 'tu_usuario',
        password: 'tu_password',
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
    // Aquí puedes hacer consultas..
  }
}