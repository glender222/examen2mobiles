import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/medico/medico_bloc.dart';
import '../../blocs/medico/medico_event.dart';
import '../../blocs/medico/medico_state.dart';
import '../../blocs/especialidad/especialidad_bloc.dart';
import '../../blocs/especialidad/especialidad_event.dart';
import '../../blocs/especialidad/especialidad_state.dart';
import '../../../domain/entities/medico.dart';
import '../../../injection_container.dart';

class MedicoFormPage extends StatelessWidget {
  final Medico? medico;

  const MedicoFormPage({super.key, this.medico});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MedicoBloc>()),
        BlocProvider(create: (_) => sl<EspecialidadBloc>()..add(LoadEspecialidades())),
      ],
      child: _MedicoFormView(medico: medico),
    );
  }
}

class _MedicoFormView extends StatefulWidget {
  final Medico? medico;

  const _MedicoFormView({this.medico});

  @override
  State<_MedicoFormView> createState() => _MedicoFormViewState();
}

class _MedicoFormViewState extends State<_MedicoFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _cmpController;
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidosController;
  int? _selectedEspecialidadId;

  @override
  void initState() {
    super.initState();
    _cmpController = TextEditingController(text: widget.medico?.medCmp);
    _nombreController = TextEditingController(text: widget.medico?.medNombre);
    _apellidosController = TextEditingController(text: widget.medico?.medApellidos);
    _selectedEspecialidadId = widget.medico?.medEspecialidadId;
  }

  @override
  void dispose() {
    _cmpController.dispose();
    _nombreController.dispose();
    _apellidosController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.medico != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Médico' : 'Nuevo Médico'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<MedicoBloc, MedicoState>(
        listener: (context, state) {
          if (state is MedicoOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is MedicoError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is MedicoLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _cmpController,
                    decoration: const InputDecoration(
                      labelText: 'CMP',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    enabled: !isEditing,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el CMP';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apellidosController,
                    decoration: const InputDecoration(
                      labelText: 'Apellidos',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese los apellidos';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<EspecialidadBloc, EspecialidadState>(
                    builder: (context, especialidadState) {
                      if (especialidadState is EspecialidadLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      if (especialidadState is EspecialidadLoaded) {
                        return DropdownButtonFormField<int>(
                          value: _selectedEspecialidadId,
                          decoration: const InputDecoration(
                            labelText: 'Especialidad',
                            prefixIcon: Icon(Icons.medical_services),
                          ),
                          items: especialidadState.especialidades
                              .map((esp) => DropdownMenuItem<int>(
                                    value: esp.espId,
                                    child: Text(esp.espNombre),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedEspecialidadId = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Seleccione una especialidad';
                            }
                            return null;
                          },
                        );
                      }

                      return const Text('Error al cargar especialidades');
                    },
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: isLoading ? null : _submitForm,
                    icon: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
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
      final medico = Medico(
        medCmp: _cmpController.text.trim(),
        medNombre: _nombreController.text.trim(),
        medApellidos: _apellidosController.text.trim(),
        medEspecialidadId: _selectedEspecialidadId!,
      );

      if (widget.medico != null) {
        context.read<MedicoBloc>().add(UpdateMedicoEvent(medico));
      } else {
        context.read<MedicoBloc>().add(CreateMedicoEvent(medico));
      }
    }
  }
}
