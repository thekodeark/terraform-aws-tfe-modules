# main.tf | Network Configuration

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.this.id
  count             = length(var.private_subnets)
  cidr_block        = element(var.private_subnets, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name        = "${var.module_name}-private-subnet-${count.index + 1}"
    Environment = var.environment
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = element(var.public_subnets, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  count                   = length(var.public_subnets)
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.module_name}-public-subnet-${count.index + 1}"
    Environment = var.environment
  }
}