import 'package:equatable/equatable.dart';
import '../../../domain/entities/medico.dart';

abstract class MedicoEvent extends Equatable {
  const MedicoEvent();
  @override
  List<Object?> get props => [];
}

class LoadMedicos extends MedicoEvent {}

class LoadMedicosByEspecialidad extends MedicoEvent {
  final int especialidadId;
  const LoadMedicosByEspecialidad(this.especialidadId);
  @override
  List<Object?> get props => [especialidadId];
}

class CreateMedicoEvent extends MedicoEvent {
  final Medico medico;
  const CreateMedicoEvent(this.medico);
  @override
  List<Object?> get props => [medico];
}

class UpdateMedicoEvent extends MedicoEvent {
  final Medico medico;
  const UpdateMedicoEvent(this.medico);
  @override
  List<Object?> get props => [medico];
}

class DeleteMedicoEvent extends MedicoEvent {
  final String cmp;
  const DeleteMedicoEvent(this.cmp);
  @override
  List<Object?> get props => [cmp];
}
