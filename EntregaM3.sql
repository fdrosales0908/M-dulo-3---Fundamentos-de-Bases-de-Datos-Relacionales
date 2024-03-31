--- ===========ENTREGABLE M3: BASES RELACIONALES DE ALKE WALLET ==========================

--- ************Francesca Rosales Rojas***********************

--- 1. Crear BBDD

CREATE DATABASE alkewallet;
USE alkewallet;

--- 2. Crear tablas 

--- 2.1. Tabla usuarios
CREATE TABLE usuarios (
    user_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    correo VARCHAR(50) NOT NULL,
    contraseña INT NOT NULL,
    saldo INT NOT NULL
);

--- insertar datos ejemplo
INSERT INTO usuarios (nombre, correo, contraseña, saldo)
VALUES 
    ('Juan Perez', 'jp@gmail.com', '123', 100000),
    ('Armando Mendoza', 'am@gmail.com', '456', 50000),
    ('Beatriz Pinzón', 'bp@gmail.com', '789', 60000);


--- consulta
SELECT * FROM usuarios;

--- 2.2. Tabla transacción
CREATE TABLE transaccion (
    transaccion_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    sender_user_id INT NOT NULL,
    FOREIGN KEY (sender_user_id) REFERENCES usuarios(user_id), /*hay hacer referencia a la tabla de usuarios */
    receiver_user_id INT NOT NULL,
    FOREIGN KEY (receiver_user_id) REFERENCES usuarios(user_id),/*hay hacer referencia a la tabla de usuarios */
    importe INT NOT NULL,
    transaccion_date DATE NOT NULL
);

--- insertar dato
INSERT INTO transaccion (sender_user_id, receiver_user_id, importe, transaccion_date)
VALUES 
    (1, 2, 350000, '2022-03-31'),
    (2, 3, 690000, '2023-05-07'),
    (3, 1, 489000, '2023-11-12');

    
--- consulta
SELECT * FROM transaccion;


--- 2.3. Tabla moneda
CREATE TABLE moneda (
    currency_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(50) NOT NULL
);

--- insertar dato

INSERT INTO moneda (currency_id, currency_name, currency_symbol)
VALUES 
    (1, "Libra", '£'),
    (2, "Euro", '€'),
    (3, "Dolar", '$');


--- consulta
SELECT * FROM moneda;

--- ================ 3. CONSULTAS======================

--- 3.1. Consulta para obtener el nombre de la moneda elegida por un usuario específico

SELECT * FROM moneda
INNER JOIN transaccion ON currency_id=transaccion_id
INNER JOIN usuarios ON transaccion.transaccion_id=user_id;

--- ahora, de la tabla necesito conocer, por ejemplo, solo la columna currency_name del usuario "2" (o sea, que es EURO)

SELECT moneda.currency_name FROM moneda
INNER JOIN transaccion ON currency_id=transaccion_id
INNER JOIN usuarios ON transaccion.transaccion_id=user_id 
WHERE usuarios.user_id="2";


--- 3.2. Consulta para obtener todas las transacciones registradas

SELECT * FROM transaccion;

--- 3.3. Consulta para obtener todas las transacciones realizadas por un usuario específico

SELECT transaccion.importe FROM transaccion
INNER JOIN usuarios ON transaccion.transaccion_id=user_id 
WHERE usuarios.user_id="2";

--- 3.4. Sentencia DML para modificar el campo correo electrónico de un usuario específico

UPDATE usuarios
SET correo = 'jp_nuevo@gmail.com'
WHERE user_id = 1;

--- Comprobar la actualización

SELECT* FROM usuarios;

--- 3.5. Sentencia para eliminar los datos de una transacción (eliminado de la fila completa)

DELETE FROM transaccion
WHERE transaccion_id = 1;

--- Comprobar la actualización

SELECT* FROM transaccion;