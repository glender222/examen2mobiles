import 'package:equatable/equatable.dart';
import '../../../domain/entities/historia_clinica.dart';

abstract class HistoriaClinicaState extends Equatable {
  const HistoriaClinicaState();
  @override
  List<Object?> get props => [];
}

class HistoriaClinicaInitial extends HistoriaClinicaState {}

class HistoriaClinicaLoading extends HistoriaClinicaState {}

class HistoriaClinicaLoaded extends HistoriaClinicaState {
  final List<HistoriaClinica> historias;
  const HistoriaClinicaLoaded(this.historias);
  @override
  List<Object?> get props => [historias];
}

class HistoriaClinicaOperationSuccess extends HistoriaClinicaState {
  final String message;
  const HistoriaClinicaOperationSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class HistoriaClinicaError extends HistoriaClinicaState {
  final String message;
  const HistoriaClinicaError(this.message);
  @override
  List<Object?> get props => [message];
}
