#!/bin/bash

source "$LIBRARY_DIR/utilities/extract_json_string_attr.sh"
source "$LIBRARY_DIR/utilities/extract_json_keys.sh"

# Remove the plan files after apply for security, relevance, and cleaniness
echo "Clearing the graph directory..."
    rm -rf "$target_env_dir/graphs/*"

# Check for argument presence
if [ "$#" -ne 1 ]; then
    echo ""
    echo "Usage: cloudwookiee.deploy_env <environment_name>"
    echo ""
    exit 1
fi

env_var="$1"
target_env_dir="$ENVIRONMENTS_DIR/$env_var"

# Check if the environment directory exists
if [ -d "$target_env_dir" ]; then
    echo "Directory for environment '$env_var' exists: $target_env_dir"
    cd "$target_env_dir"
else
    echo "No directory found for environment '$env_var'."
    exit 2
fi

echo "-----"
echo ""

#Extract variables from "$target_env_dir/wookie-config.json"

export AWS_PROFILE=$(extract_json_string_attr "AWS_PROFILE" "$target_env_dir/wookie_config.json") 
export TFVARS_AWS_SECRET_NAME=$(extract_json_string_attr "TFVARS_AWS_SECRET_NAME" "$target_env_dir/wookie_config.json")
export AWS_SECRETS_REGION=$(extract_json_string_attr "AWS_SECRETS_REGION" "$target_env_dir/wookie_config.json")

# Check if a cached SSO file exists
echo ""
echo "Checking for AWS SSO login..."

# Prompt the user to log in with AWS SSO
read -p "Do you want to log in with AWS SSO? (y/n): " -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    if aws sso login --profile "${AWS_PROFILE}"; then
        echo "Logged in successfully with AWS SSO."
    else
        echo "Failed to log in with AWS SSO."
        exit 1
    fi
else
    echo ""
    echo "Looking for an existing AWS SSO session."
    # Check for existing SSO session
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
        echo "You are not logged in via AWS SSO, and this script depends on AWS SSO."
        exit 1
    fi
fi

echo "-----"
echo ""

echo "Changing directory to..."
if cd "$target_env_dir/terraform_config"; then
    pwd
else
    echo "Failed to change directory. Exiting..."
    exit 1
fi

terraform init

echo "-----"
echo ""

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    # Check if TFVARS_AWS_SECRET_NAME is empty
    if [ -z "$TFVARS_AWS_SECRET_NAME" ]; then
        echo "No terraform.tfvars file found and TFVARS_AWS_SECRET_NAME is empty."
        echo "You must include a tfvars file as an AWS Secret or directly using a terraform.tfvars file in the root of the terraform_config directory."
        exit 1
    else
        echo "Fetching terraform.tfvars content from AWS Secrets Manager..."
        echo ""
        # Attempt to pull the secret and create a terraform.tfvars file
        aws secretsmanager get-secret-value --secret-id "$TFVARS_AWS_SECRET_NAME" --region "$AWS_SECRETS_REGION" --query 'SecretString' --output text --profile "$AWS_PROFILE" > terraform.tfvars

        if [ $? -ne 0 ]; then
            echo "Failed to fetch secret content from AWS Secrets Manager."
            exit 1
        fi
        echo "terraform.tfvars file created successfully from AWS Secrets Manager."
    fi
else
    echo "Using provided terraform.tfvars file."
fi

echo "-----"
echo ""

echo "Starting deployment steps..."
echo ""

# Extracting the keys from the JSON file
keys=$(extract_json_keys "$target_env_dir/wookie_deployment_steps.json")

echo "Deployment Steps"
echo "--"
echo "$keys"
echo "--"
# If keys are empty, output a message
if [ -z "$keys" ]; then
    echo "No keys were extracted from the JSON file. Please check the file format and the extract_json_keys function."
else
    for key in $keys; do
        target=$(extract_json_string_attr "$key" "$target_env_dir/wookie_deployment_steps.json") 
        echo $target
        terraform plan \
        -target="$target" \
        -out="$target_env_dir/graphs/$key.plan"

        terraform apply "$target_env_dir/graphs/$key.plan"
    done
fi
echo ""
echo "Deployment steps completed."

echo ""
echo "-----"

# Remove the plan files after apply for security, relevance, and cleaniness
read -p "Do you want to clear the graph directory? (y/n): " -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Clearing the graph directory..."
    rm -rf "$target_env_dir/graphs/*"
    echo "Graph directory cleared."
else
    echo "Graph directory not cleared. Manually clean up this directory to reduce risk exposure"
fi

echo ""