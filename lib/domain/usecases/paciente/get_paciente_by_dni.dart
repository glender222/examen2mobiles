import '../../entities/paciente.dart';
import '../../repositories/paciente_repository.dart';
import '../../../core/utils/either.dart';
import '../../../core/error/failures.dart';

class GetPacienteByDni {
  final PacienteRepository repository;

  GetPacienteByDni(this.repository);

  Future<Either<Failure, Paciente>> call(String dni) async {
    return await repository.getPacienteByDni(dni);
  }
}
