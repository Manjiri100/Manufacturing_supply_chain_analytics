# Core Power BI Measures

```DAX
Total Orders = COUNTROWS(PurchaseOrders)
Procurement Spend = SUMX(PurchaseOrders, PurchaseOrders[quantity] * PurchaseOrders[unit_cost])
Late PO Rate = DIVIDE([Late POs], [Received POs])
Production Attainment = DIVIDE(SUM(ProductionOrders[produced_quantity]), SUM(ProductionOrders[planned_quantity]))
Shipment Late Rate = DIVIDE([Late Shipments], [Delivered Shipments])
Quality Failure Rate = DIVIDE(SUM(QualityInspections[failed_quantity]), SUM(QualityInspections[inspected_quantity]))
Machine Downtime Hours = DIVIDE(SUM(MachineEvents[duration_minutes]),60)
```
