GENERATED_BACKEND_DOCS_PATH=docs/generated
GENERATED_BACKEND_DOCS_INTERNAL_PATH=../internal/docs/docs/v2/api-reference/backend

rm -rf "$GENERATED_BACKEND_DOCS_PATH"

if [ "${CI:-}" = "true" ]
then
  COMPOSE_FILE=../../docker-compose.yml:../../docker-compose.ci.yml
else
  COMPOSE_FILE=../../docker-compose.yml:../../docker-compose.local.yml
fi

docker-compose run --rm -T --no-deps backend sh -c "pydoc-markdown"
rm -rf "${GENERATED_BACKEND_DOCS_INTERNAL_PATH}/generated"
cp -R "$GENERATED_BACKEND_DOCS_PATH" "$GENERATED_BACKEND_DOCS_INTERNAL_PATH"
