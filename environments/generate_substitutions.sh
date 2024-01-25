#!/bin/bash

# Source the config.sh file to load variables
source config.sh

# Manually set the required substitutions from the sourced variables
substitutions=(
    "_GCP_REGION=$GCP_REGION"
    "_PROJECT_ID=$PROJECT_ID"
    "_GCP_CONTAINER_REGISTRY_REPOSITORY_NAME=$GCP_CONTAINER_REGISTRY_REPOSITORY_NAME"
    "_DOCKER_IMAGE_NAME=$DOCKER_IMAGE_NAME"
    "_GCP_CLOUD_RUN_SERVICE_NAME=$GCP_CLOUD_RUN_SERVICE_NAME"
)

# Join the substitutions array into a comma-separated string
substitution_str=$(IFS=, ; echo "${substitutions[*]}")

# Trigger Cloud Build with dynamic substitutions
gcloud builds submit --substitutions=$substitution_str
