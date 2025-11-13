import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/medico.dart';

part 'medico_model.g.dart';

@JsonSerializable()
class MedicoModel extends Medico {
  @override
  final String medCmp;

  @override
  final String medNombre;

  @override
  final String medApellidos;

  @JsonKey(name: 'espeId')
  @override
  final int medEspecialidadId;

  @JsonKey(name: 'espeNombre')
  @override
  final String? medEspecialidadNombre;

  const MedicoModel({
    required this.medCmp,
    required this.medNombre,
    required this.medApellidos,
    required this.medEspecialidadId,
    this.medEspecialidadNombre,
  }) : super(
          medCmp: medCmp,
          medNombre: medNombre,
          medApellidos: medApellidos,
          medEspecialidadId: medEspecialidadId,
          medEspecialidadNombre: medEspecialidadNombre,
        );

  factory MedicoModel.fromJson(Map<String, dynamic> json) =>
      _$MedicoModelFromJson(json);

  Map<String, dynamic> toJson() {
    // Para enviar al backend, solo envía los campos necesarios
    return {
      'medCmp': medCmp,
      'medNombre': medNombre,
      'medApellidos': medApellidos,
      'medEspecialidadId': medEspecialidadId,
    };
  }

  factory MedicoModel.fromEntity(Medico medico) {
    return MedicoModel(
      medCmp: medico.medCmp,
      medNombre: medico.medNombre,
      medApellidos: medico.medApellidos,
      medEspecialidadId: medico.medEspecialidadId,
      medEspecialidadNombre: medico.medEspecialidadNombre,
    );
  }
}
