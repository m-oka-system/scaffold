output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2.name
}

output "codebuild_role_arn" {
  value = aws_iam_role.codebuild.arn
}

output "ecs_role_arn" {
  value = aws_iam_role.ecs.arn
}
