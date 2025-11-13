import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/especialidad/especialidad_bloc.dart';
import '../../blocs/especialidad/especialidad_event.dart';
import '../../blocs/especialidad/especialidad_state.dart';
import '../../../domain/entities/especialidad.dart';
import '../../../injection_container.dart';

class EspecialidadFormPage extends StatelessWidget {
  final Especialidad? especialidad;

  const EspecialidadFormPage({super.key, this.especialidad});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EspecialidadBloc>(),
      child: _EspecialidadFormView(especialidad: especialidad),
    );
  }
}

class _EspecialidadFormView extends StatefulWidget {
  final Especialidad? especialidad;

  const _EspecialidadFormView({this.especialidad});

  @override
  State<_EspecialidadFormView> createState() => _EspecialidadFormViewState();
}

class _EspecialidadFormViewState extends State<_EspecialidadFormView> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreController;
  late final TextEditingController _descripcionController;

  @override
  void initState() {
    super.initState();
    _nombreController = TextEditingController(text: widget.especialidad?.espNombre);
    _descripcionController = TextEditingController(text: widget.especialidad?.espDescripcion);
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEditing = widget.especialidad != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Especialidad' : 'Nueva Especialidad'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<EspecialidadBloc, EspecialidadState>(
        listener: (context, state) {
          if (state is EspecialidadOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.pop();
          } else if (state is EspecialidadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is EspecialidadLoading;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    controller: _nombreController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la Especialidad',
                      prefixIcon: Icon(Icons.medical_services),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese el nombre de la especialidad';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _descripcionController,
                    decoration: const InputDecoration(
                      labelText: 'Descripción (Opcional)',
                      prefixIcon: Icon(Icons.description),
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
      final especialidad = Especialidad(
        espId: widget.especialidad?.espId,
        espNombre: _nombreController.text.trim(),
        espDescripcion: _descripcionController.text.trim().isEmpty 
            ? null 
            : _descripcionController.text.trim(),
      );

      if (widget.especialidad != null) {
        context.read<EspecialidadBloc>().add(UpdateEspecialidadEvent(especialidad));
      } else {
        context.read<EspecialidadBloc>().add(CreateEspecialidadEvent(especialidad));
      }
    }
  }
}
