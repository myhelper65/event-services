docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"