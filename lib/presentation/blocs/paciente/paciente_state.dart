import 'package:equatable/equatable.dart';
import '../../../domain/entities/paciente.dart';

abstract class PacienteState extends Equatable {
  const PacienteState();

  @override
  List<Object?> get props => [];
}

class PacienteInitial extends PacienteState {}

class PacienteLoading extends PacienteState {}

class PacienteLoaded extends PacienteState {
  final List<Paciente> allPacientes;
  final List<Paciente> filteredPacientes;

  const PacienteLoaded({
    required this.allPacientes,
    required this.filteredPacientes,
  });

  @override
  List<Object?> get props => [allPacientes, filteredPacientes];

  PacienteLoaded copyWith({
    List<Paciente>? allPacientes,
    List<Paciente>? filteredPacientes,
  }) {
    return PacienteLoaded(
      allPacientes: allPacientes ?? this.allPacientes,
      filteredPacientes: filteredPacientes ?? this.filteredPacientes,
    );
  }
}

class PacienteOperationSuccess extends PacienteState {
  final String message;

  const PacienteOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class PacienteError extends PacienteState {
  final String message;

  const PacienteError(this.message);

  @override
  List<Object?> get props => [message];
}
