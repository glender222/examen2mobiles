import '../../entities/historia_clinica.dart';
import '../../repositories/historia_clinica_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class UpdateHistoria {
  final HistoriaClinicaRepository repository;

  UpdateHistoria(this.repository);

  Future<Either<Failure, HistoriaClinica>> call(HistoriaClinica historia) async {
    return await repository.updateHistoria(historia);
  }
}
