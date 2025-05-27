
MVN_VERSION=$(.${WORKSPACE}/events-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

MVN_VERSION=$(.${WORKSPACE}/registration-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

ECR_REGISTRY=$(echo "$IMAGE_TAG_REGISTRATION" | cut -d '/' -f1)

# Extract APP_REPO_NAME (e.g., eventservice-repo)
APP_REPO_NAME=$(echo "$IMAGE_TAG_REGISTRATION" | cut -d '/' -f2 | cut -d ':' -f1)

# Extract BUILD_NUMBER (e.g., 42)
BUILD_NUMBER=$(echo "$IMAGE_TAG_REGISTRATION" | sed -E 's/.*-b([0-9]+)$/\1/')

export IMAGE_TAG_MONGO="${ECR_REGISTRY}/${APP_REPO_NAME}:mongo-b${BUILD_NUMBER}"
export IMAGE_TAG_POSTGRES="${ECR_REGISTRY}/${APP_REPO_NAME}:postgres-b${BUILD_NUMBER}"

# Debug output
echo "Tag for events-service:        [$IMAGE_TAG_EVENTS]"
echo "Tag for registration-service:  [$IMAGE_TAG_REGISTRATION]"
echo "Tag for mongo:                 [$IMAGE_TAG_MONGO]"
echo "Tag for postgres:              [$IMAGE_TAG_POSTGRES]"