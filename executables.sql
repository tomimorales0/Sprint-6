INSERT INTO cliente (customer_name, customer_surname, customer_DNI, branch_id, dob) VALUES
('Lois', 'Stout', 47730534, 80, '1984-07-07'),
('Hall', 'Mcconnell', 52055464, 45, '1968-04-30'),
('Hilel', 'Mclean', 43625213, 77, '1993-03-28'),
('Jin', 'Cooley', 21207908, 96, '1959-08-24'),
('Gabriel', 'Harmon', 57063950, 27, '1976-04-01');

//

UPDATE cliente
SET branch_id = 10
WHERE customer_DNI IN (47730534, 52055464, 43625213, 21207908, 57063950);

//

DELETE FROM cliente
WHERE customer_name = 'Noel' AND customer_surname = 'David';

//

CREATE TABLE auditoria_cuenta (
    old_id INTEGER,
    new_id INTEGER,
    old_balance INTEGER,
    new_balance INTEGER,
    old_iban VARCHAR(34),
    new_iban VARCHAR(34),
    user_action VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

//

CREATE TRIGGER after_update_cuenta
AFTER UPDATE OF saldo, iban, tipo_cuenta ON cuenta
BEGIN
    INSERT INTO auditoria_cuenta (old_id, new_id, old_balance, new_balance, old_iban, new_iban, user_action, created_at)
    VALUES (OLD.cuenta_id, NEW.cuenta_id, OLD.saldo, NEW.saldo, OLD.iban, NEW.iban, 'UPDATE', CURRENT_TIMESTAMP);
END;
