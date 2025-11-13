import '../../entities/historia_clinica.dart';
import '../../repositories/historia_clinica_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetAllHistorias {
  final HistoriaClinicaRepository repository;

  GetAllHistorias(this.repository);

  Future<Either<Failure, List<HistoriaClinica>>> call() async {
    return await repository.getAllHistorias();
  }
}
