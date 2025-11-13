import '../../repositories/historia_clinica_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class DeleteHistoria {
  final HistoriaClinicaRepository repository;

  DeleteHistoria(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteHistoria(id);
  }
}
