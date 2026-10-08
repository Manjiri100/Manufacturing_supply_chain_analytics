# Architecture

The project separates raw operational data from reusable transformation layers. Source tables feed dbt staging models; intermediate models encode business logic; marts provide business-ready metrics for Power BI. SQL investigation scripts remain independently readable so the analytical reasoning is visible rather than hidden inside a dashboard.

**Flow:** Python generator → raw CSV/source tables → quality profiling → dbt staging → intermediate logic → analytical marts → Power BI semantic model → executive and functional reporting.
