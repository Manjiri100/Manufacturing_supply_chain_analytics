## Manufacturing & Supply Chain Analytics

##  Summary
An enterprise-scale analytics project designed to investigate operational performance across procurement, inventory, production, logistics, quality and machine events. The project follows a realistic analytics lifecycle: identify the business problem, profile data quality, investigate with SQL, transform with dbt, build an analytical model, surface operational risks in Power BI, and translate findings into actions.

## Business Problem
Manufacturing organisations often have operational data spread across suppliers, plants, warehouses, production orders, inventory, shipments, machine events and quality inspections. The challenge is not simply reporting KPIs; it is connecting these signals to identify where delays, shortages, quality failures and operational disruption originate.

## Dataset Scale
The full synthetic dataset contains **19,275,600 records** across 11 tables:

| Table | Records |
|---|---:|
| plants | 100 |
| suppliers | 5,000 |
| products | 20,000 |
| warehouses | 500 |
| customers | 250,000 |
| purchase_orders | 2,000,000 |
| production_orders | 2,000,000 |
| inventory_snapshots | 5,000,000 |
| shipments | 3,000,000 |
| machine_events | 5,000,000 |
| quality_inspections | 2,000,000 |
| **Total** | **19,275,600** |

Full-scale CSV files are generated locally and are excluded from source control. Representative samples are included for portfolio review.

## Business Questions
### Procurement
- Which suppliers have the highest late-delivery exposure?
- Where are promised-vs-received dates breaking down?
- Which suppliers create the greatest operational risk?

### Inventory
- Which warehouses and products fall below reorder points?
- Where is inventory value concentrated?
- Which stock positions combine shortage risk with high value?

### Production
- Which plants consistently miss planned completion dates?
- Where does produced quantity fall below plan?
- Are production delays associated with machine-event activity?

### Logistics
- Which warehouses and customers experience the greatest delivery delays?
- Which high-volume routes create disproportionate service risk?

### Quality & Reliability
- Which plants, products and defect types have elevated failure rates?
- Are quality failures associated with machine-event patterns?

### Data Trust
- What duplicate, invalid, missing or impossible records could distort decisions?
- Can the key operational KPIs be reconciled across source tables?

## Analytical Workflow
**Investigate → Validate → Transform → Model → Analyse → Explain → Recommend**

1. Profile raw operational data and identify data-quality risks.
2. Use SQL to quantify procurement, inventory, production, logistics and quality performance.
3. Use dbt to standardise staging logic and create reusable analytical marts.
4. Build a Power BI semantic model around operational facts and dimensions.
5. Connect operational KPIs and root-cause signals.
6. Communicate findings through executive and functional dashboards.
7. Convert evidence into prioritised recommendations.

## Technology Stack
- Python — synthetic enterprise data generation
- SQL — investigation, profiling and root-cause analysis
- dbt — transformation, testing and analytical marts
- Power BI — semantic model and dashboard design
- GitHub Actions — automated quality checks

## Data Architecture
```text
Operational Sources
        │
        ▼
 Raw CSV / Source Tables
        │
        ├── Data Quality Profiling
        │
        ▼
 dbt Staging Models
        │
        ▼
 Intermediate Business Logic
        │
        ▼
 Analytical Marts
        │
        ▼
 Power BI Semantic Model
        │
        ├── Executive Overview
        ├── Procurement
        ├── Inventory
        ├── Production
        ├── Logistics
        ├── Quality & Machine Events
        └── Data Trust
```

## Power BI Pages
1. Executive Operations Overview
2. Supplier & Procurement Performance
3. Inventory & Warehouse Risk
4. Production & Plant Efficiency
5. Logistics & Shipment Performance
6. Quality & Machine Events
7. Data Quality & Trust

## Project Structure
```text
Manufacturing_supply_chain_analytics/
├── data/sample/
├── data/generated/
├── dbt/
│   ├── models/staging/
│   ├── models/intermediate/
│   ├── models/marts/
│   └── tests/
├── docs/
├── powerbi/
├── scripts/generate_data.py
├── sql/
├── .github/workflows/quality.yml
├── PROJECT_INVENTORY.md
├── ZIP_CONTENTS.md
└── README.md
```

## Reproducibility
Run from the project root:

```bash
python scripts/generate_data.py --scale-factor 0.01
python scripts/generate_data.py --scale-factor 1.0
```

The generator is deterministic using a fixed random seed and writes chunked CSV files. The smaller scale is recommended for quick testing.

## Data Quality
The synthetic data intentionally includes realistic issues such as duplicates, invalid foreign keys, invalid quantities, missing mandatory fields, inconsistent statuses, impossible dates and reconciliation differences. The analysis demonstrates how an analyst can detect and quantify their impact before publishing KPIs.

## Disclaimer
All data is synthetic and created for portfolio demonstration. It does not represent any real company, customer, supplier or operational event.

<img width="1024" height="572" alt="image" src="https://github.com/user-attachments/assets/9dc31455-3674-4129-9cdd-589f6ecf2f53" />
