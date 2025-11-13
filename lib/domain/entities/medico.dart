import 'package:equatable/equatable.dart';

class Medico extends Equatable {
  final String medCmp;
  final String medNombre;
  final String medApellidos;
  final int medEspecialidadId;
  final String? medEspecialidadNombre;

  const Medico({
    required this.medCmp,
    required this.medNombre,
    required this.medApellidos,
    required this.medEspecialidadId,
    this.medEspecialidadNombre,
  });
  
  String get nombreCompleto => '$medNombre $medApellidos';

  @override
  List<Object?> get props => [
        medCmp,
        medNombre,
        medApellidos,
        medEspecialidadId,
        medEspecialidadNombre,
      ];
}
