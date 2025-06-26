# 🐳 SQL Server en Docker - Guía Completa

Esta guía te permite configurar SQL Server 2022 en Docker para desarrollo local con DBeaver y Python.

## 📋 Prerrequisitos

- ✅ Docker Desktop instalado y funcionando
- ✅ DBeaver instalado (para administrar la BD)
- ✅ PowerShell (viene con Windows)

---

## 🚀 INSTALACIÓN POR PRIMERA VEZ

### Paso 1: Preparar el Proyecto
```powershell
# Abrir PowerShell como Administrador
# Navegar a tu carpeta de proyecto
cd C:\Desarrollo\Sqlserver
```

### Paso 2: Configurar Permisos (Solo Primera Vez)
```powershell
# Permitir ejecutar scripts en esta sesión
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
# Responder "S" (Sí) cuando pregunte
```

### Paso 3: Instalación Automática
```powershell
# Crear directorio para datos persistentes
mkdir "C:\Desarrollo\Sqlserver\volumen" -Force

# Levantar SQL Server por primera vez
docker-compose up -d

# Verificar que esté funcionando
docker ps

# Ver logs para confirmar que esté listo
docker logs sqlserver_dev
```

### Paso 4: Verificar Instalación
```powershell
# Debe mostrar el contenedor corriendo
docker ps --filter "name=sqlserver_dev"

# Los logs deben mostrar: "SQL Server is now ready for client connections"
docker logs sqlserver_dev --tail 5
```

### 🎯 ¡Listo! SQL Server está corriendo

**Datos de Conexión para DBeaver:**
- **Host:** `localhost`
- **Puerto:** `1433`
- **Usuario:** `sa`
- **Contraseña:** `MyStrongPass123!`
- **Base de datos:** `master`

---

## ⏸️ PAUSAR EL PROYECTO

Cuando termines de trabajar y quieras liberar recursos:

```powershell
# Detener SQL Server (mantiene los datos)
docker-compose stop

# O si quieres detener todo Docker
docker-compose down

# Verificar que se detuvo
docker ps
```

> **💡 Tip:** Usa `stop` para pausa rápida, `down` para pausa completa.

---

## ▶️ VOLVER A LEVANTAR EL PROYECTO

Cuando quieras trabajar de nuevo:

### Opción 1: Inicio Rápido
```powershell
# Desde la carpeta del proyecto
cd C:\Desarrollo\Sqlserver

# Levantar SQL Server
docker-compose up -d

# Verificar que esté corriendo
docker ps
```

### Opción 2: Con Verificación Completa
```powershell
# Levantar y ver logs en tiempo real
docker-compose up -d && docker logs -f sqlserver_dev

# Presiona Ctrl+C para salir de los logs
```

### Verificar que Esté Listo
```powershell
# Ver estado del contenedor
docker ps --filter "name=sqlserver_dev"

# Ver últimos logs
docker logs sqlserver_dev --tail 5

# Cuando veas "ready for client connections" ¡ya puedes conectarte!
```

---

## 🔧 COMANDOS ÚTILES

### Ver Estado
```powershell
# Ver todos los contenedores
docker ps

# Ver solo nuestro SQL Server
docker ps --filter "name=sqlserver_dev"

# Ver logs en tiempo real
docker logs -f sqlserver_dev

# Ver últimas 10 líneas de logs
docker logs sqlserver_dev --tail 10
```

### Gestión del Contenedor
```powershell
# Detener sin eliminar
docker-compose stop

# Levantar después de stop
docker-compose start

# Reiniciar
docker-compose restart

# Detener y eliminar (mantiene datos en volumen)
docker-compose down

# Levantar desde cero
docker-compose up -d
```

### Limpieza Completa (⚠️ Cuidado - Borra TODO)
```powershell
# Solo si quieres empezar desde cero y borrar TODOS los datos
docker-compose down -v
docker volume prune -f
```

---

## 📊 CONEXIÓN CON DBEAVER

1. **Abrir DBeaver**
2. **Nueva Conexión** → **SQL Server**
3. **Configurar:**
   ```
   Server Host: localhost
   Port: 1433
   Database: master
   Authentication: SQL Server Authentication
   Username: sa
   Password: MyStrongPass123!
   ```
4. **Test Connection** → **OK** → **Finish**

---

## 🐍 USAR CON PYTHON

### Instalar Dependencias
```bash
pip install pandas pyodbc sqlalchemy
```

### Primera Ejecución - Crear Estructura Completa
```bash
# El script verificará y creará automáticamente:
# - Base de datos DGBIDB
# - Todas las tablas del sistema
# - Vistas necesarias  
# - Datos de ejemplo
python main.py
```

