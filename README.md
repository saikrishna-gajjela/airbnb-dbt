# Airbnb dbt Project

A small dbt project that transforms Airbnb source data in Snowflake. The
current models form a bronze layer by exposing the source bookings, hosts, and
listings tables as dbt-managed views.

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
        └── bronze/
            ├── bronze_bookings.sql
            ├── bronze_hosts.sql
            └── bronze_listings.sql
```

The bronze models currently read from these Snowflake relations:

| Model | Source relation |
| --- | --- |
| `bronze_bookings` | `AIRBNB.SOURCE.BOOKINGS` |
| `bronze_hosts` | `AIRBNB.SOURCE.HOSTS` |
| `bronze_listings` | `AIRBNB.SOURCE.LISTINGS` |

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
uv run dbt clean                 # Remove generated dbt artifacts
```

With the current development profile, the models are created as views in the
configured target schema.


Updating a single line to check the git tracking