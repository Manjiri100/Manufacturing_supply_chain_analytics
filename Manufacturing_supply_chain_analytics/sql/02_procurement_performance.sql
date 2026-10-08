-- 02 Procurement Performance
SELECT COUNT(*) AS purchase_orders, SUM(quantity) AS ordered_units, AVG(unit_cost) AS avg_unit_cost, SUM(CASE WHEN received_date IS NOT NULL AND received_date>promised_date THEN 1 ELSE 0 END)*1.0/COUNT(*) AS late_rate FROM purchase_orders;
SELECT supplier_id, COUNT(*) AS po_count, SUM(quantity) AS ordered_units, AVG(unit_cost) AS avg_unit_cost, SUM(CASE WHEN received_date>promised_date THEN 1 ELSE 0 END)*1.0/NULLIF(COUNT(received_date),0) AS late_received_rate FROM purchase_orders GROUP BY supplier_id ORDER BY late_received_rate DESC;
SELECT supplier_id, COUNT(*) AS late_pos, SUM(quantity*unit_cost) AS late_value FROM purchase_orders WHERE received_date>promised_date GROUP BY supplier_id ORDER BY late_value DESC;
SELECT plant_id, COUNT(*) AS po_count, SUM(quantity*unit_cost) AS spend, AVG(JULIANDAY(received_date)-JULIANDAY(promised_date)) AS avg_days_late FROM purchase_orders WHERE received_date IS NOT NULL GROUP BY plant_id;
SELECT SUBSTR(order_date,1,7) AS month, COUNT(*) AS po_count, SUM(quantity*unit_cost) AS spend FROM purchase_orders GROUP BY 1 ORDER BY 1;
SELECT supplier_id, COUNT(*) AS late_pos, SUM(quantity*unit_cost) AS late_spend, RANK() OVER(ORDER BY SUM(quantity*unit_cost) DESC) AS risk_rank FROM purchase_orders WHERE received_date>promised_date GROUP BY supplier_id ORDER BY risk_rank;
