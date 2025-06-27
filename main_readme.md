# 🐳 SQL Server 2022 - Entorno de Desarrollo

Sistema completo de SQL Server 2022 en Docker con scripts automatizados para inicialización de base de datos y diagnóstico del sistema.

## 📋 Descripción

Este proyecto proporciona un entorno de desarrollo completo que incluye:
- **SQL Server 2022 Developer** ejecutándose en Docker
- **Volumen persistente** para conservar datos entre reinicios
- **Scripts automatizados** para creación y verificación de base de datos
- **Herramientas de diagnóstico** para resolución de problemas
- **Configuración optimizada** para desarrollo local

## 🚀 Inicio Rápido

### Prerrequisitos
- ✅ **Docker Desktop** instalado y ejecutándose
- ✅ **Python 3.8+** con pip
- ✅ **PowerShell** (incluido en Windows)
- ✅ **DBeaver** (recomendado para administración)

### Instalación en 3 Pasos

#### 1. Instalar Dependencias Python
```bash
pip install pandas pyodbc sqlalchemy
```

#### 2. Levantar SQL Server
```powershell
# Desde el directorio del proyecto
docker-compose up -d

# Verificar que esté corriendo
docker ps
```

#### 3. Inicializar Base de Datos
```bash
# Crear automáticamente la estructura completa
python main.py
```

## 📊 Conexión a la Base de Datos

### Datos de Conexión
| Parámetro | Valor |
|-----------|-------|
| **Host** | `localhost` |
| **Puerto** | `1433` |
| **Usuario** | `sa` |
| **Contraseña** | `MyStrongPass123!` |
| **Base de datos** | `DGBIDB` |

### DBeaver
1. **Nueva Conexión** → **SQL Server**
2. Usar los datos de la tabla anterior
3. **Test Connection** → **Finish**

### Python
```python
from sqlserver_connection import SQLServerConnection

# Conectar a la base de datos
db = SQLServerConnection(database='DGBIDB')
db.connect_pyodbc()

# Ejecutar consulta
result = db.execute_query("SELECT COUNT(*) FROM [25_ENTES]")
print(result)

db.close()
```

## 📁 Estructura del Proyecto

```
proyecto/
├── 📄 README.md                    # Esta documentación
├── 📄 README-Scripts.md             # Documentación de scripts Python
├── 🐳 docker-compose.yml           # Configuración de SQL Server
├── 🐍 main.py                      # Script principal (crear BD)
├── 🔍 diagnostico.py               # Script de diagnóstico
├── 🔗 sqlserver_connection.py      # Clase de conexión a SQL Server
├── ⚙️ setup.ps1                    # Script de instalación automática
├── 🔧 verificar-admin-powershell.ps1 # Verificador de permisos
├── 📝 createDB.sql                 # Script SQL de estructura
└── 📂 volumen/                     # Directorio para volumen (si se usa bind mount)
```

## 🛠️ Scripts Disponibles

| Script | Descripción | Uso |
|--------|-------------|-----|
| `main.py` | Crea/verifica estructura de BD completa | `python main.py` |
| `diagnostico.py` | Diagnóstico completo del sistema | `python diagnostico.py` |
| `setup.ps1` | Instalación automática (PowerShell) | `.\setup.ps1` |

## 🐳 Comandos Docker Útiles

### Gestión Básica
```powershell
# Levantar SQL Server
docker-compose up -d

# Ver estado
docker ps

# Ver logs
docker logs sqlserver_dev

# Detener (mantiene datos)
docker-compose stop

# Reiniciar
docker-compose restart

# Detener y eliminar contenedor (mantiene volumen)
docker-compose down
```

### Gestión de Volúmenes
```powershell
# Ver volúmenes
docker volume ls

# Inspeccionar volumen de datos
docker volume inspect sqlserver_dev_sqlserver_data

# Backup del volumen
docker run --rm -v sqlserver_dev_sqlserver_data:/source -v ${PWD}:/backup alpine tar czf /backup/sqlserver_backup.tar.gz -C /source .

# Restaurar backup
docker run --rm -v sqlserver_dev_sqlserver_data:/target -v ${PWD}:/backup alpine tar xzf /backup/sqlserver_backup.tar.gz -C /target
```

