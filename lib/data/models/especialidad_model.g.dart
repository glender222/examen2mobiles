// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'especialidad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EspecialidadModel _$EspecialidadModelFromJson(Map<String, dynamic> json) =>
    EspecialidadModel(
      espId: (json['espeId'] as num?)?.toInt(),
      espNombre: json['espeNombre'] as String,
      espDescripcion: json['espeDescripcion'] as String?,
    );

Map<String, dynamic> _$EspecialidadModelToJson(EspecialidadModel instance) =>
    <String, dynamic>{
      'espeId': instance.espId,
      'espeNombre': instance.espNombre,
      'espeDescripcion': instance.espDescripcion,
    };
