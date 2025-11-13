import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiConstants {
  // Auto-detecta la plataforma y usa la URL correcta
  static String get baseUrl {
    if (kIsWeb) {
      // Para Flutter Web
      return 'http://localhost:8080/api';
    } else if (Platform.isAndroid) {
      // Para emulador Android (10.0.2.2 es el localhost del host)
      return 'http://10.0.2.2:8080/api';
    } else {
      // Para iOS Simulator, Desktop, etc.
      return 'http://localhost:8080/api';
    }
  }
  
  // Si quieres usar una IP específica, descomenta y edita esta línea:
  // static const String baseUrl = 'http://192.168.1.100:8080/api';
  
  // Pacientes
  static const String pacientes = '/pacientes';
  static const String pacienteBuscar = '/pacientes/buscar';
  
  // Especialidades
  static const String especialidades = '/especialidades';
  
  // Médicos
  static const String medicos = '/medicos';
  static const String medicoBuscar = '/medicos/buscar';
  static const String medicosPorEspecialidad = '/medicos/especialidad';
  
  // Historias Clínicas
  static const String historiasClinicas = '/historias-clinicas';
  static const String historiasPorPaciente = '/historias-clinicas/paciente';
  static const String historiasPorMedico = '/historias-clinicas/medico';
  static const String historiasPorFechas = '/historias-clinicas/fechas';
  
  // Timeouts
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}
