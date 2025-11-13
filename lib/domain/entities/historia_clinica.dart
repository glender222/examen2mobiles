import 'package:equatable/equatable.dart';

class HistoriaClinica extends Equatable {
  final int? histId;
  final String pacDni;
  final String? pacNombreCompleto;
  final String medCmp;
  final String? medNombreCompleto;
  final String? medEspecialidad;
  final String histFechaAtencion;
  final String histDiagnostico;
  final String? histAnalisis;
  final String? histTratamiento;

  const HistoriaClinica({
    this.histId,
    required this.pacDni,
    this.pacNombreCompleto,
    required this.medCmp,
    this.medNombreCompleto,
    this.medEspecialidad,
    required this.histFechaAtencion,
    required this.histDiagnostico,
    this.histAnalisis,
    this.histTratamiento,
  });

  @override
  List<Object?> get props => [
        histId,
        pacDni,
        pacNombreCompleto,
        medCmp,
        medNombreCompleto,
        medEspecialidad,
        histFechaAtencion,
        histDiagnostico,
        histAnalisis,
        histTratamiento,
      ];
}
