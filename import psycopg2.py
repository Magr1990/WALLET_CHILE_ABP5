import psycopg2
from psycopg2 import Error

def conectar_y_consultar(): 
    connection = None
    cursor = None
    try:
        connection = psycopg2.connect(
            user="tu_usuario",
            password="tu_password",
            host="127.0.0.1",
            port="5432",
            database="wallet_db" 
        )

        cursor = connection.cursor()
        
        query = "SELECT user_id, nombre, correo_electronico FROM usuario;"
        cursor.execute(query)
        
        registros = cursor.fetchall()
        for fila in registros:
            print(f"Usuario: {fila}")

    except (Exception, Error) as error:
        print("Error mientras se conectaba a PostgreSQL", error)
        
    finally:
        if cursor:
            cursor.close()
        if connection:
            connection.close()
            print("Conexión a PostgreSQL cerrada.")

if __name__ == "__main__":
    conectar_y_consultar()
