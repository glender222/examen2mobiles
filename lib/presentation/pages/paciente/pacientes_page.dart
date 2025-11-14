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

class _PacientesView extends StatefulWidget {
  const _PacientesView();

  @override
  State<_PacientesView> createState() => _PacientesViewState();
}

class _PacientesViewState extends State<_PacientesView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    context.read<PacienteBloc>().add(SearchPacienteEvent(_searchController.text));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'Buscar paciente por nombre o DNI...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: BlocConsumer<PacienteBloc, PacienteState>(
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
                  if (state.filteredPacientes.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.people_outline, size: 64, color: colorScheme.outline),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'No hay pacientes registrados'
                                : 'No se encontraron pacientes',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: state.filteredPacientes.length,
                    itemBuilder: (context, index) {
                      final paciente = state.filteredPacientes[index];
                      return _PacienteCard(paciente: paciente);
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ],
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: colorScheme.primary,
              child: const Icon(Icons.person, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    paciente.nombreCompleto,
                    style: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'DNI: ${paciente.pacDni}',
                    style: textTheme.bodyMedium,
                  ),
                  if (paciente.pacTelefono != null)
                    Text(
                      'Tel: ${paciente.pacTelefono}',
                      style: textTheme.bodyMedium,
                    ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  context.push('/pacientes/editar', extra: {'paciente': paciente});
                } else if (value == 'delete') {
                  _showDeleteDialog(context, paciente);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Editar'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, Paciente paciente) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar Eliminación'),
        content: Text('¿Está seguro de que desea eliminar a ${paciente.nombreCompleto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context.read<PacienteBloc>().add(DeletePacienteEvent(paciente.pacDni));
              Navigator.of(dialogContext).pop();
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
