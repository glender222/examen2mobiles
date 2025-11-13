import '../../entities/medico.dart';
import '../../repositories/medico_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class CreateMedico {
  final MedicoRepository repository;

  CreateMedico(this.repository);

  Future<Either<Failure, Medico>> call(Medico medico) async {
    return await repository.createMedico(medico);
  }
}
