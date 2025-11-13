import '../entities/paciente.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';

abstract class PacienteRepository {
  Future<Either<Failure, List<Paciente>>> getAllPacientes();
  Future<Either<Failure, Paciente>> getPacienteByDni(String dni);
  Future<Either<Failure, Paciente>> createPaciente(Paciente paciente);
  Future<Either<Failure, Paciente>> updatePaciente(Paciente paciente);
  Future<Either<Failure, void>> deletePaciente(String dni);
  Future<Either<Failure, List<Paciente>>> searchPacientes(String query);
}
