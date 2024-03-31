output "certificate_arn" {
  description = "The ARN of the created ACM certificate."
  value       = module.acm_certificate.certificate_arn
}