
MVN_VERSION=$(.${WORKSPACE}/events-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

MVN_VERSION=$(.${WORKSPACE}/registration-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

# Extract ECR_REGISTRY and APP_REPO_NAME from one of the existing image tags
ECR_REGISTRY=$(echo "$IMAGE_TAG_REGISTRATION" | cut -d '/' -f1)
APP_REPO_NAME=$(echo "$IMAGE_TAG_REGISTRATION" | cut -d '/' -f2 | cut -d ':' -f1)
BUILD_NUMBER=$(echo "$IMAGE_TAG_REGISTRATION" | sed -E 's/.*-b([0-9]+)$/\1/')

# Now use them to export MONGO/POSTGRES tags
export IMAGE_TAG_MONGO="${ECR_REGISTRY}/${APP_REPO_NAME}:mongo-b${BUILD_NUMBER}"
export IMAGE_TAG_POSTGRES="${ECR_REGISTRY}/${APP_REPO_NAME}:postgres-b${BUILD_NUMBER}"