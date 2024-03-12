# Upgrading the Infrastructure
Upgrading your infrastructure with Cloud Wookiee is designed to be a streamlined and intuitive process, ensuring your Terraform-based environments evolve as your needs grow. Follow these steps to safely and efficiently upgrade your infrastructure components.

## Preparing for Upgrade
* **Backup Critical Data:** Before making any changes, ensure you have up-to-date backups of all critical data, including Terraform state files and environment configurations.
* **Review Current State:** Examine your current infrastructure setup by inspecting the Terraform configuration files within the **`environments/dev/terraform_config`** directory and understanding the deployed modules and resources.

## Upgrade Process
* **Inspect Terraform Configuration:** Begin with the main.tf file in the **`environments/dev/terraform_config`** directory to review the existing configuration.
* **Review Modules:** Navigate to the modules directory within terraform_config to evaluate the highest-level stacks, ensuring they align with your upgrade objectives.
* **Adjust Variables:** Modify **`terraform.tfvars`** within the terraform_config directory to reflect any new or changed configurations for your environment.
* **Sequence Module Deployment:** Refer to **`wookiee_deployment_steps.json`** for a customizable sequencing of module deployment, ensuring dependencies are correctly managed.
* **Update Second Tier Stacks:** Review and update the **`_stacks`** in the modules directory for foundational changes, such as network or routing configurations.
* **Review and Update Individual Modules:** Examine each module within the modules directory for specific upgrades or enhancements.
* **Deploy Changes:** Use the **`cloudwookiee.deploy_env`** command to apply your changes to the environment. Monitor the output carefully for any errors or warnings.

## Post-Upgrade Verification
Successfully upgrading your infrastructure necessitates a thorough verification process to ensure that all changes have been correctly applied and that your system operates as intended. Follow the steps below to confirm a smooth transition to your upgraded environment.

## Verify Deployment Steps with Cloud Wookiee
After applying your infrastructure changes using the **`cloudwookiee.deploy_env`** command, it's essential to verify that each deployment step has been executed according to plan. You can find the sequence and details of deployment steps in the **`wookiee_deployment_steps.json`** file located at environments/<environment_name>/. For example:

```json
{
    "step-1_base-network": "module.network.module.base-network", 
    "step-2_base-routing": "module.network.module.base-routing"
}
```
This file outlines the specific Terraform modules and resources targeted during the upgrade process. Confirm that each step listed has been successfully completed by reviewing the output of the **`cloudwookiee.deploy_env`** script.

## Review Script Output
The **`cloudwookiee.deploy_env`** script provides detailed feedback on each deployment step, indicating success or failure. Carefully review this output to ensure all intended changes have been applied successfully and that there are no unresolved errors or warnings.

## Manual Cleanup and Security Considerations
Upon completion, you might be prompted to clear the graph directory to maintain security and cleanliness. Performing this action reduces risk exposure and ensures your deployment environment remains organized:

```bash
Do you want to clear the graph directory? (y/n):
```
Responding affirmatively will remove temporary plan files, keeping your workspace tidy and secure.

## Conduct Thorough Testing
With the deployment steps verified, proceed to rigorously test your environment. Ensure all components function as expected and validate the performance and accessibility of services. This testing phase is crucial for identifying and rectifying any issues arising from the upgrade.

By adhering to these verification steps, you leverage Cloud Wookiee's capabilities to ensure your infrastructure upgrade enhances system performance, security, and reliability according to your project requirements.

---
[Updated - JVU - 20240311]

