provider "aws" {
    region = "us-east-2"
}
 
module "directories" {
  source = "../../../../../../modules/_stacks/base/user_and_identity_directories"
}