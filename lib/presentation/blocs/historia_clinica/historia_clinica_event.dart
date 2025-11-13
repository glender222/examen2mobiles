import 'package:equatable/equatable.dart';
import '../../../domain/entities/historia_clinica.dart';

abstract class HistoriaClinicaEvent extends Equatable {
  const HistoriaClinicaEvent();
  @override
  List<Object?> get props => [];
}

class LoadHistorias extends HistoriaClinicaEvent {}

class LoadHistoriasByPaciente extends HistoriaClinicaEvent {
  final String dni;
  const LoadHistoriasByPaciente(this.dni);
  @override
  List<Object?> get props => [dni];
}

class CreateHistoriaEvent extends HistoriaClinicaEvent {
  final HistoriaClinica historia;
  const CreateHistoriaEvent(this.historia);
  @override
  List<Object?> get props => [historia];
}

class UpdateHistoriaEvent extends HistoriaClinicaEvent {
  final HistoriaClinica historia;
  const UpdateHistoriaEvent(this.historia);
  @override
  List<Object?> get props => [historia];
}

class DeleteHistoriaEvent extends HistoriaClinicaEvent {
  final int id;
  const DeleteHistoriaEvent(this.id);
  @override
  List<Object?> get props => [id];
}
