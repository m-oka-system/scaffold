################################
# EC2
################################
data "aws_ssm_parameter" "amzn2_latest_ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

resource "aws_instance" "app" {
  ami                     = data.aws_ssm_parameter.amzn2_latest_ami.value
  instance_type           = var.instance_type
  iam_instance_profile    = var.instance_profile
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = [var.sg_id]
  disable_api_termination = false
  monitoring              = false
  user_data               = file("../../modules/ec2/user_data/${var.role}.sh")
  key_name                = var.key_name

  root_block_device {
    volume_size           = 8
    volume_type           = "gp2"
    delete_on_termination = true
    encrypted             = false
  }

  tags = {
    Name = "${var.prefix}-${var.role}"
  }

  volume_tags = {
    Name = "${var.prefix}-${var.role}"
  }
}
