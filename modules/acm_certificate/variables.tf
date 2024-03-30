variable "domain_name" {
  description = "The domain name for the ACM certificate."
  type        = string
}

variable "zone_id" {
  description = "The Route 53 zone ID to use for DNS validation."
  type        = string
}
