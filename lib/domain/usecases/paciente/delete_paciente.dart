import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class DeletePaciente {
  final PacienteRepository repository;

  DeletePaciente(this.repository);

  Future<Either<Failure, void>> call(String dni) async {
    return await repository.deletePaciente(dni);
  }
}
