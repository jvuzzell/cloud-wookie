#!/bin/bash

# Check if a cached SSO file exists
echo ""
if [ -d "$HOME/.aws/sso/cache" ] && [ -n "$(ls -A $HOME/.aws/sso/cache)" ]; then
    echo "SSO cache found. Checking for valid credentials..."

    # Replace 'aws s3 ls' with a lightweight command that suits your use case
    if aws s3 ls --profile "$AWS_PROFILE" &> /dev/null; then
        echo "You are logged in with AWS SSO."
    else
        echo "Your session has expired or credentials are invalid."
        aws sso login --profile "${AWS_PROFILE}"
    fi
else
    echo "No AWS SSO cache found. You are not logged in."
    aws sso login --profile "${AWS_PROFILE}"
fi

echo "-----"
echo ""

# Initialize and apply Terraform
echo Changing directory to...
cd "$ENVIRONMENTS_DIR/dev/"
pwd
echo "-----"
echo ""

terraform init

# Implement base network
terraform plan \
  -target=module.base-network \
  -out=step-1_base-network.plan

terraform apply "step-1_base-network.plan"

# Implement routing within base network
terraform plan \
  -target=module.base-routing \
  -out=step-2_base-routing.plan

terraform apply "step-2_base-routing.plan"

# Remove the plan file after apply for security, relevance, and cleaniness
rm -f step-1_base-network.plan
rm -f step-2_base-routing.plan

echo ""
echo "----"
echo "Plan files removed."
echo ""