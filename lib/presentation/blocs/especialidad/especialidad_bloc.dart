import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/especialidad/get_all_especialidades.dart';
import '../../../domain/usecases/especialidad/create_especialidad.dart';
import '../../../domain/usecases/especialidad/update_especialidad.dart';
import '../../../domain/usecases/especialidad/delete_especialidad.dart';
import 'especialidad_event.dart';
import 'especialidad_state.dart';

class EspecialidadBloc extends Bloc<EspecialidadEvent, EspecialidadState> {
  final GetAllEspecialidades getAllEspecialidades;
  final CreateEspecialidad createEspecialidad;
  final UpdateEspecialidad updateEspecialidad;
  final DeleteEspecialidad deleteEspecialidad;

  EspecialidadBloc({
    required this.getAllEspecialidades,
    required this.createEspecialidad,
    required this.updateEspecialidad,
    required this.deleteEspecialidad,
  }) : super(EspecialidadInitial()) {
    on<LoadEspecialidades>(_onLoadEspecialidades);
    on<CreateEspecialidadEvent>(_onCreateEspecialidad);
    on<UpdateEspecialidadEvent>(_onUpdateEspecialidad);
    on<DeleteEspecialidadEvent>(_onDeleteEspecialidad);
  }

  Future<void> _onLoadEspecialidades(
    LoadEspecialidades event,
    Emitter<EspecialidadState> emit,
  ) async {
    emit(EspecialidadLoading());
    final result = await getAllEspecialidades();
    result.fold(
      (failure) => emit(EspecialidadError(failure.message)),
      (especialidades) => emit(EspecialidadLoaded(especialidades)),
    );
  }

  Future<void> _onCreateEspecialidad(
    CreateEspecialidadEvent event,
    Emitter<EspecialidadState> emit,
  ) async {
    emit(EspecialidadLoading());
    final result = await createEspecialidad(event.especialidad);
    result.fold(
      (failure) => emit(EspecialidadError(failure.message)),
      (_) => emit(const EspecialidadOperationSuccess('Especialidad creada exitosamente')),
    );
  }

  Future<void> _onUpdateEspecialidad(
    UpdateEspecialidadEvent event,
    Emitter<EspecialidadState> emit,
  ) async {
    emit(EspecialidadLoading());
    final result = await updateEspecialidad(event.especialidad);
    result.fold(
      (failure) => emit(EspecialidadError(failure.message)),
      (_) => emit(const EspecialidadOperationSuccess('Especialidad actualizada exitosamente')),
    );
  }

  Future<void> _onDeleteEspecialidad(
    DeleteEspecialidadEvent event,
    Emitter<EspecialidadState> emit,
  ) async {
    emit(EspecialidadLoading());
    final result = await deleteEspecialidad(event.id);
    result.fold(
      (failure) => emit(EspecialidadError(failure.message)),
      (_) => emit(const EspecialidadOperationSuccess('Especialidad eliminada exitosamente')),
    );
  }
}
