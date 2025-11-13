import 'package:dio/dio.dart';
import '../../domain/entities/paciente.dart';
import '../../domain/repositories/paciente_repository.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/paciente_remote_data_source.dart';
import '../models/paciente_model.dart';

class PacienteRepositoryImpl implements PacienteRepository {
  final PacienteRemoteDataSource remoteDataSource;

  PacienteRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Paciente>>> getAllPacientes() async {
    try {
      final result = await remoteDataSource.getAllPacientes();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Paciente>> getPacienteByDni(String dni) async {
    try {
      final result = await remoteDataSource.getPacienteByDni(dni);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Paciente>> createPaciente(Paciente paciente) async {
    try {
      final model = PacienteModel.fromEntity(paciente);
      final result = await remoteDataSource.createPaciente(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Paciente>> updatePaciente(Paciente paciente) async {
    try {
      final model = PacienteModel.fromEntity(paciente);
      final result = await remoteDataSource.updatePaciente(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, void>> deletePaciente(String dni) async {
    try {
      await remoteDataSource.deletePaciente(dni);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, List<Paciente>>> searchPacientes(String query) async {
    try {
      final result = await remoteDataSource.searchPacientes(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }
}
