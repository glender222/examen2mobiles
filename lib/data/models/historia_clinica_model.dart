import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/historia_clinica.dart';

part 'historia_clinica_model.g.dart';

@JsonSerializable()
class HistoriaClinicaModel extends HistoriaClinica {
  const HistoriaClinicaModel({
    super.histId,
    required super.pacDni,
    super.pacNombreCompleto,
    required super.medCmp,
    super.medNombreCompleto,
    super.medEspecialidad,
    required super.histFechaAtencion,
    required super.histDiagnostico,
    super.histAnalisis,
    super.histTratamiento,
  });

  factory HistoriaClinicaModel.fromJson(Map<String, dynamic> json) =>
      _$HistoriaClinicaModelFromJson(json);

  Map<String, dynamic> toJson() => _$HistoriaClinicaModelToJson(this);

  factory HistoriaClinicaModel.fromEntity(HistoriaClinica historia) {
    return HistoriaClinicaModel(
      histId: historia.histId,
      pacDni: historia.pacDni,
      pacNombreCompleto: historia.pacNombreCompleto,
      medCmp: historia.medCmp,
      medNombreCompleto: historia.medNombreCompleto,
      medEspecialidad: historia.medEspecialidad,
      histFechaAtencion: historia.histFechaAtencion,
      histDiagnostico: historia.histDiagnostico,
      histAnalisis: historia.histAnalisis,
      histTratamiento: historia.histTratamiento,
    );
  }
}
