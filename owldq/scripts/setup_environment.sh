#!/bin/bash

# Author: Your Name
# Description: Script to set up the environment for deploying Helm chart to Kubernetes.

NAMESPACE_NAME="owldq"
JSON_KEY_FILE="configs/repo-key.json"
REGISTRY_URL="<registryURL>"

# Create Kubernetes namespace
kubectl create namespace $NAMESPACE_NAME

# Docker login with JSON key
docker login -u _json_key -p "$(cat $JSON_KEY_FILE)" https://gcr.io

# Get Docker image versions from config.json
OWL_AGENT_VERSION=$(jq -r '.dockerImages.owlAgent.version' configs/config.json)
OWL_WEB_VERSION=$(jq -r '.dockerImages.owlWeb.version' configs/config.json)
SPARK_VERSION=$(jq -r '.dockerImages.spark.version' configs/config.json)

# Pull Docker images
docker pull gcr.io/owl-hadoop-cdh/owl-agent:$OWL_AGENT_VERSION
docker pull gcr.io/owl-hadoop-cdh/owl-web:$OWL_WEB_VERSION
docker pull gcr.io/owl-hadoop-cdh/spark:$SPARK_VERSION

# Tag and push Docker images
docker tag gcr.io/owl-hadoop-cdh/owl-web:$OWL_WEB_VERSION $REGISTRY_URL/owl-web:$OWL_WEB_VERSION
docker push $REGISTRY_URL/owl-web:$OWL_WEB_VERSION

# Create Kubernetes secret for Docker registry
kubectl create secret docker-registry owldq-pull-secret \
  --docker-server=https://gcr.io \
  --docker-username=_json_key \
  --docker-email=$EMAIL \
  --docker-password="$(cat $JSON_KEY_FILE)" \
  --namespace $NAMESPACE_NAME
