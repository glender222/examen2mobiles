import 'package:dio/dio.dart';
import '../../domain/entities/medico.dart';
import '../../domain/repositories/medico_repository.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../datasources/medico_remote_data_source.dart';
import '../models/medico_model.dart';

class MedicoRepositoryImpl implements MedicoRepository {
  final MedicoRemoteDataSource remoteDataSource;

  MedicoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<Medico>>> getAllMedicos() async {
    try {
      final result = await remoteDataSource.getAllMedicos();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Medico>> getMedicoByCmp(String cmp) async {
    try {
      final result = await remoteDataSource.getMedicoByCmp(cmp);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Medico>> createMedico(Medico medico) async {
    try {
      final model = MedicoModel.fromEntity(medico);
      final result = await remoteDataSource.createMedico(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, Medico>> updateMedico(Medico medico) async {
    try {
      final model = MedicoModel.fromEntity(medico);
      final result = await remoteDataSource.updateMedico(model);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMedico(String cmp) async {
    try {
      await remoteDataSource.deleteMedico(cmp);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, List<Medico>>> searchMedicos(String query) async {
    try {
      final result = await remoteDataSource.searchMedicos(query);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }

  @override
  Future<Either<Failure, List<Medico>>> getMedicosByEspecialidad(int especialidadId) async {
    try {
      final result = await remoteDataSource.getMedicosByEspecialidad(especialidadId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(NetworkFailure(e.message ?? 'Error de red'));
    }
  }
}
