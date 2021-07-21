output "codecommit_repository" {
  value = aws_codecommit_repository.this.clone_url_http
}

output "ecr_repository" {
  value = aws_ecr_repository.this.repository_url
}
