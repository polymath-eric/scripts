curl -X 'POST' \
  "$REST_URL/users/create" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "x-api-key: $API_KEY" \
  -d '{
  "name": "Alice"
}'
