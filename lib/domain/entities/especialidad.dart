import 'package:equatable/equatable.dart';

class Especialidad extends Equatable {
  final int? espId;
  final String espNombre;
  final String? espDescripcion;

  const Especialidad({
    this.espId,
    required this.espNombre,
    this.espDescripcion,
  });

  @override
  List<Object?> get props => [espId, espNombre, espDescripcion];
}
