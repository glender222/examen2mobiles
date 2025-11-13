import '../../entities/paciente.dart';
import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetAllPacientes {
  final PacienteRepository repository;

  GetAllPacientes(this.repository);

  Future<Either<Failure, List<Paciente>>> call() async {
    return await repository.getAllPacientes();
  }
}
