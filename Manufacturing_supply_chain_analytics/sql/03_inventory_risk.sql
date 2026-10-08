-- 03 Inventory Risk
SELECT SUM(on_hand_quantity) AS units_on_hand, SUM(allocated_quantity) AS allocated_units, SUM(inventory_value) AS inventory_value, SUM(CASE WHEN on_hand_quantity<reorder_point THEN 1 ELSE 0 END) AS below_reorder_rows FROM inventory_snapshots;
SELECT warehouse_id, SUM(on_hand_quantity) AS units_on_hand, SUM(inventory_value) AS inventory_value, SUM(CASE WHEN on_hand_quantity<reorder_point THEN 1 ELSE 0 END) AS below_reorder_rows FROM inventory_snapshots GROUP BY warehouse_id ORDER BY below_reorder_rows DESC;
SELECT product_id, SUM(on_hand_quantity) AS units_on_hand, SUM(inventory_value) AS inventory_value, AVG(on_hand_quantity-reorder_point) AS avg_buffer FROM inventory_snapshots GROUP BY product_id ORDER BY avg_buffer ASC;
SELECT product_id, SUM(inventory_value) AS inventory_value FROM inventory_snapshots GROUP BY product_id ORDER BY inventory_value DESC LIMIT 20;
SELECT warehouse_id, SUM(allocated_quantity)*1.0/NULLIF(SUM(on_hand_quantity),0) AS allocation_rate FROM inventory_snapshots GROUP BY warehouse_id ORDER BY allocation_rate DESC;
SELECT SUBSTR(snapshot_date,1,7) AS month, SUM(inventory_value) AS inventory_value, SUM(CASE WHEN on_hand_quantity<reorder_point THEN 1 ELSE 0 END) AS shortage_rows FROM inventory_snapshots GROUP BY 1 ORDER BY 1;
SELECT warehouse_id, product_id, SUM(inventory_value) AS inventory_value, AVG(on_hand_quantity-reorder_point) AS buffer FROM inventory_snapshots GROUP BY warehouse_id, product_id HAVING SUM(inventory_value)>100000 AND AVG(on_hand_quantity-reorder_point)<0 ORDER BY inventory_value DESC;
