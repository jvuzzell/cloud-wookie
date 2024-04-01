
# Cloudwookiee Deploy Environment Script

This script facilitates the deployment of Terraform configurations for specified environments, handling AWS SSO login, fetching terraform.tfvars from AWS Secrets Manager if not present, initializing Terraform, and applying Terraform plans targeting specific resources as defined in your deployment steps JSON file. Here's how to use it:

## Usage

### Command Syntax
```sh
cloudwookiee.deploy_env <project_name> <environment_name>
```

### Parameters
* __<project_name>__ The name of the project you are deploying. This corresponds to a directory within a specified $PROJECT_DIR that contains your Terraform and configuration files.
* __<environment_name>__ The specific environment within the project you wish to deploy (e.g., development, staging, production). This should also correspond to a subdirectory within your project directory that contains environment-specific configurations.


## Steps for Usage
Ensure Prerequisites: Make sure you have AWS CLI installed and configured, especially with AWS SSO if required by your organization. Also, ensure Terraform is installed and accessible from your shell.

### Prepare the Environment

1. __Ensure Prerequisites:__ 

    Make sure you have AWS CLI installed and configured, especially with AWS SSO if required by your organization. Also, ensure Terraform is installed and accessible from your shell.

2. __Prepare the Environment:__

    - Your project should have a directory structure that matches what the script expects, 
        
            $PROJECT_DIR/<project_name>/<environment_name>

    - Ensure you have a wookiee_config.json file in the environment directory with necessary AWS and Terraform configurations.
    - If you have specific Terraform deployment steps, ensure they are defined in a wookiee_deployment_steps.json file in the same directory.

3. __Execute the Script:__ 

    Run the script from your terminal with the appropriate project and environment names as arguments. The script will guide you through the process, including any required AWS SSO login and Terraform actions.

4. __Follow Prompts:__ 
    
    Throughout its execution, the script will prompt you for decisions, such as confirming AWS SSO login and proceeding with Terraform plans and applies. Respond as appropriate for your deployment.

5. __Review Output:__ 
    
    Upon completion, review the script's output and any generated files or logs for success or error messages to ensure the deployment went as expected.

## User Prompts

Throughout the execution of the script, you'll encounter several prompts:

### 1. AWS SSO Login
This prompt asks the user if they wish to initiate a new AWS SSO login session. This is crucial for authenticating with AWS services if the user isn't already logged in or if they prefer to refresh their session.

### 2. Continue with Terraform Plan
After displaying the Terraform module providers, this prompt checks whether the user wants to proceed with the deployment process. It's a general confirmation step to ensure the user is ready to move on to initializing Terraform and applying configurations.

### 3. Apply Terraform Plans
This prompt appears after each Terraform plan is generated for a specific deployment step defined in the wookiee_deployment_steps.json file. It allows the user to review each plan and decide whether to apply it or not. This step ensures that the user has control over the modifications that Terraform will make to the infrastructure.

### 4. Clean-up Plans and Artifacts
At the end of the deployment process, this prompt asks the user if they want to clear the graphs directory, which contains Terraform plan files. Clearing this directory is suggested for security, relevance, and cleanliness, as these files might contain sensitive information or become outdated.