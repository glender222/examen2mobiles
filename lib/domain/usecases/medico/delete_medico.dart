import '../../repositories/medico_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class DeleteMedico {
  final MedicoRepository repository;

  DeleteMedico(this.repository);

  Future<Either<Failure, void>> call(String cmp) async {
    return await repository.deleteMedico(cmp);
  }
}
