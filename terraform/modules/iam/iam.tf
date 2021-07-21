################################
# IAM
################################
# EC2
resource "aws_iam_instance_profile" "ec2" {
  name = aws_iam_role.ec2.name
  role = aws_iam_role.ec2.name
}

resource "aws_iam_role" "ec2" {
  name               = "ec2-admin-role"
  assume_role_policy = file("../../modules/iam/policies/ec2_assume_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "ec2" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

# Code Build
resource "aws_iam_role" "codebuild" {
  name               = "codebuild-service-role"
  assume_role_policy = file("../../modules/iam/policies/codebuild_assume_role_policy.json")
}

resource "aws_iam_policy" "codebuild" {
  name   = "codebuild-service-role-policy"
  policy = file("../../modules/iam/policies/codebuild_service_role_policy.json")
}

resource "aws_iam_role_policy_attachment" "codebuild" {
  role       = aws_iam_role.codebuild.name
  policy_arn = aws_iam_policy.codebuild.arn
}

