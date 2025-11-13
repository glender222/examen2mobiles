import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/historia_clinica_model.dart';

abstract class HistoriaClinicaRemoteDataSource {
  Future<List<HistoriaClinicaModel>> getAllHistorias();
  Future<HistoriaClinicaModel> getHistoriaById(int id);
  Future<HistoriaClinicaModel> createHistoria(HistoriaClinicaModel historia);
  Future<HistoriaClinicaModel> updateHistoria(HistoriaClinicaModel historia);
  Future<void> deleteHistoria(int id);
  Future<List<HistoriaClinicaModel>> getHistoriasByPaciente(String dni);
  Future<List<HistoriaClinicaModel>> getHistoriasByMedico(String cmp);
}

class HistoriaClinicaRemoteDataSourceImpl implements HistoriaClinicaRemoteDataSource {
  final DioClient dioClient;

  HistoriaClinicaRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<HistoriaClinicaModel>> getAllHistorias() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.historiasClinicas);
      return (response.data as List)
          .map((json) => HistoriaClinicaModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener historias clínicas');
    }
  }

  @override
  Future<HistoriaClinicaModel> getHistoriaById(int id) async {
    try {
      final response = await dioClient.dio.get('${ApiConstants.historiasClinicas}/$id');
      return HistoriaClinicaModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener historia clínica');
    }
  }

  @override
  Future<HistoriaClinicaModel> createHistoria(HistoriaClinicaModel historia) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.historiasClinicas,
        data: historia.toJson(),
      );
      return HistoriaClinicaModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al crear historia clínica');
    }
  }

  @override
  Future<HistoriaClinicaModel> updateHistoria(HistoriaClinicaModel historia) async {
    try {
      final response = await dioClient.dio.put(
        '${ApiConstants.historiasClinicas}/${historia.histId}',
        data: historia.toJson(),
      );
      return HistoriaClinicaModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al actualizar historia clínica');
    }
  }

  @override
  Future<void> deleteHistoria(int id) async {
    try {
      await dioClient.dio.delete('${ApiConstants.historiasClinicas}/$id');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al eliminar historia clínica');
    }
  }

  @override
  Future<List<HistoriaClinicaModel>> getHistoriasByPaciente(String dni) async {
    try {
      final response = await dioClient.dio.get(
        '${ApiConstants.historiasPorPaciente}/$dni',
      );
      return (response.data as List)
          .map((json) => HistoriaClinicaModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener historias por paciente');
    }
  }

  @override
  Future<List<HistoriaClinicaModel>> getHistoriasByMedico(String cmp) async {
    try {
      final response = await dioClient.dio.get(
        '${ApiConstants.historiasPorMedico}/$cmp',
      );
      return (response.data as List)
          .map((json) => HistoriaClinicaModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener historias por médico');
    }
  }
}
