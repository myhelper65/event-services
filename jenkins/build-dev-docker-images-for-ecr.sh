

# Build events-service Docker image
docker build -t "${IMAGE_TAG_EVENTS}" "${WORKSPACE}/events-service"

# Build registration-service Docker image
docker build -t "${IMAGE_TAG_REGISTRATION}" "${WORKSPACE}/registration-service"
