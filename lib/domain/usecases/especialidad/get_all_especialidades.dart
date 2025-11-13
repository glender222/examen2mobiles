import '../../entities/especialidad.dart';
import '../../repositories/especialidad_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetAllEspecialidades {
  final EspecialidadRepository repository;

  GetAllEspecialidades(this.repository);

  Future<Either<Failure, List<Especialidad>>> call() async {
    return await repository.getAllEspecialidades();
  }
}
