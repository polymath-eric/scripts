curl -X 'POST' \
  "$REST_URL/auth/api-key/create" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "x-api-key: $API_KEY" \
  -d '{
  "userName": "Alice"
}'
