output "hosted_zone_id" {
  value = module.dns.hosted_zone_id
}

output "acm_certificate_arn" {
  value = module.dns.acm_certificate_arn
}

output "instance_profile_name" {
  value = module.iam.instance_profile_name
}

output "codebuild_role_arn" {
  value = module.iam.codebuild_role_arn
}

output "ecs_role_arn" {
  value = module.iam.ecs_role_arn
}

output "rds_role_arn" {
  value = module.iam.rds_role_arn
}

output "ecr_repository" {
  value = module.pipeline.ecr_repository
}

output "elb_bucket_name" {
  value = module.elb_log.elb_bucket_name
}
