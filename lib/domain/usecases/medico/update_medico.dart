import '../../entities/medico.dart';
import '../../repositories/medico_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class UpdateMedico {
  final MedicoRepository repository;

  UpdateMedico(this.repository);

  Future<Either<Failure, Medico>> call(Medico medico) async {
    return await repository.updateMedico(medico);
  }
}
