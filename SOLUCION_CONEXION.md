# 🔧 SOLUCIÓN AL ERROR DE CONEXIÓN

## Error: "Connection refused"

Este error significa que **el backend no está corriendo** o la app no puede conectarse a él.

---

## ✅ SOLUCIONES

### 1️⃣ **Si usas EMULADOR ANDROID**

La app ahora **auto-detecta** la plataforma y usa `http://10.0.2.2:8080/api` automáticamente.

✅ **No necesitas hacer nada**

### 2️⃣ **Si usas DISPOSITIVO FÍSICO ANDROID/iOS**

Necesitas usar la IP de tu computadora:

1. **Obtén tu IP local:**
   ```bash
   # Windows
   ipconfig
   # Busca "IPv4 Address" (ejemplo: 192.168.1.100)
   
   # Mac/Linux
   ifconfig
   # Busca "inet" (ejemplo: 192.168.1.100)
   ```

2. **Edita `lib/core/constants/api_constants.dart`:**
   ```dart
   // Descomenta y edita esta línea:
   static const String baseUrl = 'http://TU_IP:8080/api';
   // Ejemplo: 'http://192.168.1.100:8080/api'
   ```

3. **Comenta el getter automático:**
   ```dart
   // static String get baseUrl {
   //   if (kIsWeb) {
   //     return 'http://localhost:8080/api';
   //   } else if (Platform.isAndroid) {
   //     return 'http://10.0.2.2:8080/api';
   //   } else {
   //     return 'http://localhost:8080/api';
   //   }
   // }
   ```

### 3️⃣ **Si usas WEB o DESKTOP**

La app usa `http://localhost:8080/api` automáticamente.

✅ **No necesitas hacer nada**

---

## 🚀 ASEGÚRATE QUE EL BACKEND ESTÉ CORRIENDO

### Opción A: Spring Boot (IntelliJ/Eclipse)
```bash
# Ejecuta la aplicación Spring Boot
# Click derecho en la clase main > Run
```

### Opción B: Maven
```bash
cd ruta/del/backend
mvn spring-boot:run
```

### Opción C: Gradle
```bash
cd ruta/del/backend
./gradlew bootRun
```

### Verifica que funcione:
Abre en tu navegador:
```
http://localhost:8080/api/pacientes
```

Deberías ver una respuesta JSON (puede ser una lista vacía `[]`).

---

## 📝 CONFIGURACIÓN PARA DIFERENTES PLATAFORMAS

| Plataforma | URL a usar |
|------------|------------|
| Emulador Android | `http://10.0.2.2:8080/api` ✅ Auto |
| iPhone Simulator | `http://localhost:8080/api` ✅ Auto |
| Dispositivo Físico | `http://TU_IP:8080/api` ⚠️ Manual |
| Chrome (Web) | `http://localhost:8080/api` ✅ Auto |
| Desktop (Windows/Mac/Linux) | `http://localhost:8080/api` ✅ Auto |

---

## 🐛 OTROS PROBLEMAS

### ❌ Error: "No route to host"
- **Solución**: Firewall bloqueando. Desactiva temporalmente o permite el puerto 8080.

### ❌ Error: "Timeout"
- **Solución**: Backend está muy lento o no responde. Verifica logs del backend.

### ❌ Error: "404 Not Found"
- **Solución**: URL incorrecta. Verifica que el backend esté en `/api/...`

---

## ✅ FORMULARIOS IMPLEMENTADOS

Se han implementado **TODOS** los formularios:

### ✅ Pacientes
- ✅ Crear
- ✅ Editar
- ✅ Eliminar
- ✅ Listar

### ✅ Especialidades
- ✅ Crear
- ✅ Editar
- ✅ Eliminar
- ✅ Listar

### ✅ Médicos
- ✅ Crear (con selector de especialidad)
- ✅ Editar
- ✅ Eliminar
- ✅ Listar

### ✅ Historias Clínicas
- ✅ Crear (con selectores de paciente y médico + datepicker)
- ✅ Editar
- ✅ Eliminar
- ✅ Listar (con expansión de detalles)

---

## 🎯 CARACTERÍSTICAS DE LOS FORMULARIOS

### Especialidades
- Nombre (obligatorio)
- Descripción (opcional)

### Médicos
- CMP (obligatorio, deshabilitado en edición)
- Nombre (obligatorio)
- Apellidos (obligatorio)
- Especialidad (dropdown, obligatorio)

### Historias Clínicas
- Paciente (dropdown de todos los pacientes)
- Médico (dropdown de todos los médicos)
- Fecha de Atención (datepicker)
- Diagnóstico (obligatorio, multilínea)
- Análisis (opcional, multilínea)
- Tratamiento (opcional, multilínea)

---

## 🔄 RECARGA AUTOMÁTICA

Todos los módulos recargan automáticamente la lista después de:
- ✅ Crear un registro
- ✅ Editar un registro
- ✅ Eliminar un registro

---

## 📱 CAPTURAS

### Menú Principal
- 4 cards con iconos Material Design 3
- Navegación a cada módulo

### Listas
- Cards con información resumida
- Menú de 3 puntos (Editar/Eliminar)
- FAB para crear nuevo

### Formularios
- Validación en tiempo real
- Loading states
- Mensajes de éxito/error
- Navegación automática al finalizar

---

## 🚀 EJECUTAR LA APP

```bash
# 1. Asegúrate que el backend esté corriendo
# 2. Ejecuta Flutter
flutter run

# Si hay problemas de build
flutter clean
flutter pub get
flutter run
```

---

**Proyecto 100% completo y funcional** ✅
