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




SELECT s.branch_name, COUNT(e.employee_id) / COUNT(c.customer_id) AS employees_per_client
FROM empleado AS e
JOIN sucursal AS s ON e.branch_id = s.branch_id
JOIN cliente AS c ON c.branch_id = s.branch_id
GROUP BY s.branch_name;



//Cantidad de tarjetas de crédito por tipo por sucursal??



SELECT s.branch_name, AVG(p.loan_total) AS average_loan
FROM prestamo AS p
JOIN sucursal AS s ON p.branch_id = s.branch_id
GROUP BY s.branch_name;