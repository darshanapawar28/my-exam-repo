provider "aws" {
  region = "ap-south-1"
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = "vpc-06b326e20d7db55f9"
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
}

resource "aws_security_group" "lambda_sg" {
  vpc_id = "vpc-06b326e20d7db55f9"
