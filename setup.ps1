# Script de inicialización para SQL Server Docker
# Ejecutar como Administrador en PowerShell

Write-Host "🚀 Configurando SQL Server en Docker..." -ForegroundColor Green

# Crear directorio para el volumen si no existe
$volumePath = "C:\Desarrollo\Sqlserver\volumen"
if (-not (Test-Path $volumePath)) {
    Write-Host "📁 Creando directorio de volumen: $volumePath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $volumePath -Force
    Write-Host "✅ Directorio creado exitosamente" -ForegroundColor Green
} else {
    Write-Host "✅ El directorio de volumen ya existe" -ForegroundColor Green
}

# Verificar que Docker Desktop esté corriendo
Write-Host "🐳 Verificando Docker Desktop..." -ForegroundColor Yellow
try {
    $dockerStatus = docker version --format "{{.Server.Version}}"
    Write-Host "✅ Docker Desktop está ejecutándose (versión: $dockerStatus)" -ForegroundColor Green
} catch {
    Write-Host "❌ Docker Desktop no está ejecutándose. Por favor, inicia Docker Desktop y vuelve a ejecutar este script." -ForegroundColor Red
    exit 1
}

# Detener y eliminar contenedor existente si existe
Write-Host "🧹 Limpiando contenedores existentes..." -ForegroundColor Yellow
docker stop sqlserver_dev 2>$null
docker rm sqlserver_dev 2>$null

# Levantar el contenedor con docker-compose
Write-Host "🚀 Levantando SQL Server con docker-compose..." -ForegroundColor Yellow
docker-compose down -v
docker-compose up -d

# Esperar a que el contenedor esté listo
Write-Host "⏳ Esperando a que SQL Server esté listo..." -ForegroundColor Yellow
$maxAttempts = 30
$attempt = 0

do {
    $attempt++
    Start-Sleep -Seconds 5
    $health = docker inspect sqlserver_dev --format="{{.State.Health.Status}}" 2>$null
    Write-Host "Intento $attempt/$maxAttempts - Estado: $health" -ForegroundColor Cyan
} while ($health -ne "healthy" -and $attempt -lt $maxAttempts)

if ($health -eq "healthy") {
    Write-Host "✅ SQL Server está listo y funcionando!" -ForegroundColor Green
    Write-Host ""
    Write-Host "📊 Información de conexión para DBeaver:" -ForegroundColor Cyan
    Write-Host "  Host: localhost" -ForegroundColor White
    Write-Host "  Puerto: 1433" -ForegroundColor White
    Write-Host "  Usuario: sa" -ForegroundColor White
    Write-Host "  Contraseña: MyStrongPass123!" -ForegroundColor White
    Write-Host "  Base de datos: master (inicial)" -ForegroundColor White
    Write-Host ""
    Write-Host "🔧 Para conectarte desde Python, ejecuta: python main.py" -ForegroundColor Cyan
} else {
    Write-Host "❌ SQL Server no pudo iniciarse correctamente. Revisa los logs:" -ForegroundColor Red
    Write-Host "docker logs sqlserver_dev" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "📋 Comandos útiles:" -ForegroundColor Magenta
Write-Host "  Ver logs: docker logs sqlserver_dev" -ForegroundColor White
Write-Host "  Detener: docker-compose down" -ForegroundColor White
Write-Host "  Reiniciar: docker-compose restart" -ForegroundColor White
Write-Host "  Estado: docker ps" -ForegroundColor White