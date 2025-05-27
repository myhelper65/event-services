docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"
docker pull mongo:5.0
docker tag mongo:5.0 mongo:dev

docker pull postgres:14
docker tag postgres:14 postgres:dev

echo "IMAGE_TAG_EVENTS=${IMAGE_TAG_EVENTS}"
echo "IMAGE_TAG_REGISTRATION=${IMAGE_TAG_REGISTRATION}"
