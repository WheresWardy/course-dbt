# Analytics engineering with dbt

Template repository for the projects and environment of the course: Analytics engineering with dbt

> Please note that this sets some environment variables so if you create some new terminals please load them again.

# Local setup

In order to build and run this repo locally (rather than in gitpod) the following is required:

### postgres

Ensure the local DB has been built:

```
bash docker-build.sh
```

Run the DB locally (files should be maintained in `postgres/data/`)

```
docker compose up -d
```

### dbt

Install dependencies from brew:

```
brew install openssl@1.1 pgcli pgweb
brew link --force libpq
```

Setup the virtualenv:

```
python3 -m venv .venv
.venv/bin/pip install --upgrade pip
```

Install dbt for postgres and requirements:

```
bash pip-install-dbt.sh
```

Ensure the contents of `dbt.profiles.yml` are added to `~/.dbt/profiles.yml`

Install dbt package dependencies:

```
cd greenery && dbt deps
```

### psql

Ensure the search path includes the `dbt_matt_w` schema (possibly by adding to `~/.psqlrc`):

```
SET search_path = dbt_matt_w,public;
```

## License

Apache 2.0