### Limpieza Completa (⚠️ Borra TODOS los datos)
```powershell
# Solo si quieres empezar desde cero
docker-compose down -v
docker volume prune -f
```

## 🗄️ Base de Datos DGBIDB

El script `main.py` crea automáticamente la siguiente estructura:

### Tablas Principales
- `25_ENTES` - Entidades del sistema
- `01_RELACION_BAC_SIGAF` - Relaciones BAC-SIGAF
- `02_SPR_RENGLONES` - Renglones SPR

### Módulo Bienes
- `Bienes_01_BENEFICIARIOS`
- `Bienes_02_CARTERAS`
- `Bienes_03_CONTRATOS`
- `Bienes_04_PLAN_DE_PAGOS`

### Módulo Concesiones
- `Concesiones_01_BENEFICIARIOS`
- `Concesiones_02_CARTERAS`
- `Concesiones_03_CONTRATOS`
- `Concesiones_04_PLAN_DE_PAGOS`

### Vistas
- `VW_Bienes_Beneficiarios`
- `VW_Concesiones_Beneficiarios`
- `vw_entes`

## 🔧 Resolución de Problemas

### SQL Server no inicia
```powershell
# Verificar logs
docker logs sqlserver_dev

# Verificar permisos de PowerShell
.\verificar-admin-powershell.ps1

# Ejecutar diagnóstico completo
python diagnostico.py
```

### Error de conexión
```powershell
# Verificar que el contenedor esté corriendo
docker ps --filter "name=sqlserver_dev"

# Verificar puerto 1433
netstat -ano | findstr :1433

# Probar conexión básica
telnet localhost 1433
```

### Problemas de permisos
1. **Ejecutar PowerShell como Administrador**
2. Verificar permisos con: `.\verificar-admin-powershell.ps1`
3. Reiniciar Docker Desktop si es necesario

### Base de datos no se crea
```bash
# Ejecutar diagnóstico
python diagnostico.py

# Forzar recreación
python main.py
```

## 📈 Monitoreo y Logs

### Ver logs en tiempo real
```powershell
docker logs -f sqlserver_dev
```

### Verificar salud del contenedor
```powershell
docker inspect sqlserver_dev --format="{{.State.Health.Status}}"
```

### Conectar directamente al contenedor
```powershell
docker exec -it sqlserver_dev bash
```

## 🚦 Estado del Sistema

Para verificar que todo esté funcionando correctamente:

```bash
# 1. Verificar Docker
docker ps

# 2. Ejecutar diagnóstico
python diagnostico.py

# 3. Verificar estructura de BD
python main.py
```

Deberías ver:
- ✅ Contenedor `sqlserver_dev` ejecutándose
- ✅ Puerto 1433 abierto y accesible
- ✅ Base de datos DGBIDB creada
- ✅ Tablas y vistas funcionando

## 🔐 Seguridad

⚠️ **IMPORTANTE:** Esta configuración es para desarrollo local únicamente.

Para producción, considera:
- Cambiar contraseñas por defecto
- Configurar SSL/TLS
- Implementar autenticación robusta
- Restringir acceso de red
- Configurar backups automáticos

## 📞 Comandos de Ayuda Rápida

| Problema | Comando |
|----------|---------|
| ¿Está corriendo? | `docker ps` |
| Ver logs | `docker logs sqlserver_dev` |
| Reiniciar | `docker-compose restart` |
| Diagnóstico completo | `python diagnostico.py` |
| Recrear estructura | `python main.py` |
| Verificar permisos | `.\verificar-admin-powershell.ps1` |

---

## 🎯 Flujo de Trabajo Típico

1. **Inicio del día:**
   ```powershell
   docker-compose up -d
   ```

2. **Verificar sistema:**
   ```bash
   python diagnostico.py
   ```

3. **Trabajar con DBeaver/Python** usando los datos de conexión

4. **Final del día:**
   ```powershell
   docker-compose stop
   ```

¡Listo para desarrollar! 🚀