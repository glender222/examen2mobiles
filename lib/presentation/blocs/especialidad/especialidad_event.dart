import 'package:equatable/equatable.dart';
import '../../../domain/entities/especialidad.dart';

abstract class EspecialidadEvent extends Equatable {
  const EspecialidadEvent();
  @override
  List<Object?> get props => [];
}

class LoadEspecialidades extends EspecialidadEvent {}

class CreateEspecialidadEvent extends EspecialidadEvent {
  final Especialidad especialidad;
  const CreateEspecialidadEvent(this.especialidad);
  @override
  List<Object?> get props => [especialidad];
}

class UpdateEspecialidadEvent extends EspecialidadEvent {
  final Especialidad especialidad;
  const UpdateEspecialidadEvent(this.especialidad);
  @override
  List<Object?> get props => [especialidad];
}

class DeleteEspecialidadEvent extends EspecialidadEvent {
  final int id;
  const DeleteEspecialidadEvent(this.id);
  @override
  List<Object?> get props => [id];
}
