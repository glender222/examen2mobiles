import 'package:dio/dio.dart';
import '../../domain/entities/especialidad.dart';
import '../../domain/repositories/especialidad_repository.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/especialidad_remote_data_source.dart';
import '../models/especialidad_model.dart';

class EspecialidadRepositoryImpl implements EspecialidadRepository {
  final EspecialidadRemoteDataSource remoteDataSource;

  EspecialidadRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Especialidad>>> getAllEspecialidades() async {
    try {
      final result = await remoteDataSource.getAllEspecialidades();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Especialidad>> getEspecialidadById(int id) async {
    try {
      final result = await remoteDataSource.getEspecialidadById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Especialidad>> createEspecialidad(Especialidad especialidad) async {
    try {
      final model = EspecialidadModel.fromEntity(especialidad);
      final result = await remoteDataSource.createEspecialidad(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Especialidad>> updateEspecialidad(Especialidad especialidad) async {
    try {
      final model = EspecialidadModel.fromEntity(especialidad);
      final result = await remoteDataSource.updateEspecialidad(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteEspecialidad(int id) async {
    try {
      await remoteDataSource.deleteEspecialidad(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }
}
