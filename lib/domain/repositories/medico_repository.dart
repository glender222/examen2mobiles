import '../entities/medico.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';

abstract class MedicoRepository {
  Future<Either<Failure, List<Medico>>> getAllMedicos();
  Future<Either<Failure, Medico>> getMedicoByCmp(String cmp);
  Future<Either<Failure, Medico>> createMedico(Medico medico);
  Future<Either<Failure, Medico>> updateMedico(Medico medico);
  Future<Either<Failure, void>> deleteMedico(String cmp);
  Future<Either<Failure, List<Medico>>> searchMedicos(String query);
  Future<Either<Failure, List<Medico>>> getMedicosByEspecialidad(int especialidadId);
}
