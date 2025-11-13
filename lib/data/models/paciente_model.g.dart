// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paciente_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PacienteModel _$PacienteModelFromJson(Map<String, dynamic> json) =>
    PacienteModel(
      pacDni: json['pacDni'] as String,
      pacNombre: json['pacNombre'] as String,
      pacApellidoPaterno: json['pacApellidoPaterno'] as String,
      pacApellidoMaterno: json['pacApellidoMaterno'] as String,
      pacDireccion: json['pacDireccion'] as String?,
      pacTelefono: json['pacTelefono'] as String?,
    );

Map<String, dynamic> _$PacienteModelToJson(PacienteModel instance) =>
    <String, dynamic>{
      'pacDni': instance.pacDni,
      'pacNombre': instance.pacNombre,
      'pacApellidoPaterno': instance.pacApellidoPaterno,
      'pacApellidoMaterno': instance.pacApellidoMaterno,
      'pacDireccion': instance.pacDireccion,
      'pacTelefono': instance.pacTelefono,
    };
