# Data Dictionary

| Table | Grain | Key measures |
|---|---|---|
| plants | one row per plant | plant attributes |
| suppliers | one row per supplier | supplier attributes |
| products | one row per product | category, unit cost |
| warehouses | one row per warehouse | warehouse attributes |
| customers | one row per customer | customer segment |
| purchase_orders | one row per PO | quantity, unit cost, dates, status |
| production_orders | one row per production order | planned/produced quantity, schedule dates |
| inventory_snapshots | one row per warehouse-product-date snapshot | on hand, allocated, reorder point, value |
| shipments | one row per shipment | quantity, promised/actual delivery |
| machine_events | one row per machine event | duration, severity, event type |
| quality_inspections | one row per inspection | inspected/failed quantity, defect |
