# Sistema de Historias Clínicas - API REST

API REST para gestión de historias clínicas desarrollada con Spring Boot, documentada con Swagger/OpenAPI para integración con Flutter.

## Entidades del Sistema

### 1. **Paciente**
- Información de pacientes
- Campos: DNI (PK), nombre, apellido paterno, apellido materno, dirección, teléfono
- Relación: Un paciente puede tener muchas historias clínicas (1-N)

### 2. **Especialidad**
- Especialidades médicas
- Campos: ID, nombre, descripción
- Relación: Una especialidad puede tener muchos médicos (1-N)

### 3. **Médico**
- Información de médicos
- Campos: CMP (PK), nombre, apellidos, especialidad
- Relaciones: Pertenece a una especialidad, puede atender muchas historias clínicas (1-N)

### 4. **Historia Clínica**
- Registro de atenciones médicas
- Campos: ID, paciente, médico, fecha atención, diagnóstico, análisis, tratamiento
- Relaciones: Pertenece a un paciente y un médico (N-1)

## Endpoints Principales

### Pacientes (`/api/pacientes`)
- `GET /api/pacientes` - Listar todos los pacientes
- `GET /api/pacientes/{dni}` - Obtener paciente por DNI
- `POST /api/pacientes` - Crear nuevo paciente
- `PUT /api/pacientes/{dni}` - Actualizar paciente
- `DELETE /api/pacientes/{dni}` - Eliminar paciente
- `GET /api/pacientes/buscar?busqueda=` - Buscar pacientes

### Especialidades (`/api/especialidades`)
- `GET /api/especialidades` - Listar todas las especialidades
- `GET /api/especialidades/{id}` - Obtener especialidad por ID
- `POST /api/especialidades` - Crear nueva especialidad
- `PUT /api/especialidades/{id}` - Actualizar especialidad
- `DELETE /api/especialidades/{id}` - Eliminar especialidad

### Médicos (`/api/medicos`)
- `GET /api/medicos` - Listar todos los médicos
- `GET /api/medicos/{cmp}` - Obtener médico por CMP
- `POST /api/medicos` - Crear nuevo médico
- `PUT /api/medicos/{cmp}` - Actualizar médico
- `DELETE /api/medicos/{cmp}` - Eliminar médico
- `GET /api/medicos/buscar?busqueda=` - Buscar médicos
- `GET /api/medicos/especialidad/{especialidadId}` - Médicos por especialidad

### Historias Clínicas (`/api/historias-clinicas`)
- `GET /api/historias-clinicas` - Listar todas las historias
- `GET /api/historias-clinicas/{id}` - Obtener historia por ID
- `POST /api/historias-clinicas` - Crear nueva historia
- `PUT /api/historias-clinicas/{id}` - Actualizar historia
- `DELETE /api/historias-clinicas/{id}` - Eliminar historia
- `GET /api/historias-clinicas/paciente/{dni}` - Historias de un paciente
- `GET /api/historias-clinicas/medico/{cmp}` - Historias de un médico
- `GET /api/historias-clinicas/fechas?fechaInicio=&fechaFin=` - Historias por rango de fechas

## Configuración

### Base de Datos
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/clinica_db
spring.datasource.username=postgres
spring.datasource.password=1234567
```

### Swagger UI
Acceder a la documentación interactiva:
- **Swagger UI**: http://localhost:8080/swagger-ui.html
- **API Docs**: http://localhost:8080/api-docs

## Ejecución

1. Asegurar que PostgreSQL está corriendo
2. Crear la base de datos:
```sql
CREATE DATABASE clinica_db;
```

3. Ejecutar la aplicación:
```bash
mvnw spring-boot:run
```

4. Acceder a Swagger UI en: http://localhost:8080/swagger-ui.html

## Integración con Flutter

### Paquetes Recomendados
```yaml
dependencies:
  http: ^1.1.0
  dio: ^5.3.3
