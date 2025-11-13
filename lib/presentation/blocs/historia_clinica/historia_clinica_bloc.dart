import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/historia_clinica/get_all_historias.dart';
import '../../../domain/usecases/historia_clinica/create_historia.dart';
import '../../../domain/usecases/historia_clinica/update_historia.dart';
import '../../../domain/usecases/historia_clinica/delete_historia.dart';
import '../../../domain/usecases/historia_clinica/get_historias_by_paciente.dart';
import 'historia_clinica_event.dart';
import 'historia_clinica_state.dart';

class HistoriaClinicaBloc extends Bloc<HistoriaClinicaEvent, HistoriaClinicaState> {
  final GetAllHistorias getAllHistorias;
  final CreateHistoria createHistoria;
  final UpdateHistoria updateHistoria;
  final DeleteHistoria deleteHistoria;
  final GetHistoriasByPaciente getHistoriasByPaciente;

  HistoriaClinicaBloc({
    required this.getAllHistorias,
    required this.createHistoria,
    required this.updateHistoria,
    required this.deleteHistoria,
    required this.getHistoriasByPaciente,
  }) : super(HistoriaClinicaInitial()) {
    on<LoadHistorias>(_onLoadHistorias);
    on<LoadHistoriasByPaciente>(_onLoadHistoriasByPaciente);
    on<CreateHistoriaEvent>(_onCreateHistoria);
    on<UpdateHistoriaEvent>(_onUpdateHistoria);
    on<DeleteHistoriaEvent>(_onDeleteHistoria);
  }

  Future<void> _onLoadHistorias(
    LoadHistorias event,
    Emitter<HistoriaClinicaState> emit,
  ) async {
    emit(HistoriaClinicaLoading());
    final result = await getAllHistorias();
    result.fold(
      (failure) => emit(HistoriaClinicaError(failure.message)),
      (historias) => emit(HistoriaClinicaLoaded(historias)),
    );
  }

  Future<void> _onLoadHistoriasByPaciente(
    LoadHistoriasByPaciente event,
    Emitter<HistoriaClinicaState> emit,
  ) async {
    emit(HistoriaClinicaLoading());
    final result = await getHistoriasByPaciente(event.dni);
    result.fold(
      (failure) => emit(HistoriaClinicaError(failure.message)),
      (historias) => emit(HistoriaClinicaLoaded(historias)),
    );
  }

  Future<void> _onCreateHistoria(
    CreateHistoriaEvent event,
    Emitter<HistoriaClinicaState> emit,
  ) async {
    emit(HistoriaClinicaLoading());
    final result = await createHistoria(event.historia);
    result.fold(
      (failure) => emit(HistoriaClinicaError(failure.message)),
      (_) => emit(const HistoriaClinicaOperationSuccess('Historia clínica creada exitosamente')),
    );
  }

  Future<void> _onUpdateHistoria(
    UpdateHistoriaEvent event,
    Emitter<HistoriaClinicaState> emit,
  ) async {
    emit(HistoriaClinicaLoading());
    final result = await updateHistoria(event.historia);
    result.fold(
      (failure) => emit(HistoriaClinicaError(failure.message)),
      (_) => emit(const HistoriaClinicaOperationSuccess('Historia clínica actualizada exitosamente')),
    );
  }

  Future<void> _onDeleteHistoria(
    DeleteHistoriaEvent event,
    Emitter<HistoriaClinicaState> emit,
  ) async {
    emit(HistoriaClinicaLoading());
    final result = await deleteHistoria(event.id);
    result.fold(
      (failure) => emit(HistoriaClinicaError(failure.message)),
      (_) => emit(const HistoriaClinicaOperationSuccess('Historia clínica eliminada exitosamente')),
    );
  }
}
