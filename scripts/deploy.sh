
#!/bin/bash

# Check required environment variables
if [ -z "$AMPLIFY_ENV" ] || [ -z "$AMPLIFY_APP_ID" ]; then
  echo "Environment variables AMPLIFY_ENV or AMPLIFY_APP_ID are not set."
  exit 1
fi

echo "Deploying to AWS Amplify in the $AMPLIFY_ENV environment..."

# Configure AWS credentials and region dynamically (these should be set in the GitHub Actions env)
aws configure set default.region $AWS_REGION
aws configure set aws_access_key_id $AWS_ACCESS_KEY_ID
aws configure set aws_secret_access_key $AWS_SECRET_ACCESS_KEY

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
amplify status

echo "Deployment completed successfully."
