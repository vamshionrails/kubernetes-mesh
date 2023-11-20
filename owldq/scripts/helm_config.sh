#!/bin/bash

# Author: Your Name
# Description: Script to deploy Helm chart to Kubernetes and manage Helm repository.

NAMESPACE_NAME="owldq"
CONFIG_JSON_FILE="configs/config.json"
HELM_REPO_PATH="helmcharts"

# Helm upgrade and install using Helmfile
helmfile --file ./helmfile.yaml apply

# Check if Helm repository exists
if [ -d "$HELM_REPO_PATH" ]; then
  # Convert Helm chart to Helm repository
  mkdir -p $HELM_REPO_PATH
  cp -R charts/owldq $HELM_REPO_PATH

  # Update Helm chart version
  cd $HELM_REPO_PATH/owldq
  CURRENT_VERSION=$(grep 'version:' Chart.yaml | awk '{print $2}')
  NEW_VERSION=$(awk -F. -v OFS=. '{$NF++; print}' <<< "$CURRENT_VERSION")

  # Update version in Chart.yaml
  sed -i "s/version: $CURRENT_VERSION/version: $NEW_VERSION/" Chart.yaml

  # Go back to the Helm repository directory
  cd ../..

  # Generate Helm repository index file
  helm repo index $HELM_REPO_PATH

  # Commit and push changes to GitHub
  git add $HELM_REPO_PATH
  git commit -m "Update Helm chart version and index file"
  git push
else
  echo "Helm repository directory not found. Run 'convert_to_helm_repo.sh' first."
  exit 1
fi

# Fetch JSON configuration
curl -o $CONFIG_JSON_FILE https://raw.githubusercontent.com/your-username/your-repo/main/config.json