### Lo que hace main.py:
1. **✅ Verifica/crea** la base de datos DGBIDB
2. **📋 Revisa** si existen las tablas necesarias
3. **🏗️ Crea** las tablas faltantes automáticamente
4. **👁️ Genera** vistas para consultas
5. **📝 Inserta** datos de ejemplo para pruebas
6. **🔍 Muestra** un resumen de la estructura creada

### Ejecuciones Posteriores
```bash
# En ejecuciones posteriores, solo verificará y mostrará la estructura existente
python main.py
```

---

## 🛠️ RESOLUCIÓN DE PROBLEMAS

### ❌ Error: "Puerto 1433 en uso"
```powershell
# Ver qué está usando el puerto
netstat -ano | findstr :1433

# Detener otros SQL Server
docker stop sqlserver_dev
```

### ❌ Error: "Docker no responde"
```powershell
# Reiniciar Docker Desktop desde el menú de Windows
# O desde PowerShell:
Restart-Service docker
```

### ❌ Error: "No se puede conectar desde DBeaver"
```powershell
# Verificar que esté corriendo
docker ps

# Ver logs para errores
docker logs sqlserver_dev

# Verificar puerto
telnet localhost 1433
```

### ❌ Error: "Contenedor se cierra inmediatamente"
```powershell
# Ver logs para errores de configuración
docker logs sqlserver_dev

# Problema común: contraseña no cumple políticas
# Nuestra contraseña es: MyStrongPass123! (ya es segura)
```

---

## 📁 ESTRUCTURA DEL PROYECTO

```
C:\Desarrollo\Sqlserver\
├── docker-compose.yml                    # Configuración de Docker
├── .env                                 # Variables de entorno
├── main.py                             # Script principal (verifica/crea tablas)
├── sqlserver_connection.py            # Clase de conexión
├── BienesConcesiones_script_db.sql    # Script SQL original
├── BienesConcesiones_script_corregido.sql # Script SQL optimizado
├── volumen/                           # Datos persistentes (se crea automáticamente)
└── README.md                          # Esta guía
```

## 🏗️ ESTRUCTURA DE BASE DE DATOS

El sistema creará automáticamente:

### 📊 **Base de Datos:** `DGBIDB`

### 📋 **Tablas Principales:**
- `01_RELACION_BAC_SIGAF` - Relaciones BAC-SIGAF
- `02_SPR_RENGLONES` - Renglones SPR
- `25_ENTES` - Entidades del sistema

### 🏠 **Módulo Bienes:**
- `Bienes_01_BENEFICIARIOS` - Beneficiarios de bienes
- `Bienes_02_CARTERAS` - Carteras de bienes
- `Bienes_03_CONTRATOS` - Contratos
- `Bienes_04_PLAN_DE_PAGOS` - Planes de pago

### 🏢 **Módulo Concesiones:**
- `Concesiones_01_BENEFICIARIOS` - Beneficiarios
- `Concesiones_02_CARTERAS` - Carteras
- `Concesiones_03_CONTRATOS` - Contratos  
- `Concesiones_04_PLAN_DE_PAGOS` - Planes de pago

### 👁️ **Vistas:**
- `VW_Bienes_Beneficiarios`
- `VW_Concesiones_Beneficiarios`
- `vw_entes`
- Y muchas más...

---

## 🎯 FLUJO DE TRABAJO DIARIO

### Empezar a Trabajar:
```powershell
cd C:\Desarrollo\Sqlserver
docker-compose up -d
```

### Verificar que Esté Listo:
```powershell
docker ps
# Debe mostrar: "Up X minutes (healthy)"
```

### Terminar de Trabajar:
```powershell
docker-compose stop
```

### Solo Cuando Necesites Limpieza:
```powershell
docker-compose down
```

---

## ✅ CHECKLIST RÁPIDO

**Primera vez:**
- [ ] Docker Desktop corriendo
- [ ] Ejecutar `mkdir "C:\Desarrollo\Sqlserver\volumen" -Force`
- [ ] Ejecutar `docker-compose up -d`
- [ ] Verificar con `docker ps`
- [ ] Conectar DBeaver con datos de arriba

**Uso diario:**
- [ ] `docker-compose up -d` (levantar)
- [ ] Trabajar en DBeaver/Python
- [ ] `docker-compose stop` (pausar)

**Verificación:**
- [ ] `docker ps` muestra el contenedor "Up"
- [ ] DBeaver se conecta sin errores
- [ ] Los datos persisten entre reinicios

---

## 📞 AYUDA RÁPIDA

| Problema | Comando |
|----------|---------|
| Ver si está corriendo | `docker ps` |
| Ver logs | `docker logs sqlserver_dev` |
| Reiniciar | `docker-compose restart` |
| Parar | `docker-compose stop` |
| Levantar | `docker-compose up -d` |
| Estado detallado | `docker inspect sqlserver_dev` |

**¡Listo para desarrollar! 🚀**