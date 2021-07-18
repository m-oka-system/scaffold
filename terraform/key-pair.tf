################################
# Key pair
################################
resource "aws_key_pair" "this" {
  key_name   = "${var.prefix}-key"
  public_key = var.public_key
}
