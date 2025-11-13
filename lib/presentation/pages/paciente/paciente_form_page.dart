import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/paciente/paciente_bloc.dart';
import '../../blocs/paciente/paciente_event.dart';
import '../../blocs/paciente/paciente_state.dart';
import '../../../domain/entities/paciente.dart';
import '../../../injection_container.dart';

class PacienteFormPage extends StatelessWidget {
  final Paciente? paciente;

  const PacienteFormPage({super.key, this.paciente});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PacienteBloc>(),
      child: _PacienteFormView(paciente: paciente),
    );
  }
}

class _PacienteFormView extends StatefulWidget {
  final Paciente? paciente;

  const _PacienteFormView({this.paciente});

  @override
  State<_PacienteFormView> createState() => _PacienteFormViewState();
}

class _PacienteFormViewState extends State<_PacienteFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _dniController;
  late final TextEditingController _nombreController;
  late final TextEditingController _apellidoPaternoController;
  late final TextEditingController _apellidoMaternoController;
  late final TextEditingController _direccionController;
  late final TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();
    _dniController = TextEditingController(text: widget.paciente?.pacDni);
    _nombreController = TextEditingController(text: widget.paciente?.pacNombre);
    _apellidoPaternoController = TextEditingController(text: widget.paciente?.pacApellidoPaterno);
    _apellidoMaternoController = TextEditingController(text: widget.paciente?.pacApellidoMaterno);
    _direccionController = TextEditingController(text: widget.paciente?.pacDireccion);
    _telefonoController = TextEditingController(text: widget.paciente?.pacTelefono);
  }

  @override
  void dispose() {
    _dniController.dispose();
    _nombreController.dispose();
    _apellidoPaternoController.dispose();
    _apellidoMaternoController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.paciente != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Paciente' : 'Nuevo Paciente'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<PacienteBloc, PacienteState>(
        listener: (context, state) {
          if (state is PacienteOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is PacienteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is PacienteLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _dniController,
                    decoration: const InputDecoration(
                      labelText: 'DNI',
                      prefixIcon: Icon(Icons.badge),
                    ),
                    enabled: !isEditing,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el DNI';
                      }
                      if (value.length != 8) {
                        return 'El DNI debe tener 8 dígitos';
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
                    controller: _apellidoPaternoController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido Paterno',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el apellido paterno';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _apellidoMaternoController,
                    decoration: const InputDecoration(
                      labelText: 'Apellido Materno',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el apellido materno';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _direccionController,
                    decoration: const InputDecoration(
                      labelText: 'Dirección (Opcional)',
                      prefixIcon: Icon(Icons.home),
                    ),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      labelText: 'Teléfono (Opcional)',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
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
      final paciente = Paciente(
        pacDni: _dniController.text.trim(),
        pacNombre: _nombreController.text.trim(),
        pacApellidoPaterno: _apellidoPaternoController.text.trim(),
        pacApellidoMaterno: _apellidoMaternoController.text.trim(),
        pacDireccion: _direccionController.text.trim().isEmpty ? null : _direccionController.text.trim(),
        pacTelefono: _telefonoController.text.trim().isEmpty ? null : _telefonoController.text.trim(),
      );

      if (widget.paciente != null) {
        context.read<PacienteBloc>().add(UpdatePacienteEvent(paciente));
      } else {
        context.read<PacienteBloc>().add(CreatePacienteEvent(paciente));
      }
    }
  }
}
