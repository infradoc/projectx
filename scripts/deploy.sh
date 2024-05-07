#!/bin/bash

echo "Deploying to AWS Amplify in the $AMPLIFY_ENV environment..."

# Ensure AWS Amplify CLI is installed
if ! command -v amplify &> /dev/null; then
    echo "Amplify CLI could not be found, installing..."
    npm install -g @aws-amplify/cli
fi

# Initialize AWS Amplify if not already initialized
# if [ ! -d "amplify/.config" ]; then
#     echo "Initializing AWS Amplify..."
#     amplify init --amplify "{ \"envName\": \"$AMPLIFY_ENV\", \"appId\": \"$AMPLIFY_APP_ID\" }" --yes
# else
#     echo "AWS Amplify is already initialized."
#     echo "Ensuring the environment is in sync..."
#     amplify pull --appId "$AMPLIFY_APP_ID" --envName "$AMPLIFY_ENV" --yes
#    # amplify pull --appId "{ \"envName\": \"$AMPLIFY_ENV\", \"appId\": \"$AMPLIFY_APP_ID\" }" --yes
# fi


Initialize AWS Amplify if not already initialized
if [ ! -d "amplify/.config" ]; then
    echo "AWS Amplify is not initialized. Initializing..."
    amplify init --amplify @envName=$AMPLIFY_ENV --yes
fi


# Deploy changes to the cloud
echo "Deploying changes to the cloud..."
if amplify push --appId "$AMPLIFY_APP_ID" --envName "$AMPLIFY_ENV" --yes; then
    echo "Deployment completed successfully."
else
    echo "Deployment failed. See details above."
    exit 1
fi

# Optional: Output the current status
echo "Checking current status..."
amplify status
