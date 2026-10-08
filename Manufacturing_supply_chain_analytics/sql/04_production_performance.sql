-- 04 Production Performance
SELECT COUNT(*) AS production_orders, SUM(planned_quantity) AS planned_units, SUM(produced_quantity) AS produced_units, SUM(produced_quantity)*1.0/NULLIF(SUM(planned_quantity),0) AS attainment_rate, AVG(JULIANDAY(actual_end)-JULIANDAY(planned_end)) AS avg_days_variance FROM production_orders;
SELECT production_order_id, plant_id, planned_quantity, produced_quantity, produced_quantity-planned_quantity AS quantity_variance, JULIANDAY(actual_end)-JULIANDAY(planned_end) AS schedule_variance_days FROM production_orders ORDER BY schedule_variance_days DESC;
SELECT plant_id, COUNT(*) AS orders, SUM(planned_quantity) AS planned_units, SUM(produced_quantity) AS produced_units, SUM(produced_quantity)*1.0/NULLIF(SUM(planned_quantity),0) AS attainment_rate, AVG(JULIANDAY(actual_end)-JULIANDAY(planned_end)) AS avg_delay_days FROM production_orders GROUP BY plant_id ORDER BY avg_delay_days DESC;
SELECT production_order_id, plant_id, product_id, JULIANDAY(actual_end)-JULIANDAY(planned_end) AS delay_days FROM production_orders WHERE actual_end>planned_end ORDER BY delay_days DESC;
SELECT AVG(JULIANDAY(actual_end)-JULIANDAY(planned_end)) AS avg_production_delay FROM production_orders WHERE actual_end>planned_end;
SELECT SUBSTR(actual_end,1,7) AS month, COUNT(*) AS orders, SUM(planned_quantity) AS planned_units, SUM(produced_quantity) AS produced_units FROM production_orders GROUP BY 1 ORDER BY 1;
SELECT plant_id, SUM(planned_quantity-produced_quantity) AS underproduction_units FROM production_orders GROUP BY plant_id ORDER BY underproduction_units DESC;
