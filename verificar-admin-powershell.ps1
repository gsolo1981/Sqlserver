# 🔍 VERIFICAR SI POWERSHELL TIENE PERMISOS DE ADMINISTRADOR

Write-Host "🔍 VERIFICANDO PERMISOS DE POWERSHELL" -ForegroundColor Green
Write-Host "=" * 50

# Test 1: Verificar si es administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if ($isAdmin) {
    Write-Host "✅ PowerShell ejecutándose como ADMINISTRADOR" -ForegroundColor Green
} else {
    Write-Host "❌ PowerShell NO es administrador" -ForegroundColor Red
    Write-Host "🚨 ESTE ES EL PROBLEMA!" -ForegroundColor Yellow
}

# Test 2: Verificar usuario actual
$currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
Write-Host "👤 Usuario actual: $currentUser" -ForegroundColor Cyan

# Test 3: Verificar permisos en directorio actual
Write-Host "`n📁 Verificando permisos en directorio actual..." -ForegroundColor Yellow
try {
    $testFile = ".\test_permissions.tmp"
    "test" | Out-File $testFile -Force
    Remove-Item $testFile -Force
    Write-Host "✅ Permisos de escritura: OK" -ForegroundColor Green
} catch {
    Write-Host "❌ Sin permisos de escritura en directorio actual" -ForegroundColor Red
}

# Test 4: Verificar acceso a Docker
Write-Host "`n🐳 Verificando acceso a Docker..." -ForegroundColor Yellow
try {
    $dockerVersion = docker version --format "{{.Server.Version}}" 2>$null
    if ($dockerVersion) {
        Write-Host "✅ Docker accesible: versión $dockerVersion" -ForegroundColor Green
    } else {
        Write-Host "❌ Docker no accesible o requiere permisos" -ForegroundColor Red
    }
} catch {
    Write-Host "❌ Error accediendo a Docker: $($_.Exception.Message)" -ForegroundColor Red
}

# Test 5: Verificar permisos de volumen
Write-Host "`n💾 Verificando permisos de volumen..." -ForegroundColor Yellow
$volumePath = ".\volumen"
if (Test-Path $volumePath) {
    try {
        $acl = Get-Acl $volumePath
        Write-Host "✅ Volumen accesible - Propietario: $($acl.Owner)" -ForegroundColor Green
        
        # Test de escritura en volumen
        $testFile = "$volumePath\test_write.tmp"
        "test" | Out-File $testFile -Force 2>$null
        if (Test-Path $testFile) {
            Remove-Item $testFile -Force
            Write-Host "✅ Escritura en volumen: OK" -ForegroundColor Green
        } else {
            Write-Host "❌ Sin permisos de escritura en volumen" -ForegroundColor Red
        }
    } catch {
        Write-Host "❌ Error accediendo al volumen: $($_.Exception.Message)" -ForegroundColor Red
    }
} else {
    Write-Host "⚠️ Directorio volumen no existe" -ForegroundColor Yellow
}

# DIAGNÓSTICO FINAL
Write-Host "`n" + "=" * 50
Write-Host "📊 DIAGNÓSTICO FINAL" -ForegroundColor Green
Write-Host "=" * 50

if (-not $isAdmin) {
    Write-Host "🚨 PROBLEMA IDENTIFICADO: PowerShell sin permisos de administrador" -ForegroundColor Red
    Write-Host ""
    Write-Host "💡 SOLUCIÓN:" -ForegroundColor Yellow
    Write-Host "1. Cerrar PowerShell actual" -ForegroundColor White
    Write-Host "2. Hacer clic derecho en PowerShell" -ForegroundColor White
    Write-Host "3. Seleccionar 'Ejecutar como administrador'" -ForegroundColor White
    Write-Host "4. Navegar a: cd C:\Desarrollo\Unidad\Sqlserver" -ForegroundColor White
    Write-Host "5. Ejecutar: docker-compose down -v" -ForegroundColor White
    Write-Host "6. Ejecutar: docker-compose up -d" -ForegroundColor White
    Write-Host ""
    Write-Host "🔧 PROBLEMAS QUE ESTO SOLUCIONA:" -ForegroundColor Cyan
    Write-Host "   - Permisos de volumen para SQL Server" -ForegroundColor White
    Write-Host "   - Acceso completo a Docker" -ForegroundColor White
    Write-Host "   - Configuración de red y puertos" -ForegroundColor White
    Write-Host "   - Inicialización correcta de base de datos" -ForegroundColor White
} else {
    Write-Host "✅ PowerShell tiene permisos de administrador" -ForegroundColor Green
    Write-Host "El problema está en otro lado..." -ForegroundColor Yellow
}

Write-Host "`n⚡ COMANDO PARA ABRIR POWERSHELL COMO ADMIN:" -ForegroundColor Red
Write-Host "Start-Process powershell -Verb runAs" -ForegroundColor White
Write-Host "O presiona: Win + X → 'Windows PowerShell (Admin)'" -ForegroundColor White