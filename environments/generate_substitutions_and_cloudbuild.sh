#!/bin/bash

# Source the config.sh file to load variables
source ./environments/config.sh

# Manually set the required substitutions from the sourced variables
substitutions=(
    "GCP_REGION=$GCP_REGION"
    "PROJECT_ID=$PROJECT_ID"
    "GCP_CONTAINER_REGISTRY_REPOSITORY_NAME=$GCP_CONTAINER_REGISTRY_REPOSITORY_NAME"
    "DOCKER_IMAGE_NAME=$DOCKER_IMAGE_NAME"
    "GCP_CLOUD_RUN_SERVICE_NAME=$GCP_CLOUD_RUN_SERVICE_NAME"
)

# Join the substitutions array into a comma-separated string
substitution_str=$(IFS=, ; echo "${substitutions[*]}")

echo "Generated Substitutions: $substitution_str"

# Trigger Cloud Build with dynamic substitutions
gcloud builds submit --config ./environments/cloudbuild.yaml --substitutions=$substitution_str


echo "Cloud Build triggered with dynamic substitutions."