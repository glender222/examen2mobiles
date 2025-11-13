import 'package:equatable/equatable.dart';

class Paciente extends Equatable {
  final String pacDni;
  final String pacNombre;
  final String pacApellidoPaterno;
  final String pacApellidoMaterno;
  final String? pacDireccion;
  final String? pacTelefono;

  const Paciente({
    required this.pacDni,
    required this.pacNombre,
    required this.pacApellidoPaterno,
    required this.pacApellidoMaterno,
    this.pacDireccion,
    this.pacTelefono,
  });
  
  String get nombreCompleto => '$pacNombre $pacApellidoPaterno $pacApellidoMaterno';

  @override
  List<Object?> get props => [
        pacDni,
        pacNombre,
        pacApellidoPaterno,
        pacApellidoMaterno,
        pacDireccion,
        pacTelefono,
      ];
}
