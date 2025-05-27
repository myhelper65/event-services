docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"
# docker build -t "${IMAGE_TAG_MONGO}" "${WORKSPACE}/mongo"
# docker build -t "${IMAGE_TAG_POSTGRES}" "${WORKSPACE}/postgres"

docker pull mongo:5.0
docker tag mongo:5.0 "${IMAGE_TAG_MONGO}"

docker pull postgres:14
docker tag postgres:14 "${IMAGE_TAG_POSTGRES}"
