#!/bin/bash
set -e

# Extract MVN version for events-service
MVN_VERSION=$(grep '^version=' "${WORKSPACE}/events-service/target/maven-archiver/pom.properties" | cut -d'=' -f2)

# Extract ECR_REGISTRY and APP_REPO_NAME from IMAGE_TAG_EVENTS
IMAGE_TAG_EVENTS=$(grep '^image:' "${WORKSPACE}/events-service/values.yaml" | cut -d':' -f2- | tr -d ' "')
ECR_REGISTRY=$(echo "$IMAGE_TAG_EVENTS" | cut -d'/' -f1)
APP_REPO_NAME=$(echo "$IMAGE_TAG_EVENTS" | cut -d'/' -f2)

# Use Jenkins-provided BUILD_NUMBER, or fallback to timestamp if not set
BUILD_NUMBER="${BUILD_NUMBER:-$(date +%s)}"

# Construct all image tags dynamically
export IMAGE_TAG_EVENTS="${ECR_REGISTRY}/${APP_REPO_NAME}:events-service-v${MVN_VERSION}-b${BUILD_NUMBER}"
export IMAGE_TAG_REGISTRATION="${ECR_REGISTRY}/${APP_REPO_NAME}:registration-service-v${MVN_VERSION}-b${BUILD_NUMBER}"
export IMAGE_TAG_MONGO="${ECR_REGISTRY}/${APP_REPO_NAME}:mongo-b${BUILD_NUMBER}"
export IMAGE_TAG_POSTGRES="${ECR_REGISTRY}/${APP_REPO_NAME}:postgres-b${BUILD_NUMBER}"

# Debug output
echo "✓ ECR_REGISTRY        = $ECR_REGISTRY"
echo "✓ APP_REPO_NAME       = $APP_REPO_NAME"
echo "✓ BUILD_NUMBER        = $BUILD_NUMBER"
echo "✓ IMAGE_TAG_EVENTS    = $IMAGE_TAG_EVENTS"
echo "✓ IMAGE_TAG_REGISTRATION = $IMAGE_TAG_REGISTRATION"
echo "✓ IMAGE_TAG_MONGO     = $IMAGE_TAG_MONGO"
echo "✓ IMAGE_TAG_POSTGRES  = $IMAGE_TAG_POSTGRES"
