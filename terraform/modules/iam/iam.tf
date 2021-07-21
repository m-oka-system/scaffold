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
