import pyodbc
import subprocess
import time

def verificar_docker():
    """Verificar que Docker esté corriendo"""
    print("🐳 Verificando Docker...")
    try:
        result = subprocess.run(['docker', 'ps'], capture_output=True, text=True)
        if result.returncode == 0:
            print("✅ Docker está corriendo")
            
            # Buscar contenedor SQL Server
            if 'sqlserver_dev' in result.stdout:
                print("✅ Contenedor sqlserver_dev encontrado")
                
                # Ver estado del contenedor
                status_cmd = ['docker', 'inspect', 'sqlserver_dev', '--format={{.State.Status}}']
                status_result = subprocess.run(status_cmd, capture_output=True, text=True)
                status = status_result.stdout.strip()
                print(f"📊 Estado del contenedor: {status}")
                
                # Ver health check
                health_cmd = ['docker', 'inspect', 'sqlserver_dev', '--format={{.State.Health.Status}}']
                health_result = subprocess.run(health_cmd, capture_output=True, text=True)
                health = health_result.stdout.strip()
                print(f"🏥 Health check: {health}")
                
                return status == 'running'
            else:
                print("❌ Contenedor sqlserver_dev no encontrado")
                return False
        else:
            print("❌ Docker no está corriendo")
            return False
    except Exception as e:
        print(f"❌ Error verificando Docker: {e}")
        return False

def verificar_puerto():
    """Verificar que el puerto 1433 esté disponible"""
    print("\n🔌 Verificando puerto 1433...")
    try:
        import socket
        sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        sock.settimeout(5)
        result = sock.connect_ex(('localhost', 1433))
        sock.close()
        
        if result == 0:
            print("✅ Puerto 1433 está abierto y aceptando conexiones")
            return True
        else:
            print("❌ Puerto 1433 no está disponible")
            return False
    except Exception as e:
        print(f"❌ Error verificando puerto: {e}")
        return False

def verificar_drivers_odbc():
    """Verificar drivers ODBC disponibles"""
    print("\n🔧 Verificando drivers ODBC...")
    try:
        drivers = pyodbc.drivers()
        print("📋 Drivers ODBC disponibles:")
        for driver in drivers:
            print(f"   - {driver}")
        
        # Buscar driver de SQL Server
        sql_drivers = [d for d in drivers if 'SQL Server' in d]
        if sql_drivers:
            print(f"✅ Driver de SQL Server encontrado: {sql_drivers[0]}")
            return True
        else:
            print("❌ No se encontró driver de SQL Server")
            return False
    except Exception as e:
        print(f"❌ Error verificando drivers: {e}")
        return False

def probar_conexion_basica():
    """Probar conexión básica a SQL Server"""
    print("\n🔗 Probando conexión básica...")
    
    connection_string = (
        'DRIVER={ODBC Driver 17 for SQL Server};'
        'SERVER=localhost,1433;'
        'DATABASE=master;'
        'UID=sa;'
        'PWD=MyStrongPass123!;'
        'TrustServerCertificate=yes;'
    )
    
    try:
        print("   Intentando conectar...")
        connection = pyodbc.connect(connection_string, timeout=10)
        print("✅ Conexión exitosa a SQL Server")
        
        cursor = connection.cursor()
        cursor.execute("SELECT @@VERSION")
        version = cursor.fetchone()[0]
        print(f"📊 Versión SQL Server: {version[:50]}...")
        
        cursor.execute("SELECT DB_NAME()")
        db_name = cursor.fetchone()[0]
        print(f"📊 Base de datos actual: {db_name}")
        
        cursor.close()
        connection.close()
        return True
        
    except Exception as e:
        print(f"❌ Error de conexión: {e}")
        return False

def mostrar_logs_sql_server():
    """Mostrar logs recientes de SQL Server"""
    print("\n📋 Logs recientes de SQL Server:")
    try:
        result = subprocess.run(['docker', 'logs', 'sqlserver_dev', '--tail', '15'], 
                              capture_output=True, text=True)
        if result.returncode == 0:
            print(result.stdout)
        else:
            print("❌ No se pudieron obtener los logs")
    except Exception as e:
        print(f"❌ Error obteniendo logs: {e}")

def diagnostico_completo():
    """Ejecutar diagnóstico completo"""
    print("🔍 DIAGNÓSTICO COMPLETO DEL SISTEMA")
    print("=" * 50)
    
    # 1. Verificar Docker
    docker_ok = verificar_docker()
    
    # 2. Verificar puerto
    puerto_ok = verificar_puerto()
    
    # 3. Verificar drivers
    drivers_ok = verificar_drivers_odbc()
    
    # 4. Mostrar logs
    mostrar_logs_sql_server()
    
    # 5. Probar conexión si todo está bien
    if docker_ok and puerto_ok and drivers_ok:
        conexion_ok = probar_conexion_basica()
    else:
        conexion_ok = False
    
    print("\n" + "=" * 50)
    print("📊 RESUMEN DEL DIAGNÓSTICO:")
    print(f"   🐳 Docker: {'✅' if docker_ok else '❌'}")
    print(f"   🔌 Puerto 1433: {'✅' if puerto_ok else '❌'}")
    print(f"   🔧 Drivers ODBC: {'✅' if drivers_ok else '❌'}")
    print(f"   🔗 Conexión SQL: {'✅' if conexion_ok else '❌'}")
    
    if all([docker_ok, puerto_ok, drivers_ok, conexion_ok]):
        print("\n🎉 ¡Todo está funcionando correctamente!")
        print("   Puedes ejecutar: python main.py")
    else:
        print("\n🔧 SOLUCIONES SUGERIDAS:")
        if not docker_ok:
            print("   - Ejecutar: docker-compose up -d")
            print("   - Esperar 60 segundos para que SQL Server inicie")
        if not puerto_ok:
            print("   - Verificar que no haya otro servicio en puerto 1433")
            print("   - Reiniciar el contenedor: docker-compose restart")
        if not drivers_ok:
            print("   - Instalar: https://docs.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server")

if __name__ == "__main__":
    diagnostico_completo()