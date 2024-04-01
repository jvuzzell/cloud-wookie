# Cloud Wookiee
## Your Guide to Terraform Deployment Automation
Welcome to Cloud Wookiee, the stalwart companion in your journey across the vast and sometimes tumultuous landscape of deployment automation. Cloud Wookiee empowers you to manage the lifecycle of your Terraform-based infrastructure with confidence and consistency.
 
### Documentation
- [Project Overview](docs/project-overview.md)
- [Upgrading the Infrastructure](docs/upgrading-the-infrastructure.md)
- [Network Diagram](docs/assets/20240311_target-network-diagram.jpg)
- [Application Architecture](docs/assets/20240311_target-service-diagram.jpg)

## Getting Started
**Ensure you're standing in the heart of your project directory, where the env_config.json and .bashrc are located**. This file is the map to your galaxy, guiding Cloud Wookiee on what environments to build, destroy, or test.
``` bash
source .bashrc
```
## Command Arsenal
### 1. deploy_env 
This command deploys your environment. Simply execute cloudwookiee.deploy_env in the console, and watch as your infrastructure materializes from the ethers of the cloud.
``` bash
cloudwookiee.deploy_env <project_directory> <environment_name>
```
### 2. destroy_env
cloudwookiee.destroy_env dismantles your environment, leaving no trace behind, as if you've successfully navigated an asteroid field.

``` bash
cloudwookiee.destroy_env <project_directory> <environment_name>
```

## Utilities
### 1. cloudwookiee.help
cloudwookiee.help will guide you back to the path, displaying available commands.

``` bash
cloudwookiee.help
```

## In Closing
As you journey through your project's lifecycle, let Cloud Wookiee be the co-pilot you never knew you needed. With it, navigating the complexities of deployment becomes less about managing chaos and more about orchestrating harmony across the stars.

---

## Changelog 

### 20240331-JVU
* CloudWookiee supports projects
* Adds Terraform support for AWS User Pools, Identity Pools, and ACM Certificates
* Adds CloudWookiee steps to deploy certificates and acceess pools
* Updates documentation with new parameters and prompts regarding the infrastructure deployment and destruction scripts

### 20240311-JVU
* Updates documentation adding new diagrams, and overviews for deployment script
* Remove cloudwookiee.test_plan command (temporarily) 
* Reorganizes modules in the environment directory to support 
* Expands Cloudwookiees automation capabilities by adding configs that manage terraform apply along with allowing cloudwookiee to retrieve terraform.tfvars files from AWS Secrets Manager
* Stores environment specific plans in graphs directory to support future integrations with visualization software
* Updates deployment and destruction scripts to support targetted environments 
* Adds new chapter to documentation discussing how to upgrade the target infrastructure and services