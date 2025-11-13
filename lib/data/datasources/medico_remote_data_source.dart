import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/medico_model.dart';

abstract class MedicoRemoteDataSource {
  Future<List<MedicoModel>> getAllMedicos();
  Future<MedicoModel> getMedicoByCmp(String cmp);
  Future<MedicoModel> createMedico(MedicoModel medico);
  Future<MedicoModel> updateMedico(MedicoModel medico);
  Future<void> deleteMedico(String cmp);
  Future<List<MedicoModel>> searchMedicos(String query);
  Future<List<MedicoModel>> getMedicosByEspecialidad(int especialidadId);
}

class MedicoRemoteDataSourceImpl implements MedicoRemoteDataSource {
  final DioClient dioClient;

  MedicoRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<MedicoModel>> getAllMedicos() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.medicos);
      return (response.data as List)
          .map((json) => MedicoModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener médicos');
    }
  }

  @override
  Future<MedicoModel> getMedicoByCmp(String cmp) async {
    try {
      final response = await dioClient.dio.get('${ApiConstants.medicos}/$cmp');
      return MedicoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener médico');
    }
  }

  @override
  Future<MedicoModel> createMedico(MedicoModel medico) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.medicos,
        data: medico.toJson(),
      );
      return MedicoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al crear médico');
    }
  }

  @override
  Future<MedicoModel> updateMedico(MedicoModel medico) async {
    try {
      final response = await dioClient.dio.put(
        '${ApiConstants.medicos}/${medico.medCmp}',
        data: medico.toJson(),
      );
      return MedicoModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al actualizar médico');
    }
  }

  @override
  Future<void> deleteMedico(String cmp) async {
    try {
      await dioClient.dio.delete('${ApiConstants.medicos}/$cmp');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al eliminar médico');
    }
  }

  @override
  Future<List<MedicoModel>> searchMedicos(String query) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.medicoBuscar,
        queryParameters: {'busqueda': query},
      );
      return (response.data as List)
          .map((json) => MedicoModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al buscar médicos');
    }
  }

  @override
  Future<List<MedicoModel>> getMedicosByEspecialidad(int especialidadId) async {
    try {
      final response = await dioClient.dio.get(
        '${ApiConstants.medicosPorEspecialidad}/$especialidadId',
      );
      return (response.data as List)
          .map((json) => MedicoModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener médicos por especialidad');
    }
  }
}
