MVN_VERSION=$(.${WORKSPACE}/events-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

MVN_VERSION=$(.${WORKSPACE}/registration-service/target/maven-archiver/pom.properties &&echo $version)
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"

IMAGE_TAG_MONGO="533266982090.dkr.ecr.us-east-1.amazonaws.com/eventservice-repo/eventservice-app-dev:mongo-v${MVN_VERSION}-b${BUILD_NUMBER}"
IMAGE_TAG_POSTGRES="533266982090.dkr.ecr.us-east-1.amazonaws.com/eventservice-repo/eventservice-app-dev:postgres-v${MVN_VERSION}-b${BUILD_NUMBER}"


