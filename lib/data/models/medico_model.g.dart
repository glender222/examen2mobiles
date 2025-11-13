// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medico_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicoModel _$MedicoModelFromJson(Map<String, dynamic> json) => MedicoModel(
  medCmp: json['medCmp'] as String,
  medNombre: json['medNombre'] as String,
  medApellidos: json['medApellidos'] as String,
  medEspecialidadId: (json['espeId'] as num).toInt(),
  medEspecialidadNombre: json['espeNombre'] as String?,
);

Map<String, dynamic> _$MedicoModelToJson(MedicoModel instance) =>
    <String, dynamic>{
      'medCmp': instance.medCmp,
      'medNombre': instance.medNombre,
      'medApellidos': instance.medApellidos,
      'espeId': instance.medEspecialidadId,
      'espeNombre': instance.medEspecialidadNombre,
    };
