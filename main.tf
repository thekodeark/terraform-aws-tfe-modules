/**
* ## Examples
*
* * [Usage](./examples)
*/



provider "aws" {
  region = "us-west-2"
}

data "aws_region" "active" {}

data "aws_caller_identity" "active" {}