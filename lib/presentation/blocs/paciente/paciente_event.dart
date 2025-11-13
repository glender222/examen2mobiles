import 'package:equatable/equatable.dart';
import '../../../domain/entities/paciente.dart';

abstract class PacienteEvent extends Equatable {
  const PacienteEvent();

  @override
  List<Object?> get props => [];
}

class LoadPacientes extends PacienteEvent {}

class CreatePacienteEvent extends PacienteEvent {
  final Paciente paciente;

  const CreatePacienteEvent(this.paciente);

  @override
  List<Object?> get props => [paciente];
}

class UpdatePacienteEvent extends PacienteEvent {
  final Paciente paciente;

  const UpdatePacienteEvent(this.paciente);

  @override
  List<Object?> get props => [paciente];
}

class DeletePacienteEvent extends PacienteEvent {
  final String dni;

  const DeletePacienteEvent(this.dni);

  @override
  List<Object?> get props => [dni];
}
