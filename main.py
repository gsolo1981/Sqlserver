from sqlserver_connection import SQLServerConnection
import pandas as pd
import os
import re

def verificar_sql_server():
    """Verificar que SQL Server esté corriendo y sea accesible"""
    print("🔍 Verificando conexión a SQL Server...")
    
    try:
        db = SQLServerConnection(database='master')
        success = db.connect_pyodbc()
        
        if success:
            result = db.execute_query("SELECT @@VERSION as version", return_dataframe=True)
            if isinstance(result, pd.DataFrame) and not result.empty:
                version_info = result['version'].iloc[0][:50]
                print(f"✅ SQL Server conectado exitosamente")
                print(f"   Versión: {version_info}...")
                db.close()
                return True
            else:
                print("❌ Error: No se pudo ejecutar consulta de prueba")
                db.close()
                return False
        else:
            print("❌ Error: No se pudo conectar a SQL Server")
            return False
            
    except Exception as e:
        print(f"❌ Error conectando a SQL Server: {e}")
        return False

def crear_base_datos_si_no_existe():
    """Crear la base de datos DGBIDB si no existe"""
    print("🔍 Verificando base de datos DGBIDB...")
    
    try:
        db = SQLServerConnection(database='master')
        success = db.connect_pyodbc()
        
        if not success:
            print("❌ No se pudo conectar a la base de datos master")
            return False
        
        # Verificar si existe la base de datos
        if db.database_exists('DGBIDB'):
            print("✅ Base de datos DGBIDB ya existe")
            db.close()
            return True
        else:
            print("📊 Creando base de datos 'DGBIDB'...")
            
            # Usar el método especial para CREATE DATABASE
            success = db.create_database('DGBIDB')
            
            if success:
                print("✅ Base de datos DGBIDB creada exitosamente")
                db.close()
                return True
            else:
                print("❌ No se pudo crear la base de datos")
                db.close()
                return False
            
    except Exception as e:
        print(f"❌ Error con base de datos: {e}")
        if 'db' in locals():
            db.close()
        return False

def ejecutar_script_createdb():
    """Ejecutar el script createDB.sql"""
    print("\n🚀 Ejecutando script createDB.sql...")
    
    script_path = "createDB.sql"
    
    # Verificar que existe el archivo
    if not os.path.exists(script_path):
        print(f"❌ No se encontró el archivo: {script_path}")
        print("💡 Asegúrate de que esté en el directorio raíz del proyecto")
        return False
    
    try:
        # Leer el script SQL
        with open(script_path, 'r', encoding='utf-8') as file:
            script_content = file.read()
        
        print(f"📋 Script leído correctamente ({len(script_content)} caracteres)")
        
        # Conectar a la base de datos DGBIDB
        db = SQLServerConnection(database='DGBIDB')
        success = db.connect_pyodbc()
        
        if not success:
            print("❌ No se pudo conectar a la base de datos DGBIDB")
            return False
        
        # Procesar el script dividiendo por GO
        statements = procesar_script_sql(script_content)
        
        print(f"📊 Se encontraron {len(statements)} declaraciones SQL para ejecutar")
        
        # Ejecutar cada declaración
        ejecutadas = 0
        errores = 0
        
        for i, statement in enumerate(statements, 1):
            if statement.strip():
                try:
                    print(f"   📝 Ejecutando declaración {i}/{len(statements)}...")
                    
                    # Ejecutar la declaración usando el método raw
                    success = db.execute_raw_sql(statement)
                    
                    if success:
                        ejecutadas += 1
                        
                        # Mostrar información específica según el tipo de declaración
                        if "CREATE TABLE" in statement.upper():
                            tabla_nombre = extraer_nombre_tabla(statement)
                            print(f"      ✅ Tabla creada: {tabla_nombre}")
                        elif "CREATE VIEW" in statement.upper():
                            vista_nombre = extraer_nombre_vista(statement)
                            print(f"      ✅ Vista creada: {vista_nombre}")
                        elif "INSERT INTO" in statement.upper():
                            tabla_nombre = extraer_tabla_insert(statement)
                            print(f"      ✅ Datos insertados en: {tabla_nombre}")
                        elif "PRINT" in statement.upper():
                            mensaje = extraer_mensaje_print(statement)
                            if mensaje:
                                print(f"      💬 {mensaje}")
                        else:
                            print(f"      ✅ Declaración ejecutada")
                    else:
                        errores += 1
                        
                except Exception as e:
                    error_msg = str(e)
                    # Ignorar errores de objetos que ya existen
                    if any(x in error_msg.lower() for x in ["already exists", "ya existe", "duplicate"]):
                        print(f"      ℹ️ Objeto ya existe (omitido)")
                        ejecutadas += 1
                    else:
                        print(f"      ❌ Error: {error_msg[:100]}...")
                        errores += 1
        
        print(f"\n📊 Resumen de ejecución:")
        print(f"   ✅ Declaraciones ejecutadas: {ejecutadas}")
        print(f"   ❌ Errores: {errores}")
        print(f"   📋 Total procesadas: {len(statements)}")
        
        db.close()
        return errores == 0
        
    except Exception as e:
        print(f"❌ Error ejecutando script: {e}")
        return False

