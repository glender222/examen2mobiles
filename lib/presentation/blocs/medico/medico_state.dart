import 'package:equatable/equatable.dart';
import '../../../domain/entities/medico.dart';

abstract class MedicoState extends Equatable {
  const MedicoState();
  @override
  List<Object?> get props => [];
}

class MedicoInitial extends MedicoState {}

class MedicoLoading extends MedicoState {}

class MedicoLoaded extends MedicoState {
  final List<Medico> medicos;
  const MedicoLoaded(this.medicos);
  @override
  List<Object?> get props => [medicos];
}

class MedicoOperationSuccess extends MedicoState {
  final String message;
  const MedicoOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class MedicoError extends MedicoState {
  final String message;
  const MedicoError(this.message);
  @override
  List<Object?> get props => [message];
}
