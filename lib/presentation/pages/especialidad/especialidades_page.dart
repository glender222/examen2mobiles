import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/especialidad/especialidad_bloc.dart';
import '../../blocs/especialidad/especialidad_event.dart';
import '../../blocs/especialidad/especialidad_state.dart';
import '../../../domain/entities/especialidad.dart';
import '../../../injection_container.dart';

class EspecialidadesPage extends StatelessWidget {
  const EspecialidadesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<EspecialidadBloc>()..add(LoadEspecialidades()),
      child: const _EspecialidadesView(),
    );
  }
}

class _EspecialidadesView extends StatelessWidget {
  const _EspecialidadesView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialidades'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<EspecialidadBloc, EspecialidadState>(
        listener: (context, state) {
          if (state is EspecialidadOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<EspecialidadBloc>().add(LoadEspecialidades());
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
          if (state is EspecialidadLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EspecialidadLoaded) {
            if (state.especialidades.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.medical_services_outlined, 
                         size: 64, 
                         color: colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'No hay especialidades registradas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.especialidades.length,
              itemBuilder: (context, index) {
                final especialidad = state.especialidades[index];
                return _EspecialidadCard(especialidad: especialidad);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/especialidades/nuevo');
          if (context.mounted) {
            context.read<EspecialidadBloc>().add(LoadEspecialidades());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nueva Especialidad'),
      ),
    );
  }
}

class _EspecialidadCard extends StatelessWidget {
  final Especialidad especialidad;

  const _EspecialidadCard({required this.especialidad});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.secondaryContainer,
          child: Icon(Icons.medical_services, 
                     color: colorScheme.onSecondaryContainer),
        ),
        title: Text(especialidad.espNombre),
        subtitle: especialidad.espDescripcion != null && 
                  especialidad.espDescripcion!.isNotEmpty
            ? Text(especialidad.espDescripcion!)
            : null,
        trailing: PopupMenuButton(
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit),
                  SizedBox(width: 8),
                  Text('Editar'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, color: Colors.red),
                  SizedBox(width: 8),
                  Text('Eliminar', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
          onSelected: (value) {
            if (value == 'edit') {
              context.push('/especialidades/editar', 
                          extra: {'especialidad': especialidad});
            } else if (value == 'delete') {
              _showDeleteDialog(context, especialidad);
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Especialidad especialidad) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Está seguro de eliminar la especialidad "${especialidad.espNombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<EspecialidadBloc>()
                  .add(DeleteEspecialidadEvent(especialidad.espId!));
              Navigator.pop(dialogContext);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}
