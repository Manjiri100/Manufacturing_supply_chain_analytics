# Power BI Semantic Model

### Fact tables
- FactPurchaseOrders
- FactProductionOrders
- FactInventorySnapshots
- FactShipments
- FactMachineEvents
- FactQualityInspections

### Dimensions
- DimPlant
- DimSupplier
- DimProduct
- DimWarehouse
- DimCustomer
- DimDate

Use single-direction relationships from dimensions to facts where possible. Keep each fact at its natural grain and avoid many-to-many relationships unless explicitly justified.
