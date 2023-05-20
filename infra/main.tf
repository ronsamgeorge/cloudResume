terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# create dynamodb 
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "cloudresume"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "CounterId"

  attribute {
    name = "CounterId"
    type = "N"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "production"
  }
}

# create The API Gateway API
resource "aws_api_gateway_rest_api" "getCountApi" {
  name = "count"
  description = "API to retrieve visitor count"
}

#create API resource 
resource "aws_api_gateway_resource" "getCountResource" {
    parent_id = aws_api_gateway_rest_api.getCountApi.root_resource_id
    path_part = "count"
    rest_api_id = aws_api_gateway_rest_api.getCountApi.id
}

# create API resource Method
resource "aws_api_gateway_method" "getCountMethod" {
  authorization = "NONE"
  http_method = "GET"
  resource_id = aws_api_gateway_resource.getCountResource.id
  rest_api_id = aws_api_gateway_rest_api.getCountApi.id
}

# create IAM Role for the lambda function 
resource "aws_iam_role" "lambdaDynamoInfra" {
  name = "lambdaDynamoInfra"
  assume_role_policy = <<EOF
  {
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


# policy file for lambda role
data "template_file" "infrolambdapolicy" {
  template = "${file("${path.module}/policy.json")}"
}
