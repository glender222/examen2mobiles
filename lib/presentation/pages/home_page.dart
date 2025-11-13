import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Historias Clínicas'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildMenuCard(
            context,
            title: 'Pacientes',
            icon: Icons.people,
            color: colorScheme.primaryContainer,
            onTap: () => context.push('/pacientes'),
          ),
          _buildMenuCard(
            context,
            title: 'Especialidades',
            icon: Icons.medical_services,
            color: colorScheme.secondaryContainer,
            onTap: () => context.push('/especialidades'),
          ),
          _buildMenuCard(
            context,
            title: 'Médicos',
            icon: Icons.local_hospital,
            color: colorScheme.tertiaryContainer,
            onTap: () => context.push('/medicos'),
          ),
          _buildMenuCard(
            context,
            title: 'Historias Clínicas',
            icon: Icons.description,
            color: colorScheme.errorContainer,
            onTap: () => context.push('/historias'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      color: color,
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: Theme.of(context).colorScheme.onPrimaryContainer),
            const SizedBox(height: 16),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
