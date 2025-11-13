import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/paciente.dart';

part 'paciente_model.g.dart';

@JsonSerializable()
class PacienteModel extends Paciente {
  const PacienteModel({
    required super.pacDni,
    required super.pacNombre,
    required super.pacApellidoPaterno,
    required super.pacApellidoMaterno,
    super.pacDireccion,
    super.pacTelefono,
  });

  factory PacienteModel.fromJson(Map<String, dynamic> json) =>
      _$PacienteModelFromJson(json);

  Map<String, dynamic> toJson() => _$PacienteModelToJson(this);

  factory PacienteModel.fromEntity(Paciente paciente) {
    return PacienteModel(
      pacDni: paciente.pacDni,
      pacNombre: paciente.pacNombre,
      pacApellidoPaterno: paciente.pacApellidoPaterno,
      pacApellidoMaterno: paciente.pacApellidoMaterno,
      pacDireccion: paciente.pacDireccion,
      pacTelefono: paciente.pacTelefono,
    );
  }
}
