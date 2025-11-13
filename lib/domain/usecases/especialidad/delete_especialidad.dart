import '../../repositories/especialidad_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class DeleteEspecialidad {
  final EspecialidadRepository repository;

  DeleteEspecialidad(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteEspecialidad(id);
  }
}
