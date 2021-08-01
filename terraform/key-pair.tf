################################
# Key pair
################################
resource "aws_key_pair" "this" {
  key_name   = "${var.env}-${var.project}-key"
  public_key = var.public_key
}
