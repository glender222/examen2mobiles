import '../entities/historia_clinica.dart';
import '../../core/utils/either.dart';
import '../../core/error/failures.dart';

abstract class HistoriaClinicaRepository {
  Future<Either<Failure, List<HistoriaClinica>>> getAllHistorias();
  Future<Either<Failure, HistoriaClinica>> getHistoriaById(int id);
  Future<Either<Failure, HistoriaClinica>> createHistoria(HistoriaClinica historia);
  Future<Either<Failure, HistoriaClinica>> updateHistoria(HistoriaClinica historia);
  Future<Either<Failure, void>> deleteHistoria(int id);
  Future<Either<Failure, List<HistoriaClinica>>> getHistoriasByPaciente(String dni);
  Future<Either<Failure, List<HistoriaClinica>>> getHistoriasByMedico(String cmp);
}
