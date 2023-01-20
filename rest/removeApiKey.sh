curl -X 'POST' \
  "$REST_URL/auth/api-key/delete" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "x-api-key: $API_KEY" \
  -d '{
  "apiKey": "s1Fu42wgsOBihWQBaMLxmDGcXnQ/eSIzKwyMwYE0kzE="
}'
