import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../blocs/paciente/paciente_bloc.dart';
import '../../blocs/paciente/paciente_event.dart';
import '../../blocs/paciente/paciente_state.dart';
import '../../../domain/entities/paciente.dart';
import '../../../injection_container.dart';

class PacientesPage extends StatelessWidget {
  const PacientesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PacienteBloc>()..add(LoadPacientes()),
      child: const _PacientesView(),
    );
  }
}

class _PacientesView extends StatelessWidget {
  const _PacientesView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<PacienteBloc, PacienteState>(
        listener: (context, state) {
          if (state is PacienteOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<PacienteBloc>().add(LoadPacientes());
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
          if (state is PacienteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is PacienteLoaded) {
            if (state.pacientes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.people_outline, size: 64, color: colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'No hay pacientes registrados',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.pacientes.length,
              itemBuilder: (context, index) {
                final paciente = state.pacientes[index];
                return _PacienteCard(paciente: paciente);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/pacientes/nuevo');
          if (context.mounted) {
            context.read<PacienteBloc>().add(LoadPacientes());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Paciente'),
      ),
    );
  }
}

class _PacienteCard extends StatelessWidget {
  final Paciente paciente;

  const _PacienteCard({required this.paciente});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Icon(Icons.person, color: colorScheme.onPrimaryContainer),
        ),
        title: Text(paciente.nombreCompleto),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('DNI: ${paciente.pacDni}'),
            if (paciente.pacTelefono != null) Text('Tel: ${paciente.pacTelefono}'),
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
              context.push('/pacientes/editar', extra: {'paciente': paciente});
            } else if (value == 'delete') {
              _showDeleteDialog(context, paciente);
            }
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Paciente paciente) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Está seguro de eliminar a ${paciente.nombreCompleto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<PacienteBloc>().add(DeletePacienteEvent(paciente.pacDni));
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