def procesar_script_sql(script_content):
    """Procesar el script SQL dividiendo por GO"""
    
    # Remover comentarios de línea completa
    lines = script_content.split('\n')
    clean_lines = []
    
    for line in lines:
        # Mantener la línea si no es un comentario completo
        stripped = line.strip()
        if not stripped.startswith('--') or 'PRINT' in line.upper():
            clean_lines.append(line)
    
    cleaned_script = '\n'.join(clean_lines)
    
    # Dividir por GO (case insensitive)
    statements = re.split(r'\bGO\b', cleaned_script, flags=re.IGNORECASE)
    
    # Limpiar cada declaración
    clean_statements = []
    for statement in statements:
        statement = statement.strip()
        if statement and not statement.startswith('--'):
            clean_statements.append(statement)
    
    return clean_statements

def extraer_nombre_tabla(statement):
    """Extraer nombre de tabla de CREATE TABLE"""
    try:
        match = re.search(r'CREATE TABLE\s+(?:dbo\.)?(\[?[\w_]+\]?)', statement, re.IGNORECASE)
        if match:
            return match.group(1).replace('[', '').replace(']', '')
        return "tabla_desconocida"
    except:
        return "tabla_desconocida"

def extraer_nombre_vista(statement):
    """Extraer nombre de vista de CREATE VIEW"""
    try:
        match = re.search(r'CREATE VIEW\s+(?:dbo\.)?(\[?[\w_]+\]?)', statement, re.IGNORECASE)
        if match:
            return match.group(1).replace('[', '').replace(']', '')
        return "vista_desconocida"
    except:
        return "vista_desconocida"

def extraer_tabla_insert(statement):
    """Extraer nombre de tabla de INSERT INTO"""
    try:
        match = re.search(r'INSERT INTO\s+(?:dbo\.)?(\[?[\w_]+\]?)', statement, re.IGNORECASE)
        if match:
            return match.group(1).replace('[', '').replace(']', '')
        return "tabla_desconocida"
    except:
        return "tabla_desconocida"

def extraer_mensaje_print(statement):
    """Extraer mensaje de PRINT"""
    try:
        match = re.search(r"PRINT\s+'([^']+)'", statement, re.IGNORECASE)
        if match:
            return match.group(1)
        return None
    except:
        return None

