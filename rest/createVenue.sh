PORT=2022

curl -X 'POST' \
  "$REST_URL/venues/create" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d @createVenueHook.json \
-H "x-api-key: $API_KEY"
