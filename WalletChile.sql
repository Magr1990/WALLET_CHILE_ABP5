
CREATE TABLE IF NOT EXISTS moneda (
    currency_id SERIAL PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS usuario (
    user_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(100) NOT NULL,
    saldo DECIMAL(15, 2) DEFAULT 0.00
);

CREATE TABLE IF NOT EXISTS transaccion (
    transaction_id SERIAL PRIMARY KEY,
    sender_user_id INT,
    receiver_user_id INT,
    importe DECIMAL(15, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    currency_id INT,
    
    CONSTRAINT fk_sender FOREIGN KEY (sender_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_receiver FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_currency FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);

INSERT INTO moneda (currency_name, currency_symbol) VALUES 
('Peso Chileno', 'CLP'),
('Dolar Estadounidense', 'USD');

INSERT INTO usuario (nombre, correo_electronico, contrasena, saldo) VALUES 
('Juan Pérez', 'juan.perez@walletchile.cl', 'clave123', 250000),
('María González', 'maria.gonzalez@walletchile.cl', 'chile2024', 500000),
('Pedro Sánchez', 'pedro.sanchez@mail.com', 'pass123', 10000);

INSERT INTO transaccion (sender_user_id, receiver_user_id, importe, currency_id, transaction_date) VALUES 
(1, 3, 50000, 1, '2024-01-12 10:00:00'),
(2, 1, 20000, 1, '2024-01-13 15:30:00'),
(1, 2, 15000, 1, '2024-01-14 09:00:00');

SELECT DISTINCT m.currency_name 
FROM transaccion t
JOIN moneda m ON t.currency_id = m.currency_id
WHERE t.sender_user_id = 1;

SELECT * FROM transaccion;

SELECT * FROM transaccion 
WHERE sender_user_id = 1 OR receiver_user_id = 1;

UPDATE usuario 
SET correo_electronico = 'juan.nuevo@walletchile.cl' 
WHERE user_id = 1;

DELETE FROM transaccion 
WHERE transaction_id = 3;