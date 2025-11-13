import 'package:equatable/equatable.dart';
import '../../../domain/entities/especialidad.dart';

abstract class EspecialidadState extends Equatable {
  const EspecialidadState();
  @override
  List<Object?> get props => [];
}

class EspecialidadInitial extends EspecialidadState {}

class EspecialidadLoading extends EspecialidadState {}

class EspecialidadLoaded extends EspecialidadState {
  final List<Especialidad> especialidades;
  const EspecialidadLoaded(this.especialidades);
  @override
  List<Object?> get props => [especialidades];
}

class EspecialidadOperationSuccess extends EspecialidadState {
  final String message;
  const EspecialidadOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class EspecialidadError extends EspecialidadState {
  final String message;
  const EspecialidadError(this.message);
  @override
  List<Object?> get props => [message];
}
