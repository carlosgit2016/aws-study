locals {
  common_tags = {
    timebox = "Should be deleted"
  }
}

resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = merge({
    name = "vpc_test"
  }, local.common_tags)

}

resource "aws_subnet" "subnet_1" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/24"
  tags = merge({
    name = "subnet_1_test"
  }, local.common_tags)
}

resource "aws_subnet" "subnet_2" {
  vpc_id     = aws_vpc.vpc.id
  cidr_block = "10.0.1.0/24"
  tags = merge({
    name = "subnet_2_test"
  }, local.common_tags)
}