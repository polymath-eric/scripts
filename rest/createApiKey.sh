curl -X 'POST' \
  'http://localhost:2022/auth/api-key/create' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -H "x-api-key: $API_KEY" \
  -d '{
  "userId": "1"
}'
