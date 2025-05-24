# MVN_VERSION=$(. ${WORKSPACE}/events-service/target/maven-archiver/pom.properties && echo $version)
# export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

# MVN_VERSION=$(. ${WORKSPACE}/registration-service/target/maven-archiver/pom.properties && echo $version)
# export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

# Extract Maven version for events-service
MVN_VERSION_EVENTS=$(grep '^version=' "${WORKSPACE}/events-service/target/maven-archiver/pom.properties" | cut -d'=' -f2 | xargs)
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION_EVENTS}-b${BUILD_NUMBER}"

# Extract Maven version for registration-service
MVN_VERSION_REGISTRATION=$(grep '^version=' "${WORKSPACE}/registration-service/target/maven-archiver/pom.properties" | cut -d'=' -f2 | xargs)
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION_REGISTRATION}-b${BUILD_NUMBER}"

# Debug output
echo "Tag for events-service:        [$IMAGE_TAG_EVENTS]"
echo "Tag for registration-service:  [$IMAGE_TAG_REGISTRATION]"

