#!/bin/bash

source "$LIBRARY_DIR/utilities/extract_json_string_attr.sh"
source "$LIBRARY_DIR/utilities/extract_json_keys.sh"

echo ""

# Check for argument presence
if [ "$#" -ne 2 ]; then
    echo ""
    echo "Usage: cloudwookiee.destroy_env <project_directory> <environment_name>"
    echo ""
    exit 1
fi

project_var="$1"
env_var="$2"
target_env_dir="$PROJECT_DIR/$project_var/$env_var"

# Check if the environment directory exists
if [ -d "$target_env_dir" ]; then
    echo "Directory for environment '$env_var' exists: $target_env_dir"
    cd "$target_env_dir"
else
    echo "No directory found for environment '$env_var'."
    exit 2
fi

mkdir $target_env_dir/graphs

echo "-----"
echo ""

#Extract variables from "$target_env_dir/wookie-config.json"

export AWS_PROFILE=$(extract_json_string_attr "AWS_PROFILE" "$target_env_dir/wookiee_config.json") 
export TFVARS_AWS_SECRET_NAME=$(extract_json_string_attr "TFVARS_AWS_SECRET_NAME" "$target_env_dir/wookiee_config.json")
export AWS_SECRETS_REGION=$(extract_json_string_attr "AWS_SECRETS_REGION" "$target_env_dir/wookiee_config.json")

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
echo "-----"
echo ""

terraform plan -destroy -out="$target_env_dir/graphs/full-destroy.plan"

echo "-----"
echo ""
read -p "Do you want to proceed with destroying the infrastructure? (y/n): " -n 1 -r
echo    # move to a new line

if [[ $REPLY =~ ^[Yy]$ ]]; then
    terraform apply "$target_env_dir/graphs/full-destroy.plan"
    echo "Infrastructure destruction completed."
else
    echo "Destroy operation cancelled."
fi

# Remove the plan file after apply for security, relevance, and cleaniness
rm -f "$target_env_dir/graphs/full-destroy.plan"
echo "Removed the plan file."

echo "-----"
echo ""