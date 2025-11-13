import 'package:go_router/go_router.dart';
import '../pages/paciente/pacientes_page.dart';
import '../pages/paciente/paciente_form_page.dart';
import '../pages/especialidad/especialidades_page.dart';
import '../pages/especialidad/especialidad_form_page.dart';
import '../pages/medico/medicos_page.dart';
import '../pages/medico/medico_form_page.dart';
import '../pages/historia_clinica/historias_page.dart';
import '../pages/historia_clinica/historia_form_page.dart';
import '../pages/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/pacientes',
      builder: (context, state) => const PacientesPage(),
    ),
    GoRoute(
      path: '/pacientes/nuevo',
      builder: (context, state) => const PacienteFormPage(),
    ),
    GoRoute(
      path: '/pacientes/editar',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return PacienteFormPage(paciente: extra?['paciente']);
      },
    ),
    GoRoute(
      path: '/especialidades',
      builder: (context, state) => const EspecialidadesPage(),
    ),
    GoRoute(
      path: '/especialidades/nuevo',
      builder: (context, state) => const EspecialidadFormPage(),
    ),
    GoRoute(
      path: '/especialidades/editar',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return EspecialidadFormPage(especialidad: extra?['especialidad']);
      },
    ),
    GoRoute(
      path: '/medicos',
      builder: (context, state) => const MedicosPage(),
    ),
    GoRoute(
      path: '/medicos/nuevo',
      builder: (context, state) => const MedicoFormPage(),
    ),
    GoRoute(
      path: '/medicos/editar',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return MedicoFormPage(medico: extra?['medico']);
      },
    ),
    GoRoute(
      path: '/historias',
      builder: (context, state) => const HistoriasPage(),
    ),
    GoRoute(
      path: '/historias/nuevo',
      builder: (context, state) => const HistoriaFormPage(),
    ),
    GoRoute(
      path: '/historias/editar',
      builder: (context, state) {
        final extra = state.extra as Map<String, dynamic>?;
        return HistoriaFormPage(historia: extra?['historia']);
      },
    ),
  ],
);
