// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historia_clinica_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoriaClinicaModel _$HistoriaClinicaModelFromJson(
  Map<String, dynamic> json,
) => HistoriaClinicaModel(
  histId: (json['histId'] as num?)?.toInt(),
  pacDni: json['pacDni'] as String,
  pacNombreCompleto: json['pacNombreCompleto'] as String?,
  medCmp: json['medCmp'] as String,
  medNombreCompleto: json['medNombreCompleto'] as String?,
  medEspecialidad: json['medEspecialidad'] as String?,
  histFechaAtencion: json['histFechaAtencion'] as String,
  histDiagnostico: json['histDiagnostico'] as String,
  histAnalisis: json['histAnalisis'] as String?,
  histTratamiento: json['histTratamiento'] as String?,
);

Map<String, dynamic> _$HistoriaClinicaModelToJson(
  HistoriaClinicaModel instance,
) => <String, dynamic>{
  'histId': instance.histId,
  'pacDni': instance.pacDni,
  'pacNombreCompleto': instance.pacNombreCompleto,
  'medCmp': instance.medCmp,
  'medNombreCompleto': instance.medNombreCompleto,
  'medEspecialidad': instance.medEspecialidad,
  'histFechaAtencion': instance.histFechaAtencion,
  'histDiagnostico': instance.histDiagnostico,
  'histAnalisis': instance.histAnalisis,
  'histTratamiento': instance.histTratamiento,
};
