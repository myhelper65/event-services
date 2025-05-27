MVN_VERSION=$(.${WORKSPACE}/events-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

MVN_VERSION=$(.${WORKSPACE}/registration-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

docker tag mongo:5.0 mongo:dev
docker tag postgres:14 postgres:dev


# Debug output
echo "Tag for events-service:        [$IMAGE_TAG_EVENTS]"
echo "Tag for registration-service:  [$IMAGE_TAG_REGISTRATION]"
echo "Tag for mongo:                 [$IMAGE_TAG_MONGO]"
echo "Tag for postgres:              [$IMAGE_TAG_POSTGRES]"
