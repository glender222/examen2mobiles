import '../../entities/paciente.dart';
import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class CreatePaciente {
  final PacienteRepository repository;

  CreatePaciente(this.repository);

  Future<Either<Failure, Paciente>> call(Paciente paciente) async {
    return await repository.createPaciente(paciente);
  }
}
