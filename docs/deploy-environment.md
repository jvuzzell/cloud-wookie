
Cloudwookiee Deploy Environment Script

This script facilitates the deployment of Terraform configurations for specified environments, handling AWS SSO login, fetching terraform.tfvars from AWS Secrets Manager if not present, initializing Terraform, and applying Terraform plans targeting specific resources as defined in your deployment steps JSON file.

Usage

To run the script, navigate to your project's root directory and execute:

./path/to/script.sh <environment_name>

Replace <environment_name> with the name of the environment you wish to deploy (e.g., dev, prod).

User Prompts

Throughout the execution of the script, you'll encounter several prompts:

AWS SSO Login Prompt:

"Do you want to log in with AWS SSO? (y/n):"
A 'yes' response triggers an AWS SSO login flow. If declined, the script checks for an existing SSO session.
Clear Graph Directory Prompt (After Deployment):

"Do you want to clear the graph directory? (y/n):"
Responding 'yes' will clear the graphs directory of all plan files for security and cleanliness. A 'no' response leaves the files intact for manual cleanup.
Key Actions

AWS SSO Authentication: Handles AWS SSO login or verifies an existing session.
Terraform Variables: Fetches terraform.tfvars from AWS Secrets Manager if the file is missing and TFVARS_AWS_SECRET_NAME is provided.
Terraform Initialization and Application: Executes terraform init, then dynamically applies Terraform plans based on deployment steps defined in a JSON file.
Pre-requisites

The script assumes AWS CLI is configured for SSO and you have necessary permissions in AWS Secrets Manager.
A valid wookie-config.json in the target environment directory specifying AWS profile, secret name for tfvars, and AWS region.
The wookiee_deployment_steps.json should exist in the target environment directory, defining the Terraform resources to target during deployment.
Please ensure all pre-requisites are met to avoid execution errors and to ensure a smooth deployment process.