```

### Ejemplo de Consumo - Listar Pacientes
```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<dynamic>> obtenerPacientes() async {
  final response = await http.get(
    Uri.parse('http://localhost:8080/api/pacientes'),
    headers: {'Content-Type': 'application/json'},
  );
  
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Error al cargar pacientes');
  }
}
```

### Ejemplo - Crear Historia Clínica
```dart
Future<void> crearHistoriaClinica(Map<String, dynamic> historia) async {
  final response = await http.post(
    Uri.parse('http://localhost:8080/api/historias-clinicas'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode(historia),
  );
  
  if (response.statusCode != 201) {
    throw Exception('Error al crear historia clínica');
  }
}
```

### Modelo de Datos Flutter - PacienteDTO
```dart
class Paciente {
  final String pacDni;
  final String pacNombre;
  final String pacApellidoPaterno;
  final String pacApellidoMaterno;
  final String? pacDireccion;
  final String? pacTelefono;

  Paciente({
    required this.pacDni,
    required this.pacNombre,
    required this.pacApellidoPaterno,
    required this.pacApellidoMaterno,
    this.pacDireccion,
    this.pacTelefono,
  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      pacDni: json['pacDni'],
      pacNombre: json['pacNombre'],
      pacApellidoPaterno: json['pacApellidoPaterno'],
      pacApellidoMaterno: json['pacApellidoMaterno'],
      pacDireccion: json['pacDireccion'],
      pacTelefono: json['pacTelefono'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pacDni': pacDni,
      'pacNombre': pacNombre,
      'pacApellidoPaterno': pacApellidoPaterno,
      'pacApellidoMaterno': pacApellidoMaterno,
      'pacDireccion': pacDireccion,
      'pacTelefono': pacTelefono,
    };
  }
}
```

### Modelo de Datos Flutter - HistoriaClinicaDTO
```dart
class HistoriaClinica {
  final int? histId;
  final String pacDni;
  final String? pacNombreCompleto;
  final String medCmp;
  final String? medNombreCompleto;
  final String? medEspecialidad;
  final String histFechaAtencion;
  final String histDiagnostico;
  final String? histAnalisis;
  final String? histTratamiento;

  HistoriaClinica({
    this.histId,
    required this.pacDni,
    this.pacNombreCompleto,
    required this.medCmp,
    this.medNombreCompleto,
    this.medEspecialidad,
    required this.histFechaAtencion,
    required this.histDiagnostico,
    this.histAnalisis,
    this.histTratamiento,
  });

  factory HistoriaClinica.fromJson(Map<String, dynamic> json) {
    return HistoriaClinica(
      histId: json['histId'],
      pacDni: json['pacDni'],
      pacNombreCompleto: json['pacNombreCompleto'],
      medCmp: json['medCmp'],
      medNombreCompleto: json['medNombreCompleto'],
      medEspecialidad: json['medEspecialidad'],
      histFechaAtencion: json['histFechaAtencion'],
      histDiagnostico: json['histDiagnostico'],
      histAnalisis: json['histAnalisis'],
      histTratamiento: json['histTratamiento'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'histId': histId,
      'pacDni': pacDni,
      'medCmp': medCmp,
      'histFechaAtencion': histFechaAtencion,
      'histDiagnostico': histDiagnostico,
      'histAnalisis': histAnalisis,
      'histTratamiento': histTratamiento,
    };
  }
}
```

## Estructura del Proyecto

```
demo/
├── src/main/java/com/example/demo/
│   ├── entity/          # Entidades JPA
│   │   ├── Paciente.java
│   │   ├── Especialidad.java
│   │   ├── Medico.java
│   │   └── HistoriaClinica.java
│   ├── repository/      # Repositorios JPA
│   │   ├── PacienteRepository.java
│   │   ├── EspecialidadRepository.java
│   │   ├── MedicoRepository.java
│   │   └── HistoriaClinicaRepository.java
│   ├── service/         # Interfaces de servicios
│   │   └── impl/        # Implementaciones
│   ├── controller/      # Controladores REST
│   │   ├── PacienteController.java
│   │   ├── EspecialidadController.java
│   │   ├── MedicoController.java
│   │   └── HistoriaClinicaController.java
│   ├── dto/             # DTOs
│   │   ├── PacienteDTO.java
│   │   ├── EspecialidadDTO.java
│   │   ├── MedicoDTO.java
│   │   └── HistoriaClinicaDTO.java
│   └── config/          # Configuración
│       └── SwaggerConfig.java
└── src/main/resources/
    └── application.properties
```

## Notas Importantes

- La API usa PostgreSQL como base de datos
- Swagger está configurado para documentación automática
- Las historias clínicas relacionan pacientes con médicos
- Todas las respuestas son en formato JSON
- CORS está habilitado para desarrollo con Flutter
- El DNI es la clave primaria del paciente
- El CMP es la clave primaria del médico
