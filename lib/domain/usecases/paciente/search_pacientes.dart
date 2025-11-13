import '../../entities/paciente.dart';
import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class SearchPacientes {
  final PacienteRepository repository;

  SearchPacientes(this.repository);

  Future<Either<Failure, List<Paciente>>> call(String query) async {
    return await repository.searchPacientes(query);
  }
}
