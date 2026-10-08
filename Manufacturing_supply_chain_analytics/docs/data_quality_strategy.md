# Data Quality Strategy

Checks are organised into six categories: uniqueness, referential integrity, completeness, validity, temporal consistency and reconciliation.

- **Uniqueness:** duplicate business keys.
- **Referential integrity:** supplier/product/plant/warehouse/customer relationships.
- **Completeness:** mandatory identifiers and operational dates.
- **Validity:** non-negative quantities, plausible durations and recognised statuses.
- **Temporal consistency:** received/delivery/end dates cannot precede their source events.
- **Reconciliation:** ordered vs received, planned vs produced, inspected vs failed.

The objective is to prevent unreliable source records from becoming apparently precise executive KPIs.
