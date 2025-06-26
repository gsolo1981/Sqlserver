import pyodbc
import pandas as pd
from sqlalchemy import create_engine
import urllib.parse

class SQLServerConnection:
    """
    Clase para manejar conexiones a SQL Server usando PyODBC y SQLAlchemy
    """
    
    def __init__(self, server='localhost', database='master', username='sa', password='MyStrongPass123!', port=1433):
        self.server = server
        self.database = database
        self.username = username
        self.password = password
        self.port = port
        self.connection = None
        self.engine = None
        
    def connect_pyodbc(self, autocommit=False):
        """Conectar usando PyODBC con opción de autocommit"""
        try:
            # Cadena de conexión para PyODBC
            connection_string = (
                f'DRIVER={{ODBC Driver 17 for SQL Server}};'
                f'SERVER={self.server},{self.port};'
                f'DATABASE={self.database};'
                f'UID={self.username};'
                f'PWD={self.password};'
                f'TrustServerCertificate=yes;'
            )
            
            self.connection = pyodbc.connect(connection_string)
            
            # Configurar autocommit si es necesario
            if autocommit:
                self.connection.autocommit = True
            
            print(f"✅ Conectado a SQL Server: {self.server}\\{self.database}")
            return True
            
        except Exception as e:
            print(f"❌ Error conectando con PyODBC: {e}")
            return False
    
    def create_database(self, database_name):
        """Crear base de datos usando autocommit para evitar problemas de transacción"""
        try:
            # Crear una conexión específica con autocommit para CREATE DATABASE
            connection_string = (
                f'DRIVER={{ODBC Driver 17 for SQL Server}};'
                f'SERVER={self.server},{self.port};'
                f'DATABASE=master;'
                f'UID={self.username};'
                f'PWD={self.password};'
                f'TrustServerCertificate=yes;'
            )
            
            # Conexión con autocommit para CREATE DATABASE
            temp_connection = pyodbc.connect(connection_string)
            temp_connection.autocommit = True
            
            cursor = temp_connection.cursor()
            cursor.execute(f"CREATE DATABASE {database_name}")
            cursor.close()
            temp_connection.close()
            
            return True
            
        except Exception as e:
            error_msg = str(e).lower()
            # Si la base de datos ya existe, no es un error
            if 'already exists' in error_msg or ('database' in error_msg and 'exists' in error_msg):
                return True
            else:
                print(f"❌ Error creando base de datos: {e}")
                return False
    
    def database_exists(self, database_name):
        """Verificar si una base de datos existe"""
        try:
            cursor = self.connection.cursor()
            cursor.execute("SELECT name FROM sys.databases WHERE name = ?", database_name)
            result = cursor.fetchone()
            cursor.close()
            return result is not None
        except Exception as e:
            print(f"❌ Error verificando base de datos: {e}")
            return False
    
    def connect_sqlalchemy(self):
        """Conectar usando SQLAlchemy (útil para pandas)"""
        try:
            # URL encode de la contraseña para SQLAlchemy
            password_encoded = urllib.parse.quote_plus(self.password)
            
            # Cadena de conexión para SQLAlchemy
            connection_string = (
                f'mssql+pyodbc://{self.username}:{password_encoded}@'
                f'{self.server}:{self.port}/{self.database}?'
                f'driver=ODBC+Driver+17+for+SQL+Server&'
                f'TrustServerCertificate=yes'
            )
            
            self.engine = create_engine(connection_string)
            
            # Probar la conexión
            with self.engine.connect() as conn:
                conn.execute("SELECT 1")
                
            print(f"✅ Engine SQLAlchemy creado: {self.server}\\{self.database}")
            return self.engine
            
        except Exception as e:
            print(f"❌ Error creando engine SQLAlchemy: {e}")
            return None
    
    def execute_query(self, query, return_dataframe=True):
        """
        Ejecutar consulta SQL
        
        Args:
            query (str): Consulta SQL a ejecutar
            return_dataframe (bool): Si True, retorna DataFrame; si False, retorna resultado directo
        
        Returns:
            pandas.DataFrame o resultado de la consulta
        """
        try:
            if not self.connection:
                self.connect_pyodbc()
            
            if query.strip().upper().startswith('SELECT') and return_dataframe:
                # Para consultas SELECT, retornar DataFrame
                # Suprimir warning de pandas temporalmente
                import warnings
                with warnings.catch_warnings():
                    warnings.simplefilter("ignore")
                    df = pd.read_sql(query, self.connection)
                return df
            else:
                # Para INSERT, UPDATE, DELETE, CREATE, etc.
                cursor = self.connection.cursor()
                cursor.execute(query)
                
                # Si es una consulta que retorna filas
                if query.strip().upper().startswith('SELECT'):
                    results = cursor.fetchall()
                    columns = [desc[0] for desc in cursor.description]
                    df = pd.DataFrame(results, columns=columns)
                    cursor.close()
                    return df
                else:
                    # Para operaciones de modificación
                    affected_rows = cursor.rowcount
                    if not self.connection.autocommit:
                        self.connection.commit()
                    cursor.close()
                    return f"✅ Consulta ejecutada. Filas afectadas: {affected_rows}"
                    
        except Exception as e:
            return f"❌ Error ejecutando consulta: {e}"
    
    def execute_raw_sql(self, sql_statement):
        """Ejecutar SQL crudo sin pandas"""
        try:
            if not self.connection:
                self.connect_pyodbc()
            
            cursor = self.connection.cursor()
            cursor.execute(sql_statement)
            
            if not self.connection.autocommit:
                self.connection.commit()
            
            cursor.close()
            return True
            
        except Exception as e:
            error_msg = str(e).lower()
            # Si el objeto ya existe, no es realmente un error
            if any(keyword in error_msg for keyword in ['already exists', 'duplicate', 'ya existe']):
                return True  # Considerarlo exitoso
            else:
                print(f"❌ Error ejecutando SQL: {e}")
                return False
    
    def execute_script(self, script_path):
        """Ejecutar script SQL desde archivo"""
        try:
            with open(script_path, 'r', encoding='utf-8') as file:
                script = file.read()
            
            # Dividir por GO statements (si existen)
            statements = script.split('GO')
            results = []
            
            for statement in statements:
                statement = statement.strip()
                if statement:
                    result = self.execute_query(statement, return_dataframe=False)
                    results.append(result)
            
            return results
            
        except Exception as e:
            return f"❌ Error ejecutando script: {e}"
    
    def test_connection(self):
        """Probar la conexión a la base de datos"""
        try:
            result = self.execute_query("SELECT @@VERSION as Version, DB_NAME() as CurrentDB")
            if isinstance(result, pd.DataFrame):
                print("🔍 Información de conexión:")
                print(f"Versión: {result['Version'].iloc[0][:50]}...")
                print(f"Base de datos actual: {result['CurrentDB'].iloc[0]}")
                return True
            return False
        except Exception as e:
            print(f"❌ Test de conexión falló: {e}")
            return False
    
    def list_databases(self):
        """Listar bases de datos disponibles"""
        query = "SELECT name FROM sys.databases WHERE database_id > 4"  # Excluir system DBs
        return self.execute_query(query)
    
    def list_tables(self):
        """Listar tablas en la base de datos actual"""
        query = """
        SELECT 
            TABLE_SCHEMA as Esquema,
            TABLE_NAME as Tabla,
            TABLE_TYPE as Tipo
        FROM INFORMATION_SCHEMA.TABLES 
        ORDER BY TABLE_SCHEMA, TABLE_NAME
        """
        return self.execute_query(query)
    
    def get_table_info(self, table_name, schema='dbo'):
        """Obtener información de columnas de una tabla"""
        query = f"""
        SELECT 
            COLUMN_NAME as Columna,
            DATA_TYPE as TipoDato,
            IS_NULLABLE as Nullable,
            COLUMN_DEFAULT as ValorPorDefecto
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_NAME = '{table_name}' 
        AND TABLE_SCHEMA = '{schema}'
        ORDER BY ORDINAL_POSITION
        """
        return self.execute_query(query)
    
    def close(self):
        """Cerrar conexiones"""
        try:
            if self.connection:
                self.connection.close()
                print("🔒 Conexión PyODBC cerrada")
            
            if self.engine:
                self.engine.dispose()
                print("🔒 Engine SQLAlchemy cerrado")
                
        except Exception as e:
            print(f"⚠️ Error cerrando conexiones: {e}")
    
    def __enter__(self):
        """Context manager entry"""
        self.connect_pyodbc()
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        """Context manager exit"""
        self.close()
    
    def __str__(self):
        """Representación string de la conexión"""
        return f"SQLServerConnection(server={self.server}, database={self.database}, user={self.username})"