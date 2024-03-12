# Summary 

## Goals
Managing software environments (DEV, PROD, QA, etc) using reusable and version controlled components, this project demonstrates a generalized implementation of AWS services.

    1. Networking (In progress)
    2. Roles and Permissions (In progress)
    3. Serverless VMs using Amazon Fargate for compute (Pending)
    4. Serverless VMs using Amazon RDS for database storage (Pending)
    5. Amazon S3 for cloud storage and archival (Pending)
    6. Amazon SES for email services  
    7. Store Terraform state remotely

## Project Structure
```
.
├── README.md
├── docs
├── env_config.json
├── environments
│   └── dev
│       ├── example_wookie_config.json
│       ├── graphs
│       │   ├── step-1_base-network.plan
│       │   └── step-2_base-routing.plan
│       ├── terraform_config
│       │   ├── backend.tf
│       │   ├── example.terraform.tfvars
│       │   ├── main.tf                    <--- Step #1 - START HERE to inspect Terraform conf  uration
│       │   ├── modules                    <--- Step #2 - Review highest-level stacks
│       │   │   ├── archive      
│       │   │   ├── network               
│       │   │   ├── vpn
│       │   │   └── web-application
│       │   ├── output.tf
│       │   ├── terraform.tfstate
│       │   ├── terraform.tfstate.backup
│       │   ├── terraform.tfvars           <--- Step #3 - Environment specific configurations
│       │   └── variables.tf
│       ├── wookie_config.json
│       └── wookie_deployment_steps.json   <--- Step #4 - Customizable sequencing of module deployment (network > vpn > web-app)
├── example_env_config.json
├── library
│   ├── commands
│   │   ├── deploy_environment.sh
│   │   ├── destroy_environment.sh
│   │   └── set_environment.sh
│   └── utilities
├── modules
│   ├── _stacks                           <--- Step #5 - Second tier reusable stacks
│   │   └── base
│   │       ├── network
│   │       │   ├── main.tf
│   │       │   ├── output.tf
│   │       │   └── variables.tf
│   │       └── routing
│   │           ├── main.tf
│   │           ├── output.tf
│   │           └── variables.tf
|   └── <individual modules>             <--- Step #6 - Lowest level of resusability
├── providers
├── terraform.tfstate
└── terraform.tfstate.d
    └── dev
        └── terraform.tfstate

```

## Target Network Design
![Target Network Diagram](/docs/assets/20240311_target-network-diagram.jpg "Target Network Diagram")

## Target Service Design
![Target Services](/docs/assets/20240311_target-services.jpg "Target Services")
