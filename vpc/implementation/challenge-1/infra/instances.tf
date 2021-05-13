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

resource "aws_key_pair" "ssh" {
  key_name   = "ssh"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvrGKX5ZC1CdUztWw+OkFLspU54VMBrlGPZhJthpEP58jBP8kPBzwUqGrAXNzUdFKcwAhcGn5fMlnnoV0oI59hzimspfkOciWb291g0+qGWZpgYzsvb3G6mjKiszoc52B69p5pgNP7mKrbI7FZ4qwRZ37OphSoEO5ua+i1AiPQDxPiN0HhjZXj8vm/Ssud0iJQDp/feYBtv2v7lG5UdYGxaY9p+IxurIWhTN808j4hZYYVryHeF5RqR3lGR4vhEy7aaO03WGIsNoDsMhVQ0VkePOgG1ACxp2O0VlTIYsFPOtG7/XhlPy5eUCMUjyTl3PpXvL4Yd6VFTsr5W1vQGGYE9edx44xujTY0tvKmoV0rfhhdoifDyS7UTJyD2baMETTW1GFKNIdbuyxVv2GsRQb+utPARcI6jzyNu/aT+FtGm/SQxM339hX9tOhWtNJgiACLzXnF2PP+fWkmi2/v87/sChw+qPGMsGhEo4i25zbu4fcMDsNlv8KrkrflKMT6J/k= cflor@cflor-br-ll"
}

resource "aws_instance" "instance_1" {
  ami                         = data.aws_ami.ubuntu.id
  iam_instance_profile        = aws_iam_instance_profile.instances_profile.id
  instance_type               = "t3.micro"
  private_ip                  = "10.0.0.5"
  subnet_id                   = aws_subnet.subnet_1.id
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
  key_name                    = aws_key_pair.ssh.key_name
  associate_public_ip_address = true
  tags = merge({
    name = "instance_1_test"
  }, local.common_tags)
}

resource "aws_instance" "instance_2" {
  ami                    = data.aws_ami.ubuntu.id
  iam_instance_profile   = aws_iam_instance_profile.instances_profile.id
  instance_type          = "t3.micro"
  private_ip             = "10.0.1.6"
  subnet_id              = aws_subnet.subnet_2.id
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  key_name               = aws_key_pair.ssh.key_name
  tags = merge({
    name = "instance_2_test"
  }, local.common_tags)
}