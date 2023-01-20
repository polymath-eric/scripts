VERSION=latest
IMAGE="polymeshassociation/polymesh-rest-api:$VERSION"
NAME=polymesh-rest-api 

ENV_FILE=./local.env

docker pull $IMAGE

echo "\nStarting REST API: $VERSION, Env: $ENV_FILE,  Docker ID:"
docker run \
  --name=$NAME \
  --restart=unless-stopped \
  --publish=2004:3000 \
  --detach \
  --env-file=$ENV_FILE \
  "$IMAGE"
