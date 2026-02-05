import psycopg2
from psycopg2 import Error

def conectar_y_consultar(): 
    connection = None
    cursor = None
    try:
        # Paso B y C: Intentar Conexión
        connection = psycopg2.connect(
            user="tu_usuario",
            password="tu_password",
            host="127.0.0.1",
            port="5432",
            database="tu_base_de_datos"
        )

        # Paso F: Crear Cursor
        cursor = connection.cursor()
        
        # Paso G: Ejecutar Consulta
        query = "SELECT * FROM usuarios;"
        cursor.execute(query)
        
        # Paso K y M: Obtener y Procesar resultados
        registros = cursor.fetchall()
        for fila in registros:
            print(f"Usuario: {fila}")

    except (Exception, Error) as error:
        # Paso E y L: Manejo de errores
        print("Error mientras se conectaba a PostgreSQL", error)
        
    finally:
        # Paso N: Cerrar conexión
        if cursor:
            cursor.close()
        if connection:
            connection.close()
            print("Conexión a PostgreSQL cerrada.")

# Paso A: Inicio
if __name__ == "__main__":
    conectar_y_consultar()
