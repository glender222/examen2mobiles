import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'data/datasources/paciente_remote_data_source.dart';
import 'data/datasources/especialidad_remote_data_source.dart';
import 'data/datasources/medico_remote_data_source.dart';
import 'data/datasources/historia_clinica_remote_data_source.dart';
import 'data/repositories/paciente_repository_impl.dart';
import 'data/repositories/especialidad_repository_impl.dart';
import 'data/repositories/medico_repository_impl.dart';
import 'data/repositories/historia_clinica_repository_impl.dart';
import 'domain/repositories/paciente_repository.dart';
import 'domain/repositories/especialidad_repository.dart';
import 'domain/repositories/medico_repository.dart';
import 'domain/repositories/historia_clinica_repository.dart';
import 'domain/usecases/paciente/get_all_pacientes.dart';
import 'domain/usecases/paciente/create_paciente.dart';
import 'domain/usecases/paciente/update_paciente.dart';
import 'domain/usecases/paciente/delete_paciente.dart';
import 'domain/usecases/especialidad/get_all_especialidades.dart';
import 'domain/usecases/especialidad/create_especialidad.dart';
import 'domain/usecases/especialidad/update_especialidad.dart';
import 'domain/usecases/especialidad/delete_especialidad.dart';
import 'domain/usecases/medico/get_all_medicos.dart';
import 'domain/usecases/medico/create_medico.dart';
import 'domain/usecases/medico/update_medico.dart';
import 'domain/usecases/medico/delete_medico.dart';
import 'domain/usecases/medico/get_medicos_by_especialidad.dart';
import 'domain/usecases/historia_clinica/get_all_historias.dart';
import 'domain/usecases/historia_clinica/create_historia.dart';
import 'domain/usecases/historia_clinica/update_historia.dart';
import 'domain/usecases/historia_clinica/delete_historia.dart';
import 'domain/usecases/historia_clinica/get_historias_by_paciente.dart';
import 'presentation/blocs/paciente/paciente_bloc.dart';
import 'presentation/blocs/especialidad/especialidad_bloc.dart';
import 'presentation/blocs/medico/medico_bloc.dart';
import 'presentation/blocs/historia_clinica/historia_clinica_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  sl.registerLazySingleton<PacienteRemoteDataSource>(
    () => PacienteRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<EspecialidadRemoteDataSource>(
    () => EspecialidadRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<MedicoRemoteDataSource>(
    () => MedicoRemoteDataSourceImpl(sl()),
  );
  sl.registerLazySingleton<HistoriaClinicaRemoteDataSource>(
    () => HistoriaClinicaRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<PacienteRepository>(
    () => PacienteRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<EspecialidadRepository>(
    () => EspecialidadRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<MedicoRepository>(
    () => MedicoRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<HistoriaClinicaRepository>(
    () => HistoriaClinicaRepositoryImpl(sl()),
  );

  // Use Cases - Paciente
  sl.registerLazySingleton(() => GetAllPacientes(sl()));
  sl.registerLazySingleton(() => CreatePaciente(sl()));
  sl.registerLazySingleton(() => UpdatePaciente(sl()));
  sl.registerLazySingleton(() => DeletePaciente(sl()));

  // Use Cases - Especialidad
  sl.registerLazySingleton(() => GetAllEspecialidades(sl()));
  sl.registerLazySingleton(() => CreateEspecialidad(sl()));
  sl.registerLazySingleton(() => UpdateEspecialidad(sl()));
  sl.registerLazySingleton(() => DeleteEspecialidad(sl()));

  // Use Cases - Medico
  sl.registerLazySingleton(() => GetAllMedicos(sl()));
  sl.registerLazySingleton(() => CreateMedico(sl()));
  sl.registerLazySingleton(() => UpdateMedico(sl()));
  sl.registerLazySingleton(() => DeleteMedico(sl()));
  sl.registerLazySingleton(() => GetMedicosByEspecialidad(sl()));

  // Use Cases - Historia Clinica
  sl.registerLazySingleton(() => GetAllHistorias(sl()));
  sl.registerLazySingleton(() => CreateHistoria(sl()));
  sl.registerLazySingleton(() => UpdateHistoria(sl()));
  sl.registerLazySingleton(() => DeleteHistoria(sl()));
  sl.registerLazySingleton(() => GetHistoriasByPaciente(sl()));

  // BLoCs
  sl.registerFactory(
    () => PacienteBloc(
      getAllPacientes: sl(),
      createPaciente: sl(),
      updatePaciente: sl(),
      deletePaciente: sl(),
    ),
  );

  sl.registerFactory(
    () => EspecialidadBloc(
      getAllEspecialidades: sl(),
      createEspecialidad: sl(),
      updateEspecialidad: sl(),
      deleteEspecialidad: sl(),
    ),
  );

  sl.registerFactory(
    () => MedicoBloc(
      getAllMedicos: sl(),
      createMedico: sl(),
      updateMedico: sl(),
      deleteMedico: sl(),
      getMedicosByEspecialidad: sl(),
    ),
  );

  sl.registerFactory(
    () => HistoriaClinicaBloc(
      getAllHistorias: sl(),
      createHistoria: sl(),
      updateHistoria: sl(),
      deleteHistoria: sl(),
      getHistoriasByPaciente: sl(),
    ),
  );
}
