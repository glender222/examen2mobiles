import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/medico/medico_bloc.dart';
import '../../blocs/medico/medico_event.dart';
import '../../blocs/medico/medico_state.dart';
import '../../../domain/entities/medico.dart';
import '../../../injection_container.dart';

class MedicosPage extends StatelessWidget {
  const MedicosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MedicoBloc>()..add(LoadMedicos()),
      child: const _MedicosView(),
    );
  }
}

class _MedicosView extends StatelessWidget {
  const _MedicosView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Médicos'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<MedicoBloc, MedicoState>(
        listener: (context, state) {
          if (state is MedicoOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<MedicoBloc>().add(LoadMedicos());
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
          if (state is MedicoLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MedicoLoaded) {
            if (state.medicos.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.local_hospital_outlined,
                         size: 64,
                         color: colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'No hay médicos registrados',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.medicos.length,
              itemBuilder: (context, index) {
                final medico = state.medicos[index];
                return _MedicoCard(medico: medico);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/medicos/nuevo');
          if (context.mounted) {
            context.read<MedicoBloc>().add(LoadMedicos());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Médico'),
      ),
    );
  }
}

class _MedicoCard extends StatelessWidget {
  final Medico medico;

  const _MedicoCard({required this.medico});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.tertiaryContainer,
          child: Icon(Icons.local_hospital,
                     color: colorScheme.onTertiaryContainer),
        ),
        title: Text(medico.nombreCompleto),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('CMP: ${medico.medCmp}'),
            if (medico.medEspecialidadNombre != null)
              Text('Especialidad: ${medico.medEspecialidadNombre}'),
          ],
        ),
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
              context.push('/medicos/editar', extra: {'medico': medico});
            } else if (value == 'delete') {
              _showDeleteDialog(context, medico);
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Medico medico) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Está seguro de eliminar al médico "${medico.nombreCompleto}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<MedicoBloc>().add(DeleteMedicoEvent(medico.medCmp));
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
