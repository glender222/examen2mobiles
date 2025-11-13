import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../blocs/historia_clinica/historia_clinica_bloc.dart';
import '../../blocs/historia_clinica/historia_clinica_event.dart';
import '../../blocs/historia_clinica/historia_clinica_state.dart';
import '../../../domain/entities/historia_clinica.dart';
import '../../../injection_container.dart';

class HistoriasPage extends StatelessWidget {
  const HistoriasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HistoriaClinicaBloc>()..add(LoadHistorias()),
      child: const _HistoriasView(),
    );
  }
}

class _HistoriasView extends StatelessWidget {
  const _HistoriasView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historias Clínicas'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: BlocConsumer<HistoriaClinicaBloc, HistoriaClinicaState>(
        listener: (context, state) {
          if (state is HistoriaClinicaOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<HistoriaClinicaBloc>().add(LoadHistorias());
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
          if (state is HistoriaClinicaLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HistoriaClinicaLoaded) {
            if (state.historias.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.description_outlined,
                         size: 64,
                         color: colorScheme.outline),
                    const SizedBox(height: 16),
                    Text(
                      'No hay historias clínicas registradas',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.historias.length,
              itemBuilder: (context, index) {
                final historia = state.historias[index];
                return _HistoriaCard(historia: historia);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await context.push('/historias/nuevo');
          if (context.mounted) {
            context.read<HistoriaClinicaBloc>().add(LoadHistorias());
          }
        },
        icon: const Icon(Icons.add),
        label: const Text('Nueva Historia'),
      ),
    );
  }
}

class _HistoriaCard extends StatelessWidget {
  final HistoriaClinica historia;

  const _HistoriaCard({required this.historia});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    
    String formattedDate = historia.histFechaAtencion;
    try {
      final date = DateFormat('yyyy-MM-dd').parse(historia.histFechaAtencion);
      formattedDate = DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      // Mantener formato original si hay error
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.errorContainer,
          child: Icon(Icons.description,
                     color: colorScheme.onErrorContainer),
        ),
        title: Text(historia.pacNombreCompleto ?? 'Paciente'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Fecha: $formattedDate'),
            Text('Médico: ${historia.medNombreCompleto ?? "No especificado"}'),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(
                  icon: Icons.medical_information,
                  label: 'Diagnóstico',
                  value: historia.histDiagnostico,
                ),
                if (historia.histAnalisis != null) ...[
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.analytics,
                    label: 'Análisis',
                    value: historia.histAnalisis!,
                  ),
                ],
                if (historia.histTratamiento != null) ...[
                  const SizedBox(height: 8),
                  _InfoRow(
                    icon: Icons.medication,
                    label: 'Tratamiento',
                    value: historia.histTratamiento!,
                  ),
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        context.push('/historias/editar',
                            extra: {'historia': historia});
                      },
                      icon: const Icon(Icons.edit),
                      label: const Text('Editar'),
                    ),
                    const SizedBox(width: 8),
                    TextButton.icon(
                      onPressed: () {
                        _showDeleteDialog(context, historia);
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Eliminar'),
                      style: TextButton.styleFrom(
                        foregroundColor: colorScheme.error,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, HistoriaClinica historia) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text(
            '¿Está seguro de eliminar esta historia clínica de ${historia.pacNombreCompleto}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              context
                  .read<HistoriaClinicaBloc>()
                  .add(DeleteHistoriaEvent(historia.histId!));
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(value),
            ],
          ),
        ),
      ],
    );
  }
}
