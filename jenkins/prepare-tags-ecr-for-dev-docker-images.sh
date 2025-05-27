# MVN_VERSION=$(.${WORKSPACE}/events-service/target/maven-archiver/pom.properties &&echo $version)
# export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

# MVN_VERSION=$(.${WORKSPACE}/registration-service/target/maven-archiver/pom.properties &&echo $version)
# export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

# IMAGE_TAG_MONGO="533266982090.dkr.ecr.us-east-1.amazonaws.com/eventservice-repo/eventservice-app-dev:mongo-v${MVN_VERSION}-b${BUILD_NUMBER}"
# IMAGE_TAG_POSTGRES="533266982090.dkr.ecr.us-east-1.amazonaws.com/eventservice-repo/eventservice-app-dev:postgres-v${MVN_VERSION}-b${BUILD_NUMBER}"





# # Debug output
# echo "Tag for events-service:        [$IMAGE_TAG_EVENTS]"
# echo "Tag for registration-service:  [$IMAGE_TAG_REGISTRATION]"
# echo "Tag for mongo:                 [$IMAGE_TAG_MONGO]"
# echo "Tag for postgres:              [$IMAGE_TAG_POSTGRES]"


# Extract MVN_VERSION from events-service
if [ -f "${WORKSPACE}/events-service/target/maven-archiver/pom.properties" ]; then
  MVN_VERSION=$(grep '^version=' "${WORKSPACE}/events-service/target/maven-archiver/pom.properties" | cut -d= -f2)
  export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"
else
  echo "ERROR: pom.properties not found for events-service"; exit 1
fi

# Extract MVN_VERSION from registration-service
if [ -f "${WORKSPACE}/registration-service/target/maven-archiver/pom.properties" ]; then
  MVN_VERSION=$(grep '^version=' "${WORKSPACE}/registration-service/target/maven-archiver/pom.properties" | cut -d= -f2)
  export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"
else
  echo "ERROR: pom.properties not found for registration-service"; exit 1
fi

# Set Mongo/Postgres tags
if [ -n "$MVN_VERSION" ]; then
  export IMAGE_TAG_MONGO="${ECR_REGISTRY}/${APP_REPO_NAME}:mongo-v${MVN_VERSION}-b${BUILD_NUMBER}"
  export IMAGE_TAG_POSTGRES="${ECR_REGISTRY}/${APP_REPO_NAME}:postgres-v${MVN_VERSION}-b${BUILD_NUMBER}"
else
  echo "ERROR: MVN_VERSION is empty, cannot build Mongo/Postgres image tags"; exit 1
fi
