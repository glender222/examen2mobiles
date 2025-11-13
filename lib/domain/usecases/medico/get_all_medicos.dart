import '../../entities/medico.dart';
import '../../repositories/medico_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetAllMedicos {
  final MedicoRepository repository;

  GetAllMedicos(this.repository);

  Future<Either<Failure, List<Medico>>> call() async {
    return await repository.getAllMedicos();
  }
}
