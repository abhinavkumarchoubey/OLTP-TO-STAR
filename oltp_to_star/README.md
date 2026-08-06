# OLTP-TO-STAR

An ELT pipeline that transforms the Pagila DVD rental dataset from its OLTP (normalized) form into an analytics-ready star schema, using **dbt** and **PostgreSQL**. Postgres runs in Docker and serves as both the source (raw Pagila data) and the target (transformed models).

## Tech Stack

- **PostgreSQL 15** (Docker) — source and target database
- **dbt** (dbt-postgres) — transformation layer
- **Docker Compose** — local environment orchestration

## Project Structure

```
oltp-to-star/
├── docker-compose.yml       # Postgres service definition
├── models/
│   └── staging/
│       ├── stg_*.sql        # One staging view per source table
│       └── src_pagila.yml   # Source definition + not_null/unique tests
├── dbt_project.yml           # dbt project config (name: oltp_to_star)
└── README.md
```

## Prerequisites

- Docker & Docker Compose
- Python 3.x with `dbt-postgres` installed (`pip install dbt-postgres`)

## Setup

1. **Start Postgres**

   ```bash
   docker-compose up -d
   ```

   This spins up a Postgres 16 container with the `pagila` database (schema: `public`) exposed on host port `5432`, pre-loaded with the Pagila dataset.

2. **Configure your dbt profile**

   Add a target for this project in `~/.dbt/profiles.yml`:

   ```yaml
   oltp_to_star:
     target: dev
     outputs:
       dev:
         type: postgres
         host: localhost
         port: 5432
         user: <your_user>
         password: <your_password>
         dbname: pagila
         schema: public
         threads: 4
   ```

3. **Verify the connection**

   ```bash
   dbt debug
   ```

## Current Progress

- Docker Compose setup for Postgres 15, loaded with the Pagila dataset.
- Staging layer: every source table has a corresponding `stg_*.sql` model, materialized as a **view**.
- Source tables are referenced using dbt's `source()` function, defined in `src_pagila.yml`, pointing to the `public` schema in the `pagila` database.
- Data tests added on all staging models: `not_null` and `unique` tests on primary key columns.

## Running the Project

```bash
# Build all staging views
dbt run

# Run schema tests (not_null, unique)
dbt test
```