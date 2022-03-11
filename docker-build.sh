pushd docker
docker build -t postgres_dbt:14.2-alpine -f Dockerfile.postgres .
popd
