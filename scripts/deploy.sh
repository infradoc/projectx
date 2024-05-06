#!/bin/bash

echo "Deploying to AWS Amplify in the $AMPLIFY_ENV environment..."

# Ensure AWS Amplify CLI is installed
if ! command -v amplify &> /dev/null
then
    echo "Amplify CLI could not be found, installing..."
    npm install -g @aws-amplify/cli
fi

# Initialize AWS Amplify if not already initialized
if [ ! -d "amplify/#current-cloud-backend" ]; then
    echo "Initializing AWS Amplify..."
    amplify init --amplify "{ \"envName\": \"$AMPLIFY_ENV\", \"appId\": \"$AMPLIFY_APP_ID\" }" --yes
else
    echo "AWS Amplify is already initialized."
fi

# Pull the latest backend configuration from the cloud
echo "Pulling backend environment $AMPLIFY_ENV..."
amplify pull --appId $AMPLIFY_APP_ID --envName $AMPLIFY_ENV --yes

# Deploy changes to the cloud
echo "Deploying changes to the cloud..."
amplify push --yes

# Optional: Output the current status
echo "Checking current status..."
amplify status

echo "Deployment completed successfully."
