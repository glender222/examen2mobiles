import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/error/exceptions.dart';
import '../models/paciente_model.dart';

abstract class PacienteRemoteDataSource {
  Future<List<PacienteModel>> getAllPacientes();
  Future<PacienteModel> getPacienteByDni(String dni);
  Future<PacienteModel> createPaciente(PacienteModel paciente);
  Future<PacienteModel> updatePaciente(PacienteModel paciente);
  Future<void> deletePaciente(String dni);
  Future<List<PacienteModel>> searchPacientes(String query);
}

class PacienteRemoteDataSourceImpl implements PacienteRemoteDataSource {
  final DioClient dioClient;

  PacienteRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<PacienteModel>> getAllPacientes() async {
    try {
      final response = await dioClient.dio.get(ApiConstants.pacientes);
      return (response.data as List)
          .map((json) => PacienteModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener pacientes');
    }
  }

  @override
  Future<PacienteModel> getPacienteByDni(String dni) async {
    try {
      final response = await dioClient.dio.get('${ApiConstants.pacientes}/$dni');
      return PacienteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al obtener paciente');
    }
  }

  @override
  Future<PacienteModel> createPaciente(PacienteModel paciente) async {
    try {
      final response = await dioClient.dio.post(
        ApiConstants.pacientes,
        data: paciente.toJson(),
      );
      return PacienteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al crear paciente');
    }
  }

  @override
  Future<PacienteModel> updatePaciente(PacienteModel paciente) async {
    try {
      final response = await dioClient.dio.put(
        '${ApiConstants.pacientes}/${paciente.pacDni}',
        data: paciente.toJson(),
      );
      return PacienteModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al actualizar paciente');
    }
  }

  @override
  Future<void> deletePaciente(String dni) async {
    try {
      await dioClient.dio.delete('${ApiConstants.pacientes}/$dni');
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al eliminar paciente');
    }
  }

  @override
  Future<List<PacienteModel>> searchPacientes(String query) async {
    try {
      final response = await dioClient.dio.get(
        ApiConstants.pacienteBuscar,
        queryParameters: {'busqueda': query},
      );
      return (response.data as List)
          .map((json) => PacienteModel.fromJson(json))
          .toList();
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Error al buscar pacientes');
    }
  }
}
