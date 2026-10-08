-- 01 Data Quality Assessment
-- DuckDB/SQLite-style exploratory checks. Replace table names with your warehouse objects.
SELECT 'purchase_orders' AS table_name, COUNT(*) AS rows, COUNT(DISTINCT po_id) AS distinct_ids, SUM(CASE WHEN quantity<=0 THEN 1 ELSE 0 END) AS invalid_qty, SUM(CASE WHEN received_date IS NOT NULL AND received_date < order_date THEN 1 ELSE 0 END) AS invalid_dates FROM purchase_orders;
SELECT 'production_orders' AS table_name, COUNT(*) AS rows, SUM(CASE WHEN planned_quantity<=0 OR produced_quantity<0 THEN 1 ELSE 0 END) AS invalid_qty, SUM(CASE WHEN actual_end < actual_start THEN 1 ELSE 0 END) AS invalid_dates FROM production_orders;
SELECT 'inventory_snapshots' AS table_name, COUNT(*) AS rows, SUM(CASE WHEN on_hand_quantity<0 OR allocated_quantity<0 OR allocated_quantity>on_hand_quantity THEN 1 ELSE 0 END) AS invalid_inventory FROM inventory_snapshots;
SELECT 'shipments' AS table_name, COUNT(*) AS rows, SUM(CASE WHEN actual_delivery_date IS NOT NULL AND actual_delivery_date < ship_date THEN 1 ELSE 0 END) AS invalid_dates FROM shipments;
SELECT 'machine_events' AS table_name, COUNT(*) AS rows, SUM(CASE WHEN duration_minutes<0 THEN 1 ELSE 0 END) AS invalid_duration FROM machine_events;
SELECT 'quality_inspections' AS table_name, COUNT(*) AS rows, SUM(CASE WHEN inspected_quantity<=0 OR failed_quantity<0 OR failed_quantity>inspected_quantity THEN 1 ELSE 0 END) AS invalid_quality_counts FROM quality_inspections;
-- Duplicate key checks
SELECT po_id, COUNT(*) AS duplicate_count FROM purchase_orders GROUP BY po_id HAVING COUNT(*)>1;
-- Referential integrity checks
SELECT COUNT(*) AS invalid_supplier_keys FROM purchase_orders po LEFT JOIN suppliers s ON po.supplier_id=s.supplier_id WHERE s.supplier_id IS NULL;
-- Quality failure rate
SELECT SUM(failed_quantity)*1.0/NULLIF(SUM(inspected_quantity),0) AS failure_rate FROM quality_inspections;
