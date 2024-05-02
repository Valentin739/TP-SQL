CREATE OR REPLACE VIEW ALL_WORKERS AS
SELECT last_name, first_name, age, first_day AS start_date
FROM WORKERS_FACTORY_1
UNION ALL
SELECT last_name, first_name, NULL AS age, start_date
FROM WORKERS_FACTORY_2
ORDER BY start_date DESC;

CREATE OR REPLACE VIEW ALL_WORKERS_ELAPSED AS
SELECT last_name, first_name, age, start_date, TRUNC(SYSDATE - start_date) AS days_elapsed
FROM ALL_WORKERS;

CREATE OR REPLACE VIEW BEST_SUPPLIERS AS
SELECT s.name AS supplier_name, SUM(sb1.quantity) + SUM(sb2.quantity) AS total_quantity
FROM SUPPLIERS s
LEFT JOIN SUPPLIERS_BRING_TO_FACTORY_1 sb1 ON s.supplier_id = sb1.supplier_id
LEFT JOIN SUPPLIERS_BRING_TO_FACTORY_2 sb2 ON s.supplier_id = sb2.supplier_id
GROUP BY s.name
HAVING COALESCE(SUM(sb1.quantity), 0) + COALESCE(SUM(sb2.quantity), 0) > 1000
ORDER BY total_quantity DESC;

CREATE OR REPLACE VIEW ROBOTS_FACTORIES AS
SELECT r.id AS robot_id, r.model AS robot_model, f.id AS factory_id, f.main_location AS factory_location
FROM ROBOTS_FROM_FACTORY rf
JOIN ROBOTS r ON rf.robot_id = r.id
JOIN FACTORIES f ON rf.factory_id = f.id;

