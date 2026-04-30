import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'h2_servicio_autenticacion.dart';

/// Proveedor para gestionar el estado de la sesión.
class H2ProveedorAutenticacion extends ChangeNotifier {
  final H2ServicioAutenticacion _servicioAutenticacion;
  
  // DoD 2.2: Almacenamiento encriptado de datos[cite: 1].
  final FlutterSecureStorage _almacenamientoSeguro = const FlutterSecureStorage();
  
  bool _estaCargando = false;
  bool _estaAutenticado = false;
  String _mensajeError = '';

  H2ProveedorAutenticacion(this._servicioAutenticacion) {
    _verificarSesionExistente();
  }

  bool get estaCargando => _estaCargando;
  bool get estaAutenticado => _estaAutenticado;
  String get mensajeError => _mensajeError;

  Future<void> _verificarSesionExistente() async {
    String? token = await _almacenamientoSeguro.read(key: 'jwt_token');
    if (token != null) {
      _estaAutenticado = true;
      notifyListeners();
    }
  }

  Future<bool> iniciarSesion(String correo, String contrasena) async {
    _estaCargando = true;
    _mensajeError = '';
    notifyListeners();

    try {
      final token = await _servicioAutenticacion.iniciarSesion(correo, contrasena);
      if (token != null) {
        await _almacenamientoSeguro.write(key: 'jwt_token', value: token);
        _estaAutenticado = true;
        _estaCargando = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      _mensajeError = e.toString().replaceAll('Exception: ', '');
    }

    _estaAutenticado = false;
    _estaCargando = false;
    notifyListeners();
    return false;
  }

  Future<void> cerrarSesion() async {
    await _servicioAutenticacion.cerrarSesion();
    await _almacenamientoSeguro.delete(key: 'jwt_token');
    _estaAutenticado = false;
    notifyListeners();
  }
}