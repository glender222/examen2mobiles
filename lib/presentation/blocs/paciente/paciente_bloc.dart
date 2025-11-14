import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/paciente/get_all_pacientes.dart';
import '../../../domain/usecases/paciente/create_paciente.dart';
import '../../../domain/usecases/paciente/update_paciente.dart';
import '../../../domain/usecases/paciente/delete_paciente.dart';
import 'paciente_event.dart';
import 'paciente_state.dart';

class PacienteBloc extends Bloc<PacienteEvent, PacienteState> {
  final GetAllPacientes getAllPacientes;
  final CreatePaciente createPaciente;
  final UpdatePaciente updatePaciente;
  final DeletePaciente deletePaciente;

  PacienteBloc({
    required this.getAllPacientes,
    required this.createPaciente,
    required this.updatePaciente,
    required this.deletePaciente,
  }) : super(PacienteInitial()) {
    on<LoadPacientes>(_onLoadPacientes);
    on<CreatePacienteEvent>(_onCreatePaciente);
    on<UpdatePacienteEvent>(_onUpdatePaciente);
    on<DeletePacienteEvent>(_onDeletePaciente);
    on<SearchPacienteEvent>(_onSearchPaciente);
  }

  Future<void> _onLoadPacientes(
    LoadPacientes event,
    Emitter<PacienteState> emit,
  ) async {
    emit(PacienteLoading());
    final result = await getAllPacientes();
    result.fold(
      (failure) => emit(PacienteError(failure.message)),
      (pacientes) => emit(PacienteLoaded(
        allPacientes: pacientes,
        filteredPacientes: pacientes,
      )),
    );
  }

  Future<void> _onCreatePaciente(
    CreatePacienteEvent event,
    Emitter<PacienteState> emit,
  ) async {
    emit(PacienteLoading());
    final result = await createPaciente(event.paciente);
    result.fold(
      (failure) => emit(PacienteError(failure.message)),
      (_) => emit(const PacienteOperationSuccess('Paciente creado exitosamente')),
    );
  }

  Future<void> _onUpdatePaciente(
    UpdatePacienteEvent event,
    Emitter<PacienteState> emit,
  ) async {
    emit(PacienteLoading());
    final result = await updatePaciente(event.paciente);
    result.fold(
      (failure) => emit(PacienteError(failure.message)),
      (_) => emit(const PacienteOperationSuccess('Paciente actualizado exitosamente')),
    );
  }

  Future<void> _onDeletePaciente(
    DeletePacienteEvent event,
    Emitter<PacienteState> emit,
  ) async {
    emit(PacienteLoading());
    final result = await deletePaciente(event.dni);
    result.fold(
      (failure) => emit(PacienteError(failure.message)),
      (_) => emit(const PacienteOperationSuccess('Paciente eliminado exitosamente')),
    );
  }

  void _onSearchPaciente(
    SearchPacienteEvent event,
    Emitter<PacienteState> emit,
  ) {
    if (state is PacienteLoaded) {
      final currentState = state as PacienteLoaded;
      final query = event.query.toLowerCase();

      final filteredPacientes = currentState.allPacientes.where((paciente) {
        final nombreCompleto = paciente.nombreCompleto.toLowerCase();
        final dni = paciente.pacDni.toLowerCase();
        return nombreCompleto.contains(query) || dni.contains(query);
      }).toList();

      emit(currentState.copyWith(filteredPacientes: filteredPacientes));
    }
  }
}
