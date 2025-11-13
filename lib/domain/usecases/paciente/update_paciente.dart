import '../../entities/paciente.dart';
import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class UpdatePaciente {
  final PacienteRepository repository;

  UpdatePaciente(this.repository);

  Future<Either<Failure, Paciente>> call(Paciente paciente) async {
    return await repository.updatePaciente(paciente);
  }
}
