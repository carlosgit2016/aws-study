data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance_1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  private_ip    = "10.0.0.5"
  subnet_id     = aws_subnet.subnet_1.id
  tags = merge({
    name = "instance_1_test"
  }, local.common_tags)
}

resource "aws_instance" "instance_2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  private_ip    = "10.0.1.6"
  subnet_id     = aws_subnet.subnet_2.id
  tags = merge({
    name = "instance_2_test"
  }, local.common_tags)
}