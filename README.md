# Cloud Wookiee
## Your Guide to Terraform Deployment Automation
Welcome to Cloud Wookiee, the stalwart companion in your journey across the vast and sometimes tumultuous landscape of deployment automation. Cloud Wookiee empowers you to manage the lifecycle of your Terraform-based infrastructure with confidence and consistency.
 
### Documentation
- [Project Overview](docs/project-overview.md)
- [Network Diagram](docs/assets/20240226_target-network-diagram.jpg)

## Getting Started
**Ensure you're standing in the heart of your project directory, where the env_config.json and .bashrc are located**. This file is the map to your galaxy, guiding Cloud Wookiee on what environments to build, destroy, or test.
``` bash
source .bashrc
```
## Command Arsenal
### 1. deploy_env 
This command deploys your environment. Simply execute cloudwookiee.deploy_env in the console, and watch as your infrastructure materializes from the ethers of the cloud.
``` bash
cloudwookiee.deploy_env
```
### 2. destroy_env
cloudwookiee.destroy_env dismantles your environment, leaving no trace behind, as if you've successfully navigated an asteroid field.

``` bash
cloudwookiee.destroy_env
```
### 3. test_deploy
cloudwookiee.test_deploy runs a dry run of your deployment, ensuring your shields are up and weapons operational.

``` bash
cloudwookiee.test_deploy
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
[Updated - JVU - 20240309]