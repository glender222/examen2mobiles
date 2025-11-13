import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/especialidad.dart';

part 'especialidad_model.g.dart';

@JsonSerializable()
class EspecialidadModel extends Especialidad {
  @JsonKey(name: 'espeId')
  @override
  final int? espId;

  @JsonKey(name: 'espeNombre')
  @override
  final String espNombre;

  @JsonKey(name: 'espeDescripcion')
  @override
  final String? espDescripcion;

  const EspecialidadModel({
    this.espId,
    required this.espNombre,
    this.espDescripcion,
  }) : super(
          espId: espId,
          espNombre: espNombre,
          espDescripcion: espDescripcion,
        );

  factory EspecialidadModel.fromJson(Map<String, dynamic> json) =>
      _$EspecialidadModelFromJson(json);

  Map<String, dynamic> toJson() {
    // Para enviar al backend (con nombres que Spring Boot espera)
    final map = <String, dynamic>{
      'espeNombre': espNombre,  // Backend espera "espeNombre"
    };
    
    if (espId != null) {
      map['espeId'] = espId;  // Backend espera "espeId"
    }
    
    if (espDescripcion != null) {
      map['espeDescripcion'] = espDescripcion;  // Backend espera "espeDescripcion"
    }
    
    return map;
  }

  factory EspecialidadModel.fromEntity(Especialidad especialidad) {
    return EspecialidadModel(
      espId: especialidad.espId,
      espNombre: especialidad.espNombre,
      espDescripcion: especialidad.espDescripcion,
    );
  }
}
