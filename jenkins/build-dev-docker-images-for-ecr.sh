echo "Building events-service image: ${IMAGE_TAG_EVENTS}"
docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"

# Build registration-service Docker image
echo "Building events-service image: ${IMAGE_TAG_REGISTRATION}
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"
