import '../entities/especialidad.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';

abstract class EspecialidadRepository {
  Future<Either<Failure, List<Especialidad>>> getAllEspecialidades();
  Future<Either<Failure, Especialidad>> getEspecialidadById(int id);
  Future<Either<Failure, Especialidad>> createEspecialidad(Especialidad especialidad);
  Future<Either<Failure, Especialidad>> updateEspecialidad(Especialidad especialidad);
  Future<Either<Failure, void>> deleteEspecialidad(int id);
}
