# SQL Server en Docker para Desarrollo

Este proyecto configura una instancia de SQL Server 2022 en Docker Desktop con volumen persistente para uso con DBeaver y Python.

## 🚀 Inicio Rápido

### Prerrequisitos
- Docker Desktop instalado y ejecutándose
- PowerShell (para Windows)
- DBeaver (para administración de base de datos)
- Python con pandas y pyodbc (opcional, para ejemplos)

### 1. Configuración Automática
```powershell
# Ejecutar en PowerShell como Administrador
.\setup.ps1
```

### 2. Configuración Manual
```bash
# Crear directorio de volumen
mkdir "C:\Desarrollo\Sqlserver\volumen"

# Levantar contenedor
docker-compose up -d

# Verificar estado
docker ps
```

## 📊 Conexión con DBeaver

### Datos de Conexión:
- **Driver**: SQL Server (Microsoft)
- **Host**: `localhost`
- **Puerto**: `1433`
- **Database**: `master` (inicial)
- **Usuario**: `sa`
- **Contraseña**: `MyStrongPass123!`

### Pasos en DBeaver:
1. **Nueva Conexión** → **SQL Server**
2. **Configuración Principal**:
   ```
   Server Host: localhost
   Port: 1433
   Database/Schema: master
   ```
3. **Autenticación**:
   ```
   Authentication: SQL Server Authentication
   Username: sa
   Password: MyStrongPass123!
   ```
4. **Test Connection** → **Finish**

## 🐳 Comandos Docker Útiles

```bash
# Ver estado de contenedores
docker ps

# Ver logs de SQL Server
docker logs sqlserver_dev

# Entrar al contenedor
docker exec -it sqlserver_dev bash

# Detener servicios
docker-compose down

# Reiniciar servicios
docker-compose restart

# Eliminar todo (incluyendo volúmenes)
docker-compose down -v
```

## 📁 Estructura del Proyecto

```
proyecto/
├── docker-compose.yml      # Configuración de Docker Compose
├── .env                   # Variables de entorno
├── setup.ps1             # Script de inicialización
├── main.py               # Ejemplos de uso con Python
├── sqlserver_connection.py # Clase de conexión (crear por separado)
└── README.md             # Este archivo
```

## 🔧 Configuración de Python

### Instalar dependencias:
```bash
pip install pandas pyodbc sqlalchemy
```

### Ejecutar ejemplos:
```bash
python main.py
```

## 📋 Características

✅ **SQL Server 2022 Developer Edition**  
✅ **Volumen persistente en C:\Desarrollo\Sqlserver\volumen**  
✅ **Puerto 1433 expuesto para conexiones externas**  
✅ **Healthcheck configurado**  
✅ **Compatible con DBeaver**  
✅ **Red Docker dedicada**  
✅ **Reinicio automático**  

## 🛠️ Resolución de Problemas

### SQL Server no inicia:
```bash
# Ver logs detallados
docker logs sqlserver_dev

# Verificar permisos de carpeta
# La carpeta C:\Desarrollo\Sqlserver\volumen debe tener permisos de escritura
```

### No se puede conectar desde DBeaver:
- Verificar que el contenedor esté corriendo: `docker ps`
- Verificar que el puerto 1433 no esté ocupado
- Verificar firewall de Windows
- Probar conexión con `telnet localhost 1433`

### Error de autenticación:
- Usuario: `sa`
- Contraseña: `MyStrongPass123!`
- Verificar que SQL Server Authentication esté habilitado

## 🔐 Seguridad

⚠️ **IMPORTANTE**: Esta configuración es solo para desarrollo local. Para producción:
- Cambiar la contraseña por defecto
- Configurar SSL/TLS
- Implementar autenticación basada en tokens
- Restringir acceso de red

## 📝 Notas Adicionales

- Los datos se persisten en `C:\Desarrollo\Sqlserver\volumen`
- El contenedor se reinicia automáticamente
- Collation configurado como `SQL_Latin1_General_CP1_CI_AS`
- Se puede cambiar el puerto en el archivo `.env` si es necesario