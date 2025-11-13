import '../../entities/historia_clinica.dart';
import '../../repositories/historia_clinica_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class CreateHistoria {
  final HistoriaClinicaRepository repository;

  CreateHistoria(this.repository);

  Future<Either<Failure, HistoriaClinica>> call(HistoriaClinica historia) async {
    return await repository.createHistoria(historia);
  }
}
