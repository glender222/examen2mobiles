import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../blocs/historia_clinica/historia_clinica_bloc.dart';
import '../../blocs/historia_clinica/historia_clinica_event.dart';
import '../../blocs/historia_clinica/historia_clinica_state.dart';
import '../../blocs/paciente/paciente_bloc.dart';
import '../../blocs/paciente/paciente_event.dart';
import '../../blocs/paciente/paciente_state.dart';
import '../../blocs/medico/medico_bloc.dart';
import '../../blocs/medico/medico_event.dart';
import '../../blocs/medico/medico_state.dart';
import '../../../domain/entities/historia_clinica.dart';
import '../../../injection_container.dart';

class HistoriaFormPage extends StatelessWidget {
  final HistoriaClinica? historia;

  const HistoriaFormPage({super.key, this.historia});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<HistoriaClinicaBloc>()),
        BlocProvider(create: (_) => sl<PacienteBloc>()..add(LoadPacientes())),
        BlocProvider(create: (_) => sl<MedicoBloc>()..add(LoadMedicos())),
      ],
      child: _HistoriaFormView(historia: historia),
    );
  }
}

class _HistoriaFormView extends StatefulWidget {
  final HistoriaClinica? historia;

  const _HistoriaFormView({this.historia});

  @override
  State<_HistoriaFormView> createState() => _HistoriaFormViewState();
}

class _HistoriaFormViewState extends State<_HistoriaFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _diagnosticoController;
  late final TextEditingController _analisisController;
  late final TextEditingController _tratamientoController;
  String? _selectedPacienteDni;
  String? _selectedMedicoCmp;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _diagnosticoController = TextEditingController(
        text: widget.historia?.histDiagnostico);
    _analisisController = TextEditingController(
        text: widget.historia?.histAnalisis);
    _tratamientoController = TextEditingController(
        text: widget.historia?.histTratamiento);
    _selectedPacienteDni = widget.historia?.pacDni;
    _selectedMedicoCmp = widget.historia?.medCmp;
    if (widget.historia != null) {
      try {
        _selectedDate = DateFormat('yyyy-MM-dd')
            .parse(widget.historia!.histFechaAtencion);
      } catch (e) {
        _selectedDate = DateTime.now();
      }
    }
  }

  @override
  void dispose() {
    _diagnosticoController.dispose();
    _analisisController.dispose();
    _tratamientoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.historia != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing
            ? 'Editar Historia Clínica'
            : 'Nueva Historia Clínica'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<HistoriaClinicaBloc, HistoriaClinicaState>(
        listener: (context, state) {
          if (state is HistoriaClinicaOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is HistoriaClinicaError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is HistoriaClinicaLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Selector de Paciente
                  BlocBuilder<PacienteBloc, PacienteState>(
                    builder: (context, pacienteState) {
                      if (pacienteState is PacienteLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (pacienteState is PacienteLoaded) {
                        return DropdownButtonFormField<String>(
                          value: _selectedPacienteDni,
                          decoration: const InputDecoration(
                            labelText: 'Paciente',
                            prefixIcon: Icon(Icons.person),
                          ),
                          items: pacienteState.pacientes
                              .map((pac) => DropdownMenuItem<String>(
                                    value: pac.pacDni,
                                    child: Text(pac.nombreCompleto),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedPacienteDni = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Seleccione un paciente';
                            }
                            return null;
                          },
                        );
                      }

                      return const Text('Error al cargar pacientes');
                    },
                  ),
                  const SizedBox(height: 16),

                  // Selector de Médico
                  BlocBuilder<MedicoBloc, MedicoState>(
                    builder: (context, medicoState) {
                      if (medicoState is MedicoLoading) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }

                      if (medicoState is MedicoLoaded) {
                        return DropdownButtonFormField<String>(
                          value: _selectedMedicoCmp,
                          decoration: const InputDecoration(
                            labelText: 'Médico',
                            prefixIcon: Icon(Icons.local_hospital),
                          ),
                          items: medicoState.medicos
                              .map((med) => DropdownMenuItem<String>(
                                    value: med.medCmp,
                                    child: Text(med.nombreCompleto),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedMedicoCmp = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Seleccione un médico';
                            }
                            return null;
                          },
                        );
                      }

                      return const Text('Error al cargar médicos');
                    },
                  ),
                  const SizedBox(height: 16),

                  // Fecha de Atención
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Fecha de Atención'),
                    subtitle: Text(
                        DateFormat('dd/MM/yyyy').format(_selectedDate)),
                    leading: const Icon(Icons.calendar_today),
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedDate = date;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),

                  // Diagnóstico
                  TextFormField(
                    controller: _diagnosticoController,
                    decoration: const InputDecoration(
                      labelText: 'Diagnóstico',
                      prefixIcon: Icon(Icons.medical_information),
                    ),
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el diagnóstico';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Análisis
                  TextFormField(
                    controller: _analisisController,
                    decoration: const InputDecoration(
                      labelText: 'Análisis (Opcional)',
                      prefixIcon: Icon(Icons.analytics),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 16),

                  // Tratamiento
                  TextFormField(
                    controller: _tratamientoController,
                    decoration: const InputDecoration(
                      labelText: 'Tratamiento (Opcional)',
                      prefixIcon: Icon(Icons.medication),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),

                  FilledButton.icon(
                    onPressed: isLoading ? null : _submitForm,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2),
                          )
                        : const Icon(Icons.save),
                    label: Text(isEditing ? 'Actualizar' : 'Guardar'),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final historia = HistoriaClinica(
        histId: widget.historia?.histId,
        pacDni: _selectedPacienteDni!,
        medCmp: _selectedMedicoCmp!,
        histFechaAtencion: DateFormat('yyyy-MM-dd').format(_selectedDate),
        histDiagnostico: _diagnosticoController.text.trim(),
        histAnalisis: _analisisController.text.trim().isEmpty
            ? null
            : _analisisController.text.trim(),
        histTratamiento: _tratamientoController.text.trim().isEmpty
            ? null
            : _tratamientoController.text.trim(),
      );

      if (widget.historia != null) {
        context
            .read<HistoriaClinicaBloc>()
            .add(UpdateHistoriaEvent(historia));
      } else {
        context
            .read<HistoriaClinicaBloc>()
            .add(CreateHistoriaEvent(historia));
      }
    }
  }
}
