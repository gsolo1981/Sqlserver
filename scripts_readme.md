# 🐍 Scripts Python - Documentación Técnica

Documentación detallada de los scripts Python para gestión y diagnóstico del sistema SQL Server.

## 📋 Índice
- [main.py - Script Principal](#-mainpy---script-principal)
- [diagnostico.py - Herramienta de Diagnóstico](#-diagnosticopy---herramienta-de-diagnóstico)
- [sqlserver_connection.py - Clase de Conexión](#-sqlserver_connectionpy---clase-de-conexión)
- [Casos de Uso](#-casos-de-uso)
- [Resolución de Problemas](#-resolución-de-problemas)

---

## 🚀 main.py - Script Principal

### Descripción
Script automatizado que verifica, crea e inicializa la estructura completa de la base de datos DGBIDB con todas sus tablas, vistas y datos de ejemplo.

### Funcionalidades
- ✅ **Verificación de SQL Server** - Confirma conectividad
- ✅ **Creación automática de BD** - Crea DGBIDB si no existe
- ✅ **Procesamiento de scripts SQL** - Ejecuta createDB.sql
- ✅ **Gestión inteligente de errores** - Omite objetos duplicados
- ✅ **Verificación final** - Confirma estructura creada
- ✅ **Reporte detallado** - Muestra resumen de operaciones

### Uso

#### Ejecución Básica
```bash
python main.py
```

#### Primera Ejecución (Sistema Nuevo)
```bash
# El script automáticamente:
# 1. Verifica conexión a SQL Server
# 2. Crea base de datos DGBIDB
# 3. Ejecuta script createDB.sql completo
# 4. Crea todas las tablas y vistas
# 5. Inserta datos de ejemplo
# 6. Muestra reporte final

python main.py
```

#### Ejecuciones Posteriores (Sistema Existente)
```bash
# El script automáticamente detecta:
# - Objetos ya existentes (los omite)
# - Nuevos objetos por crear
# - Datos faltantes por insertar

python main.py
```

### Salida Esperada

#### ✅ Ejecución Exitosa
```
🚀 SISTEMA DE INICIALIZACIÓN DE BASE DE DATOS
📋 Ejecutando script createDB.sql
============================================================

🔍 Verificando conexión a SQL Server...
✅ SQL Server conectado exitosamente
   Versión: Microsoft SQL Server 2022...

🔍 Verificando base de datos DGBIDB...
✅ Base de datos DGBIDB ya existe

🚀 Ejecutando script createDB.sql...
📋 Script leído correctamente (45678 caracteres)
📊 Se encontraron 125 declaraciones SQL para ejecutar

   📝 Ejecutando declaración 1/125...
      ✅ Tabla creada: 25_ENTES
   📝 Ejecutando declaración 2/125...
      ✅ Tabla creada: Bienes_01_BENEFICIARIOS
   ...

📊 Resumen de ejecución:
   ✅ Declaraciones ejecutadas: 120
   ❌ Errores: 0
   📋 Total procesadas: 125

🔍 Verificando estructura creada...
📊 Estructura verificada:
   📋 Tablas creadas: 25
   👁️ Vistas creadas: 8

🎯 Verificando tablas importantes:
   ✅ 25_ENTES
   ✅ Bienes_01_BENEFICIARIOS
   ✅ Bienes_02_CARTERAS
   ✅ Concesiones_01_BENEFICIARIOS

📊 Verificando datos de ejemplo:
   📋 Registros en ENTES: 156

============================================================
🎉 ¡PROCESO COMPLETADO!

📊 Información de conexión para DBeaver:
   🌐 Host: localhost
   🔌 Puerto: 1433
   🗄️ Base de datos: DGBIDB
   👤 Usuario: sa
   🔑 Contraseña: MyStrongPass123!

🎯 ¡Ya puedes conectarte y explorar la base de datos!
```

### Funciones Internas

#### `verificar_sql_server()`
- Verifica conectividad básica
- Ejecuta consulta de prueba
- Retorna `True` si éxito, `False` si falla

#### `crear_base_datos_si_no_existe()`
- Conecta a base `master`
- Verifica existencia de DGBIDB
- Crea la base si no existe
- Maneja permisos y transacciones

#### `ejecutar_script_createdb()`
- Lee archivo `createDB.sql`
- Procesa declaraciones dividiendo por `GO`
- Ejecuta cada declaración individualmente
- Maneja errores de objetos duplicados
- Reporta progreso detallado

#### `procesar_script_sql(script_content)`
- Limpia comentarios innecesarios
- Divide script por declaraciones `GO`
- Retorna lista de declaraciones ejecutables

#### `verificar_estructura_creada()`
- Cuenta tablas y vistas creadas
- Verifica tablas importantes específicas
- Muestra datos de ejemplo
- Genera reporte final

---

## 🔍 diagnostico.py - Herramienta de Diagnóstico

### Descripción
Herramienta completa de diagnóstico que verifica todos los componentes del sistema y proporciona soluciones específicas para problemas detectados.

### Funcionalidades
- 🐳 **Verificación de Docker** - Estado de contenedores
- 🔌 **Prueba de conectividad** - Puerto 1433 y servicios
- 🔧 **Verificación de drivers** - ODBC disponibles
- 📋 **Logs de SQL Server** - Últimos eventos del sistema
- 🔗 **Prueba de conexión** - Conectividad completa a BD
- 💡 **Soluciones automáticas** - Sugerencias específicas

### Uso

#### Diagnóstico Completo
```bash
python diagnostico.py
```

### Salida Esperada

#### ✅ Sistema Funcionando Correctamente
```
🔍 DIAGNÓSTICO COMPLETO DEL SISTEMA
==================================================

🐳 Verificando Docker...
✅ Docker está corriendo
✅ Contenedor sqlserver_dev encontrado
📊 Estado del contenedor: running
🏥 Health check: healthy

🔌 Verificando puerto 1433...
✅ Puerto 1433 está abierto y aceptando conexiones

🔧 Verificando drivers ODBC...
📋 Drivers ODBC disponibles:
   - ODBC Driver 17 for SQL Server
   - ODBC Driver 18 for SQL Server
   - SQL Server Native Client 11.0
✅ Driver de SQL Server encontrado: ODBC Driver 17 for SQL Server

📋 Logs recientes de SQL Server:
2024-06-27 15:30:22.45 spid12s     Server is listening on [ 'any' <ipv4> 1433]
2024-06-27 15:30:22.46 spid12s     Server is listening on [ 'any' <ipv6> 1433]
2024-06-27 15:30:23.12 spid12s     SQL Server is now ready for client connections.

🔗 Probando conexión básica...
   Intentando conectar...
✅ Conexión exitosa a SQL Server
📊 Versión SQL Server: Microsoft SQL Server 2022 (RTM-CU8) (KB5029666)...
📊 Base de datos actual: master

==================================================
📊 RESUMEN DEL DIAGNÓSTICO:
   🐳 Docker: ✅
   🔌 Puerto 1433: ✅
   🔧 Drivers ODBC: ✅
   🔗 Conexión SQL: ✅

🎉 ¡Todo está funcionando correctamente!
   Puedes ejecutar: python main.py
```

#### ❌ Sistema con Problemas
```
🔍 DIAGNÓSTICO COMPLETO DEL SISTEMA
==================================================

🐳 Verificando Docker...
❌ Docker no está corriendo

🔌 Verificando puerto 1433...
❌ Puerto 1433 no está disponible

🔧 Verificando drivers ODBC...
❌ No se encontró driver de SQL Server

==================================================
📊 RESUMEN DEL DIAGNÓSTICO:
   🐳 Docker: ❌
   🔌 Puerto 1433: ❌
   🔧 Drivers ODBC: ❌
   🔗 Conexión SQL: ❌

🔧 SOLUCIONES SUGERIDAS:
   - Ejecutar: docker-compose up -d
   - Esperar 60 segundos para que SQL Server inicie
   - Instalar: https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server
```

### Funciones Internas

#### `verificar_docker()`
- Ejecuta `docker ps` para verificar estado
- Busca contenedor `sqlserver_dev`
- Verifica estado (`running`) y health check
- Retorna `True` si todo OK

#### `verificar_puerto()`
- Usa socket para probar conectividad en puerto 1433
- Timeout de 5 segundos
- Retorna `True` si puerto responde

#### `verificar_drivers_odbc()`
- Lista todos los drivers ODBC disponibles
- Busca específicamente drivers de SQL Server
- Retorna `True` si encuentra drivers compatibles

#### `probar_conexion_basica()`
- Intenta conexión completa usando PyODBC
- Ejecuta consultas de prueba (versión, BD actual)
- Maneja timeout de 10 segundos
- Retorna `True` si conexión exitosa

#### `mostrar_logs_sql_server()`
- Ejecuta `docker logs sqlserver_dev --tail 15`
- Muestra últimos eventos del contenedor
- Útil para diagnosticar problemas de inicio

---

## 🔗 sqlserver_connection.py - Clase de Conexión

### Descripción
Clase wrapper que simplifica las conexiones a SQL Server usando PyODBC y SQLAlchemy, con manejo automático de errores y métodos utilitarios.

### Características
- 🔌 **Conexión PyODBC** - Para operaciones directas
- ⚡ **Conexión SQLAlchemy** - Para integración con pandas
- 🔄 **Autocommit configurable** - Para DDL operations
- 🛠️ **Métodos utilitarios** - Listado de tablas, BD, etc.
- 🔒 **Context manager** - Gestión automática de recursos
- 🚨 **Manejo de errores** - Mensajes descriptivos

### Uso Básico

#### Conexión Simple
```python
from sqlserver_connection import SQLServerConnection

# Crear instancia
db = SQLServerConnection(database='DGBIDB')

# Conectar
if db.connect_pyodbc():
    # Ejecutar consulta
    result = db.execute_query("SELECT COUNT(*) as total FROM [25_ENTES]")
    print(result)
    
    # Cerrar
    db.close()
```

#### Context Manager (Recomendado)
```python
with SQLServerConnection(database='DGBIDB') as db:
    result = db.execute_query("SELECT * FROM [25_ENTES]")
    print(result.head())
```

#### Operaciones DDL (Crear tablas, BD)
```python
# Conexión con autocommit para CREATE DATABASE
db = SQLServerConnection(database='master')
db.connect_pyodbc(autocommit=True)

# Crear base de datos
success = db.create_database('MiNuevaBD')

db.close()
```

### Métodos Principales

#### Conexión
```python
# PyODBC (operaciones directas)
db.connect_pyodbc(autocommit=False)

# SQLAlchemy (para pandas)
engine = db.connect_sqlalchemy()
```

#### Ejecución de Consultas
```python
# SELECT que retorna DataFrame
df = db.execute_query("SELECT * FROM tabla", return_dataframe=True)

# INSERT/UPDATE/DELETE
result = db.execute_query("INSERT INTO tabla VALUES (...)", return_dataframe=False)

# SQL crudo sin pandas
success = db.execute_raw_sql("CREATE TABLE ...")
```

#### Utilidades
```python
# Listar bases de datos
dbs = db.list_databases()

# Listar tablas
tables = db.list_tables()

# Información de tabla específica
info = db.get_table_info('25_ENTES')

# Test de conexión
success = db.test_connection()
```

#### Gestión de BD
```python
# Verificar si BD existe
exists = db.database_exists('DGBIDB')

# Crear BD
success = db.create_database('NuevaBD')
```

---

## 🎯 Casos de Uso

### Caso 1: Instalación Inicial
```bash
# 1. Levantar SQL Server
docker-compose up -d

# 2. Verificar que esté funcionando
python diagnostico.py

# 3. Crear estructura completa
python main.py
```

### Caso 2: Diagnóstico de Problemas
```bash
# Si algo no funciona, siempre empezar con:
python diagnostico.py

# Seguir las soluciones sugeridas
# Luego verificar con:
python main.py
```

### Caso 3: Desarrollo Diario
```python
# Script personalizado usando la clase
from sqlserver_connection import SQLServerConnection

with SQLServerConnection(database='DGBIDB') as db:
    # Tu código aquí
    entes = db.execute_query("SELECT * FROM [25_ENTES] WHERE codigo_ente = 'ABC'")
    print(f"Encontrados: {len(entes)} registros")
```

### Caso 4: Backup y Restauración
```python
# Crear backup de tabla específica
with SQLServerConnection(database='DGBIDB') as db:
    data = db.execute_query("SELECT * FROM [25_ENTES]")
    data.to_csv('backup_entes.csv', index=False)
    print("Backup creado exitosamente")
```

---

## 🛠️ Resolución de Problemas

### Error: "No module named 'pyodbc'"
```bash
pip install pyodbc pandas sqlalchemy
```

### Error: "Driver not found"
1. Descargar desde: https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server
2. Ejecutar: `python diagnostico.py` para verificar

### Error: "Connection timeout"
```bash
# Verificar que SQL Server esté listo
docker logs sqlserver_dev

# Esperar hasta ver: "SQL Server is now ready for client connections"
```

### Error: "Database does not exist"
```bash
# Crear automáticamente
python main.py

# O manualmente
python -c "
from sqlserver_connection import SQLServerConnection
db = SQLServerConnection(database='master')
db.connect_pyodbc(autocommit=True)
db.create_database('DGBIDB')
db.close()
"
```

### Error: "Permission denied"
1. Ejecutar PowerShell como Administrador
2. Verificar: `.\verificar-admin-powershell.ps1`
3. Reiniciar Docker si es necesario

### Script main.py se ejecuta pero no crea tablas
```bash
# Verificar que createDB.sql existe en el directorio
ls createDB.sql

# Verificar conexión específica a DGBIDB
python -c "
from sqlserver_connection import SQLServerConnection
db = SQLServerConnection(database='DGBIDB')
if db.connect_pyodbc():
    print('Conexión OK')
    tables = db.list_tables()
    print(f'Tablas existentes: {len(tables)}')
    db.close()
"
```

---

## 📈 Monitoreo y Logs

### Ver logs detallados de main.py
```python
# El script ya incluye logging detallado
# Para ver más detalles, modificar en main.py:
# debug=True en las funciones que lo soporten
```

### Verificar ejecución de SQL
```python
# Agregar al final de main.py para debug:
with SQLServerConnection(database='DGBIDB') as db:
    # Ver último comando ejecutado
    db.execute_query("SELECT TOP 1 * FROM sys.dm_exec_sessions WHERE is_user_process = 1")
```

---

## 🔄 Flujo de Trabajo Recomendado

1. **Siempre empezar con diagnóstico:**
   ```bash
   python diagnostico.py
   ```

2. **Si hay problemas, resolverlos antes de continuar**

3. **Ejecutar main.py solo cuando diagnóstico está OK:**
   ```bash
   python main.py
   ```

4. **Para desarrollo, usar la clase directamente:**
   ```python
   from sqlserver_connection import SQLServerConnection
   # Tu código aquí
   ```

¡Scripts listos para usar! 🚀