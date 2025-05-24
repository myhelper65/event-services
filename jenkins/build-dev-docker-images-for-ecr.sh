docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"

echo "IMAGE_TAG_EVENTS=${IMAGE_TAG_EVENTS}"
echo "IMAGE_TAG_REGISTRATION=${IMAGE_TAG_REGISTRATION}"