def verificar_estructura_creada():
    """Verificar la estructura final creada"""
    print("\n🔍 Verificando estructura creada...")
    
    try:
        db = SQLServerConnection(database='DGBIDB')
        success = db.connect_pyodbc()
        
        if not success:
            print("❌ No se pudo conectar para verificar estructura")
            return False
        
        # Contar tablas
        tablas_query = """
        SELECT COUNT(*) as total_tablas
        FROM INFORMATION_SCHEMA.TABLES 
        WHERE TABLE_SCHEMA = 'dbo'
        """
        result_tablas = db.execute_query(tablas_query, return_dataframe=True)
        total_tablas = result_tablas['total_tablas'].iloc[0] if isinstance(result_tablas, pd.DataFrame) else 0
        
        # Contar vistas
        vistas_query = """
        SELECT COUNT(*) as total_vistas
        FROM INFORMATION_SCHEMA.VIEWS 
        WHERE TABLE_SCHEMA = 'dbo'
        """
        result_vistas = db.execute_query(vistas_query, return_dataframe=True)
        total_vistas = result_vistas['total_vistas'].iloc[0] if isinstance(result_vistas, pd.DataFrame) else 0
        
        print(f"📊 Estructura verificada:")
        print(f"   📋 Tablas creadas: {total_tablas}")
        print(f"   👁️ Vistas creadas: {total_vistas}")
        
        # Mostrar algunas tablas importantes
        tablas_importantes = [
            '25_ENTES',
            'Bienes_01_BENEFICIARIOS', 
            'Bienes_02_CARTERAS',
            'Concesiones_01_BENEFICIARIOS'
        ]
        
        print(f"\n🎯 Verificando tablas importantes:")
        for tabla in tablas_importantes:
            existe_query = f"""
            SELECT COUNT(*) as existe 
            FROM INFORMATION_SCHEMA.TABLES 
            WHERE TABLE_SCHEMA = 'dbo' AND TABLE_NAME = '{tabla}'
            """
            result = db.execute_query(existe_query, return_dataframe=True)
            existe = result['existe'].iloc[0] > 0 if isinstance(result, pd.DataFrame) else False
            status = "✅" if existe else "❌"
            print(f"   {status} {tabla}")
        
        # Verificar datos de ejemplo
        if total_tablas > 0:
            print(f"\n📊 Verificando datos de ejemplo:")
            try:
                entes_query = "SELECT COUNT(*) as total FROM dbo.[25_ENTES]"
                entes_result = db.execute_query(entes_query, return_dataframe=True)
                total_entes = entes_result['total'].iloc[0] if isinstance(entes_result, pd.DataFrame) else 0
                print(f"   📋 Registros en ENTES: {total_entes}")
                
                if total_entes > 0:
                    print(f"\n📋 Primeros registros de ENTES:")
                    entes_data = db.execute_query("SELECT TOP 3 * FROM dbo.[25_ENTES]", return_dataframe=True)
                    if isinstance(entes_data, pd.DataFrame):
                        print(entes_data.to_string(index=False))
                        
            except Exception as e:
                print(f"   ⚠️ Error verificando datos: {e}")
        
        db.close()
        return True
        
    except Exception as e:
        print(f"❌ Error verificando estructura: {e}")
        return False

def main():
    """Función principal"""
    print("🚀 SISTEMA DE INICIALIZACIÓN DE BASE DE DATOS")
    print("📋 Ejecutando script createDB.sql")
    print("=" * 60)
    
    try:
        # Paso 1: Verificar SQL Server
        if not verificar_sql_server():
            print("\n❌ SQL Server no está disponible")
            print("💡 Ejecuta: docker-compose up -d")
            return
        
        # Paso 2: Crear base de datos si no existe
        if not crear_base_datos_si_no_existe():
            print("❌ No se pudo preparar la base de datos")
            return
        
        # Paso 3: Ejecutar script createDB.sql
        if not ejecutar_script_createdb():
            print("⚠️ Hubo algunos errores ejecutando el script, pero puede haber funcionado parcialmente")
        
        # Paso 4: Verificar estructura creada
        verificar_estructura_creada()
        
        print("\n" + "=" * 60)
        print("🎉 ¡PROCESO COMPLETADO!")
        print("\n📊 Información de conexión para DBeaver:")
        print("   🌐 Host: localhost")
        print("   🔌 Puerto: 1433")
        print("   🗄️ Base de datos: DGBIDB")
        print("   👤 Usuario: sa")
        print("   🔑 Contraseña: MyStrongPass123!")
        
        print("\n🎯 ¡Ya puedes conectarte y explorar la base de datos!")
        
    except Exception as e:
        print(f"\n❌ Error general: {e}")
        print("💡 Revisa que SQL Server esté corriendo: docker ps")

if __name__ == "__main__":
    main()