# Define a Private Subnet
resource "aws_subnet" "private" {
  vpc_id            = data.aws_vpc.vpc.id
  cidr_block        = "10.0.1.0/24"  # Change the CIDR if needed
  availability_zone = "ap-south-1a"

  tags = {
    Name = "DevOpsExam-PrivateSubnet"
  }
}

# Define a Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = data.aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = data.aws_nat_gateway.nat.id
  }

  tags = {
    Name = "DevOpsExam-RouteTable"
  }
}

# Define a Security group
resource "aws_security_group" "lambda_sg" {
  vpc_id = data.aws_vpc.vpc.id

# Define an ingress rule to allow HTTPS traffic
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

# Define an egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


# identify the security group

  tags = {
    Name = "DevOpsExam-SG"
  }
}

# AWS Lambda function resource
resource "aws_lambda_function" "my_lambda" {
  filename      = "lambda_function.zip"
  function_name = "devops_exam_lambda"
  role          = data.aws_iam_role.lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 10

  vpc_config {
    subnet_ids         = [aws_subnet.private.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = {
      SUBNET_ID = aws_subnet.private.id
    }
  }

  tags = {
    Name = "DevOpsExam-Lambda"
  }
}

