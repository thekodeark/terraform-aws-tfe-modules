resource "aws_eip" "this" {
  vpc        = true
  depends_on = [aws_internet_gateway.this]
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = element(aws_subnet.public.*.id, 0)
  depends_on    = [aws_eip.this]
}
