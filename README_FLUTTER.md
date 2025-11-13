# Sistema de Historias Clínicas - Flutter

Aplicación Flutter para gestión de historias clínicas con Clean Architecture y Material Design 3.

## 🏗️ Arquitectura

El proyecto sigue **Clean Architecture** con 3 capas principales:

### 📁 Estructura del Proyecto

```
lib/
├── core/                       # Núcleo compartido
│   ├── constants/             # Constantes (API endpoints)
│   ├── error/                 # Manejo de errores
│   ├── network/               # Cliente HTTP (Dio)
│   ├── theme/                 # Temas Material Design 3
│   └── utils/                 # Utilidades (Either)
│
├── domain/                     # Capa de Dominio (Lógica de Negocio)
│   ├── entities/              # Entidades del negocio
│   ├── repositories/          # Interfaces de repositorios
│   └── usecases/              # Casos de uso
│       ├── paciente/
│       ├── especialidad/
│       ├── medico/
│       └── historia_clinica/
│
├── data/                       # Capa de Datos
│   ├── models/                # Modelos con serialización JSON
│   ├── datasources/           # Fuentes de datos remotas
│   └── repositories/          # Implementaciones de repositorios
│
└── presentation/               # Capa de Presentación (UI)
    ├── blocs/                 # BLoC (State Management)
    │   ├── paciente/
    │   ├── especialidad/
    │   ├── medico/
    │   └── historia_clinica/
    ├── pages/                 # Páginas de la aplicación
    │   ├── paciente/
    │   ├── especialidad/
    │   ├── medico/
    │   └── historia_clinica/
    ├── widgets/               # Widgets reutilizables
    └── router/                # Navegación con GoRouter
```

## 🚀 Características

✅ **Clean Architecture** - Separación clara de responsabilidades  
✅ **Material Design 3** - UI moderna con ColorScheme  
✅ **BLoC Pattern** - Gestión de estado reactiva  
✅ **Dependency Injection** - GetIt para inyección de dependencias  
✅ **API REST** - Integración con backend Spring Boot mediante Dio  
✅ **CRUD Completo** - Listar, crear, editar y eliminar  
✅ **Navegación** - GoRouter para enrutamiento declarativo  
✅ **Manejo de Errores** - Sistema robusto de Either<Failure, Success>  
✅ **JSON Serialization** - Automática con json_serializable  

## 📦 Dependencias Principales

```yaml
dependencies:
  dio: ^5.3.3                  # Cliente HTTP
  flutter_bloc: ^8.1.3         # State Management
  equatable: ^2.0.5            # Comparación de objetos
  get_it: ^7.6.4               # Dependency Injection
  go_router: ^12.1.3           # Navegación
  json_annotation: ^4.9.0      # Serialización JSON
  intl: ^0.18.1                # Internacionalización

dev_dependencies:
  build_runner: ^2.4.6         # Generación de código
  json_serializable: ^6.7.1    # Generador JSON
```

## 🔧 Configuración

### 1. Configurar la URL del Backend

Editar `lib/core/constants/api_constants.dart`:

```dart
static const String baseUrl = 'http://localhost:8080/api';
// Para dispositivo físico Android: 'http://TU_IP:8080/api'
// Para emulador Android: 'http://10.0.2.2:8080/api'
```

### 2. Instalar Dependencias

```bash
flutter pub get
```

### 3. Generar Código de Serialización

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## 🏃‍♂️ Ejecución

### Ejecutar en modo debug
```bash
flutter run
```

### Ejecutar en modo release
```bash
flutter run --release
```

### Ejecutar en web
```bash
flutter run -d chrome
```

## 📱 Módulos Implementados

### 1. **Pacientes** ✅ COMPLETO
- ✅ Listar pacientes
- ✅ Crear paciente
- ✅ Editar paciente
- ✅ Eliminar paciente
- ✅ Validación de formularios
- ✅ Manejo de errores

### 2. **Especialidades** 🔨 BÁSICO
- ✅ Listar especialidades
- ⚠️ Crear especialidad (stub)
- ⚠️ Editar especialidad (stub)
- ⚠️ Eliminar especialidad (stub)

### 3. **Médicos** 🔨 BÁSICO
- ✅ Listar médicos
- ⚠️ Crear médico (stub)
- ⚠️ Editar médico (stub)
- ⚠️ Eliminar médico (stub)

### 4. **Historias Clínicas** 🔨 BÁSICO
- ✅ Listar historias
- ⚠️ Crear historia (stub)
- ⚠️ Editar historia (stub)
- ⚠️ Eliminar historia (stub)

> **Nota**: Los módulos marcados con ⚠️ tienen la estructura completa (BLoC, UseCases, etc.) pero requieren implementar el formulario UI siguiendo el patrón de `PacienteFormPage`.

## 🎨 Material Design 3

La aplicación usa **Material Design 3** con:
- ColorScheme automático basado en color semilla
- Tema claro y oscuro
- Componentes modernos (Cards, FAB, AppBar)
- Elevación y sombras consistentes

## 🔄 Flujo de Datos (Clean Architecture)

```
UI (Pages/Widgets)
    ↓ Events
[BLoC] ← State Management
    ↓ Calls
[UseCases] ← Business Logic
    ↓ Calls
[Repository Interface] ← Domain Layer
    ↑ Implements
[Repository Implementation] ← Data Layer
    ↓ Calls
[DataSource] ← API/Network
    ↓
[API REST Backend]
```

## 🧪 Testing

```bash
# Ejecutar tests unitarios
flutter test

# Ejecutar tests con cobertura
flutter test --coverage
```

## 📝 Ejemplo de Uso del BLoC

```dart
// En tu página
BlocConsumer<PacienteBloc, PacienteState>(
  listener: (context, state) {
    if (state is PacienteOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  builder: (context, state) {
    if (state is PacienteLoading) {
      return CircularProgressIndicator();
    }
    if (state is PacienteLoaded) {
      return ListView.builder(...);
    }
    return SizedBox.shrink();
  },
)

// Disparar eventos
context.read<PacienteBloc>().add(LoadPacientes());
context.read<PacienteBloc>().add(CreatePacienteEvent(paciente));
```

## 🔐 Conectarse al Backend

Asegúrate de que el backend Spring Boot esté corriendo en `http://localhost:8080` antes de ejecutar la aplicación.

Ver documentación del backend en `README_API.md`.

## 📚 Recursos Adicionales

- [Flutter Documentation](https://docs.flutter.dev/)
- [BLoC Library](https://bloclibrary.dev/)
- [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Material Design 3](https://m3.material.io/)

## 👨‍💻 Desarrollo

Para extender funcionalidad:

1. **Agregar nuevo módulo**:
   - Crear entidad en `domain/entities/`
   - Crear repository interface en `domain/repositories/`
   - Crear use cases en `domain/usecases/`
   - Crear modelo en `data/models/`
   - Crear datasource en `data/datasources/`
   - Implementar repository en `data/repositories/`
   - Crear BLoC en `presentation/blocs/`
   - Crear páginas en `presentation/pages/`

2. **Registrar en DI** (`injection_container.dart`)

3. **Agregar rutas** (`presentation/router/app_router.dart`)

## 🐛 Troubleshooting

### Error de conexión al backend
- Verifica que el backend esté corriendo
- Usa la IP correcta según tu configuración
- Emulador Android: `http://10.0.2.2:8080/api`
- Dispositivo físico: `http://TU_IP_LOCAL:8080/api`

### Error de build_runner
```bash
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### Problemas de dependencias
```bash
flutter clean
flutter pub get
```

---

**Desarrollado con ❤️ usando Flutter & Clean Architecture**
