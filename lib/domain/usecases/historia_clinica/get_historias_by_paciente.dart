import '../../entities/historia_clinica.dart';
import '../../repositories/historia_clinica_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetHistoriasByPaciente {
  final HistoriaClinicaRepository repository;

  GetHistoriasByPaciente(this.repository);

  Future<Either<Failure, List<HistoriaClinica>>> call(String dni) async {
    return await repository.getHistoriasByPaciente(dni);
  }
}
