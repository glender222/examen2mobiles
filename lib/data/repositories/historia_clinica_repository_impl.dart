import 'package:dio/dio.dart';
import '../../domain/entities/historia_clinica.dart';
import '../../domain/repositories/historia_clinica_repository.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/historia_clinica_remote_data_source.dart';
import '../models/historia_clinica_model.dart';

class HistoriaClinicaRepositoryImpl implements HistoriaClinicaRepository {
  final HistoriaClinicaRemoteDataSource remoteDataSource;

  HistoriaClinicaRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<HistoriaClinica>>> getAllHistorias() async {
    try {
      final result = await remoteDataSource.getAllHistorias();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, HistoriaClinica>> getHistoriaById(int id) async {
    try {
      final result = await remoteDataSource.getHistoriaById(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, HistoriaClinica>> createHistoria(HistoriaClinica historia) async {
    try {
      final model = HistoriaClinicaModel.fromEntity(historia);
      final result = await remoteDataSource.createHistoria(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, HistoriaClinica>> updateHistoria(HistoriaClinica historia) async {
    try {
      final model = HistoriaClinicaModel.fromEntity(historia);
      final result = await remoteDataSource.updateHistoria(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteHistoria(int id) async {
    try {
      await remoteDataSource.deleteHistoria(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, List<HistoriaClinica>>> getHistoriasByPaciente(String dni) async {
    try {
      final result = await remoteDataSource.getHistoriasByPaciente(dni);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, List<HistoriaClinica>>> getHistoriasByMedico(String cmp) async {
    try {
      final result = await remoteDataSource.getHistoriasByMedico(cmp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }
}
