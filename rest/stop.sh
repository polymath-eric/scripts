NAME=polymesh-rest-api
echo "Stopping REST API"

docker stop $NAME && 
  echo "Rest API stopped"

echo "Removing container"
docker rm $NAME
