import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/medico/get_all_medicos.dart';
import '../../../domain/usecases/medico/create_medico.dart';
import '../../../domain/usecases/medico/update_medico.dart';
import '../../../domain/usecases/medico/delete_medico.dart';
import '../../../domain/usecases/medico/get_medicos_by_especialidad.dart';
import 'medico_event.dart';
import 'medico_state.dart';

class MedicoBloc extends Bloc<MedicoEvent, MedicoState> {
  final GetAllMedicos getAllMedicos;
  final CreateMedico createMedico;
  final UpdateMedico updateMedico;
  final DeleteMedico deleteMedico;
  final GetMedicosByEspecialidad getMedicosByEspecialidad;

  MedicoBloc({
    required this.getAllMedicos,
    required this.createMedico,
    required this.updateMedico,
    required this.deleteMedico,
    required this.getMedicosByEspecialidad,
  }) : super(MedicoInitial()) {
    on<LoadMedicos>(_onLoadMedicos);
    on<LoadMedicosByEspecialidad>(_onLoadMedicosByEspecialidad);
    on<CreateMedicoEvent>(_onCreateMedico);
    on<UpdateMedicoEvent>(_onUpdateMedico);
    on<DeleteMedicoEvent>(_onDeleteMedico);
  }

  Future<void> _onLoadMedicos(
    LoadMedicos event,
    Emitter<MedicoState> emit,
  ) async {
    emit(MedicoLoading());
    final result = await getAllMedicos();
    result.fold(
      (failure) => emit(MedicoError(failure.message)),
      (medicos) => emit(MedicoLoaded(medicos)),
    );
  }

  Future<void> _onLoadMedicosByEspecialidad(
    LoadMedicosByEspecialidad event,
    Emitter<MedicoState> emit,
  ) async {
    emit(MedicoLoading());
    final result = await getMedicosByEspecialidad(event.especialidadId);
    result.fold(
      (failure) => emit(MedicoError(failure.message)),
      (medicos) => emit(MedicoLoaded(medicos)),
    );
  }

  Future<void> _onCreateMedico(
    CreateMedicoEvent event,
    Emitter<MedicoState> emit,
  ) async {
    emit(MedicoLoading());
    final result = await createMedico(event.medico);
    result.fold(
      (failure) => emit(MedicoError(failure.message)),
      (_) => emit(const MedicoOperationSuccess('Médico creado exitosamente')),
    );
  }

  Future<void> _onUpdateMedico(
    UpdateMedicoEvent event,
    Emitter<MedicoState> emit,
  ) async {
    emit(MedicoLoading());
    final result = await updateMedico(event.medico);
    result.fold(
      (failure) => emit(MedicoError(failure.message)),
      (_) => emit(const MedicoOperationSuccess('Médico actualizado exitosamente')),
    );
  }

  Future<void> _onDeleteMedico(
    DeleteMedicoEvent event,
    Emitter<MedicoState> emit,
  ) async {
    emit(MedicoLoading());
    final result = await deleteMedico(event.cmp);
    result.fold(
      (failure) => emit(MedicoError(failure.message)),
      (_) => emit(const MedicoOperationSuccess('Médico eliminado exitosamente')),
    );
  }
}
