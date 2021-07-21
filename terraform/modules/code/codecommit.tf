################################
# Code commit
################################
resource "aws_codecommit_repository" "this" {
  repository_name = "sccafold"
  description     = "App repository for sccafold"
}
