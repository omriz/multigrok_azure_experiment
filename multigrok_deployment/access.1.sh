#!/bin/bash

ACR_NAME=omrizContainerBuilder
SERVICE_PRINCIPAL_NAME=acr-service-principal

# Populate the ACR login server and resource id.
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Create a contributor role assignment with a scope of the ACR resource.
SP_PASSWD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --role Reader --scopes $ACR_REGISTRY_ID --query password --output tsv)

# Get the service principle client id.
CLIENT_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

# Output used when creating Kubernetes secret.
echo "Service principal ID: $CLIENT_ID"
echo "Service principal password: $SP_PASSWD"

# kubectl create secret docker-registry acr-auth --docker-server omrizcontainerbuilder.azurecr.io --docker-username 15a350b8-7ccf-4a07-8c45-12f4cbd9ddcc --docker-password ee3e21b9-82a9-46bf-99b3-82f9505219de --docker-email omrizohar@outlook.com