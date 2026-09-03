# Airbnb dbt Project

A small dbt project that transforms Airbnb source data in Snowflake. The
current models expose the source bookings, hosts, and listings data through a
bronze layer and build a silver listings table from the bronze model.

## Tech stack

- dbt Core 1.12
- Snowflake
- Python 3.12+
- `uv` for Python dependency management

## Project structure

```text
.
├── pyproject.toml
└── airbnb/
    ├── dbt_project.yml
    ├── packages.yml
        └── models/
            ├── bronze/
            │   ├── bronze_bookings.sql
            │   ├── bronze_hosts.sql
            │   └── bronze_listings.sql
            ├── silver/
            │   └── silver1.sql
            └── gold/
                └── gold1.sql
```

The bronze models currently read from these Snowflake relations:

| Model | Source relation |
| --- | --- |
| `bronze_bookings` | `AIRBNB.SOURCE.BOOKINGS` |
| `bronze_hosts` | `AIRBNB.SOURCE.HOSTS` |
| `bronze_listings` | `AIRBNB.SOURCE.LISTINGS` |

The `silver1` model selects from `bronze_listings` and is explicitly
materialized as a table.

## Setup

1. Install [`uv`](https://docs.astral.sh/uv/) and sync the Python environment:

   ```bash
   uv sync
   ```

2. Configure a Snowflake profile named `airbnb` in
   `~/.dbt/profiles.yml`. The profile must provide access to the `AIRBNB`
   database and its `SOURCE` schema.

3. Install the dbt packages:

   ```bash
   cd airbnb
   uv run dbt deps
   ```

4. Verify the configuration and connection:

   ```bash
   uv run dbt debug
   ```

## Running the project

Run all models from the `airbnb` directory:

```bash
uv run dbt run
```

Other useful commands:

```bash
uv run dbt parse                 # Validate and parse the project
uv run dbt run --select path:models/bronze  # Run the bronze models
uv run dbt run --select silver1             # Build the silver table
uv run dbt clean                 # Remove generated dbt artifacts
```

Bronze models are created as views, while `silver1` is created as a table in
the configured target schema.


Updating a single line to check the git tracking
