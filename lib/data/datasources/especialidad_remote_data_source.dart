import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/especialidad_model.dart';

abstract class EspecialidadRemoteDataSource {
  Future<List<EspecialidadModel>> getAllEspecialidades();
  Future<EspecialidadModel> getEspecialidadById(int id);
  Future<EspecialidadModel> createEspecialidad(EspecialidadModel especialidad);
  Future<EspecialidadModel> updateEspecialidad(EspecialidadModel especialidad);
  Future<void> deleteEspecialidad(int id);
}

class EspecialidadRemoteDataSourceImpl implements EspecialidadRemoteDataSource {
  final DioClient dioClient;

  EspecialidadRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<EspecialidadModel>> getAllEspecialidades() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.especialidades);
      return (response.data as List)
          .map((json) => EspecialidadModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener especialidades');
    }
  }

  @override
  Future<EspecialidadModel> getEspecialidadById(int id) async {
    try {
      final response = await dioClient.dio.get('${ApiConstants.especialidades}/$id');
      return EspecialidadModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener especialidad');
    }
  }

  @override
  Future<EspecialidadModel> createEspecialidad(EspecialidadModel especialidad) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.especialidades,
        data: especialidad.toJson(),
      );
      return EspecialidadModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al crear especialidad');
    }
  }

  @override
  Future<EspecialidadModel> updateEspecialidad(EspecialidadModel especialidad) async {
    try {
      final response = await dioClient.dio.put(
        '${ApiConstants.especialidades}/${especialidad.espId}',
        data: especialidad.toJson(),
      );
      return EspecialidadModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al actualizar especialidad');
    }
  }

  @override
  Future<void> deleteEspecialidad(int id) async {
    try {
      await dioClient.dio.delete('${ApiConstants.especialidades}/$id');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al eliminar especialidad');
    }
  }
}
