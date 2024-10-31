//1


//    
UPDATE cliente
SET customer_type = (
    CASE ABS(RANDOM()) % 3
        WHEN 0 THEN 'classic'
        WHEN 1 THEN 'gold'
        WHEN 2 THEN 'black'
    END
);


//2

CREATE VIEW vista_clientes AS
SELECT 
    customer_id AS id,
    branch_id AS numero_sucursal,
    customer_name AS nombre,
    customer_surname AS apellido,
    customer_DNI AS dni,
    strftime('%Y', 'now') - strftime('%Y', dob) - (strftime('%m-%d', 'now') < strftime('%m-%d', dob)) AS edad
FROM cliente;



SELECT *
FROM vista_clientes
WHERE edad > 40
ORDER BY dni;


 
SELECT *
FROM vista_clientes
WHERE nombre = 'Anne' OR nombre = 'Tyler'
ORDER BY edad;

//3

SELECT *
FROM cuenta
WHERE balance < 0;



SELECT customer_name, customer_surname, 
       strftime('%Y', 'now') - strftime('%Y', dob) - (strftime('%m-%d', 'now') < strftime('%m-%d', dob)) AS edad
FROM cliente
WHERE customer_surname LIKE '%Z%';




SELECT c.customer_name, c.customer_surname, 
       strftime('%Y', 'now') - strftime('%Y', c.dob) AS edad,
       s.branch_name
FROM cliente AS c
JOIN sucursal AS s ON c.branch_id = s.branch_id
WHERE c.customer_name = 'Brendan'
ORDER BY s.branch_name;




SELECT *
FROM prestamo
WHERE loan_total > 8000000 OR loan_type = 'Prendario';



SELECT *
FROM prestamo
WHERE loan_total > (SELECT AVG(loan_total) FROM prestamo);




SELECT COUNT(*)
FROM cliente
WHERE strftime('%Y', 'now') - strftime('%Y', dob) < 50;




SELECT *
FROM cuenta
WHERE balance > 800000
LIMIT 5;




SELECT *
FROM prestamo
WHERE strftime('%m', loan_date) IN ('04', '06', '08')
ORDER BY loan_total;





SELECT loan_type, SUM(loan_total) AS loan_total_accu
FROM prestamo
GROUP BY loan_type;


//4

SELECT s.branch_name, COUNT(c.customer_id) AS customer_count
FROM cliente AS c
JOIN sucursal AS s ON c.branch_id = s.branch_id
GROUP BY s.branch_name
ORDER BY customer_count DESC;

//


SELECT s.branch_name, COUNT(e.employee_id) / COUNT(c.customer_id) AS employees_per_client
FROM empleado AS e
JOIN sucursal AS s ON e.branch_id = s.branch_id
JOIN cliente AS c ON c.branch_id = s.branch_id
GROUP BY s.branch_name;

//

SELECT sucursal, COUNT(card_id) AS num_credit_cards
FROM tarjetas
GROUP BY sucursal
ORDER BY num_credit_cards DESC;



//



SELECT s.branch_name, AVG(p.loan_total) AS average_loan
FROM prestamo AS p
JOIN sucursal AS s ON p.loan_id = s.branch_id
GROUP BY s.branch_name;


//
    
UPDATE cuenta
SET balance = balance - 100
WHERE account_id BETWEEN 10 AND 14;

//

BEGIN TRANSACTION;
UPDATE cuenta

SET balance = balance - 1000
WHERE account_id = 200;
UPDATE cuenta
SET balance = balance + 1000 
WHERE account_id = 400;


INSERT INTO movimientos (movements_id, account_number, amount, operation_type, transaction_time)
VALUES 
(1, 200, -1000, 'transferencia', CURRENT_TIMESTAMP), 
(2, 400, +1000, 'deposito', CURRENT_TIMESTAMP);



IF @@ERROR
BEGIN

    ROLLBACK TRANSACTION;
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END
