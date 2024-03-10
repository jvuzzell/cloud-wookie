output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "public_subnet_ids" {
  value = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
}

output "private_subnet_ids" {
  value = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
}

output "igw_id" {
  value = module.igw.igw_id
}
