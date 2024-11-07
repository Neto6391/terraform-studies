resource "aws_instance" "machine_ec2" {
  count                  = length(var.availability_zones)
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.private_app[count.index].id
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name        = "${var.environment}-machine-az-${element(var.availability_zones, count.index)}"
    Environment = var.environment
  }
}
