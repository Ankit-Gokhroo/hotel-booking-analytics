# Hotel Booking Analytics Platform

A Databricks Lakehouse analytics project built using **dbt Core, Databricks SQL, PySpark-compatible SQL transformations, and Delta Lake** to transform hotel booking data into analytics-ready datasets.

## Project Overview

This project processes approximately 119K hotel booking records and builds reusable analytical models to understand booking patterns, cancellation behavior, customer segments, market performance, and revenue indicators.

The project follows a layered data architecture with Bronze source data and dbt-managed Silver transformations.

## Technology Stack

- **Cloud & Data Platform:** Databricks
- **Data Storage:** Delta Lake
- **Transformation:** dbt Core, SQL, Jinja
- **Adapter:** dbt-databricks
- **Environment & Dependency Management:** Python, UV
- **Version Control:** Git, GitHub

## Architecture

```text
                 Source CSV
                     |
                     v
             Databricks Bronze
             raw_hotel_bookings
                     |
                     v
             dbt Staging Models
                     |
          +----------+----------+
          |                     |
          v                     v
     Clean Records         Quarantine
          |
          v
    Intermediate Models
          |
          v
      Marts Layer
          |
       +--+--+
       |     |
       v     v
   Dimensions Fact Table
       |
       v
  Databricks Silver
```

## Project Structure

```text
hotel-booking-analytics/
│
├── dbt_hotel_booking/
│   ├── analyses/
│   ├── macros/
│   ├── models/
│   │   ├── source/
│   │   ├── staging/
│   │   ├── intermediate/
│   │   └── marts/
│   │       ├── dimensions/
│   │       └── facts/
│   ├── seeds/
│   ├── snapshots/
│   ├── tests/
│   └── dbt_project.yml
│
├── pyproject.toml
├── uv.lock
├── .python-version
└── .gitignore
```

## Data Transformation Layers

### 1. Bronze Layer
- Stores the original hotel booking dataset.
- Source table: `hotel_booking_catalog.bronze.raw_hotel_bookings`.
- Contains approximately 119,390 source records.

### 2. Staging Layer
- Cleans and standardizes source booking records.
- Handles missing country and market segment values.
- Converts children values into numeric data.
- Applies guest-count and ADR validation rules.
- Separates invalid records into a quarantine model.

### 3. Intermediate Layer
Five reusable analytical models:

- `int_cancellation_analysis`
- `int_country_bookings`
- `int_customer_type_analysis`
- `int_deposit_analysis`
- `int_market_segment_analysis`

### 4. Marts Layer

**Dimension models**
- `dim_country`
- `dim_customer_type`
- `dim_hotel`
- `dim_market_segment`
- `dim_date`

**Fact model**
- `fct_bookings`

These models provide structured datasets for downstream analytical queries.

## Data Quality

Implemented dbt data quality tests include:

- Not-null tests
- Unique tests
- Accepted-values tests
- Referential integrity tests using relationships

**Latest validation results:**
- 13 models executed successfully.
- 19 data quality tests passed.
- Zero warnings and zero errors.

## Business Analytics

The project supports analysis of:

- Hotel booking and cancellation trends.
- Cancellation rates by hotel type.
- Booking distribution by country.
- Customer type performance.
- Market segment performance.
- Deposit type and cancellation behavior.
- Average daily rate (ADR).
- Booking lead-time patterns.
- Calendar-based analysis using the date dimension.

## Execution

Activate the Python environment:

```bash
source .venv/bin/activate
```

Validate the dbt connection and project:

```bash
dbt debug --project-dir dbt_hotel_booking
```

Parse the project:

```bash
dbt parse --project-dir dbt_hotel_booking
```

Execute all models:

```bash
dbt run --project-dir dbt_hotel_booking
```

Run data quality tests:

```bash
dbt test --project-dir dbt_hotel_booking
```

## Databricks Configuration

Configure your Databricks connection through the local dbt profile:

`~/.dbt/profiles.yml`

Keep access tokens and other credentials outside the Git repository. Never commit secrets.

## Project Objective

Demonstrate practical data engineering skills through modular dbt development, Databricks Lakehouse transformations, analytical data modelling, data quality validation, and version-controlled project delivery.
