import '../../entities/especialidad.dart';
import '../../repositories/especialidad_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class UpdateEspecialidad {
  final EspecialidadRepository repository;

  UpdateEspecialidad(this.repository);

  Future<Either<Failure, Especialidad>> call(Especialidad especialidad) async {
    return await repository.updateEspecialidad(especialidad);
  }
}
