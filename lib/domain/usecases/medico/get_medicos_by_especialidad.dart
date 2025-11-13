import '../../entities/medico.dart';
import '../../repositories/medico_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetMedicosByEspecialidad {
  final MedicoRepository repository;

  GetMedicosByEspecialidad(this.repository);

  Future<Either<Failure, List<Medico>>> call(int especialidadId) async {
    return await repository.getMedicosByEspecialidad(especialidadId);
  }
}
