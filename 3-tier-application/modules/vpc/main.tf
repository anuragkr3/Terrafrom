resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "3-tier-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet
  availability_zone       = var.az_public
  map_public_ip_on_launch = true
}

# # Private Subnet
# resource "aws_subnet" "private" {
#   vpc_id            = aws_vpc.main.id
#   cidr_block        = var.private_subnet
#   availability_zone = var.az_private
# }

# # Elastic IP
# resource "aws_eip" "nat" {
#   domain = "vpc"
# }

# # NAT Gateway
# resource "aws_nat_gateway" "nat" {
#   subnet_id     = aws_subnet.public.id
#   allocation_id = aws_eip.nat.id

#   depends_on = [aws_internet_gateway.igw]
# }

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# # Private Route Table
# resource "aws_route_table" "private" {
#   vpc_id = aws_vpc.main.id
# }

# resource "aws_route" "private_nat" {
#   route_table_id         = aws_route_table.private.id
#   destination_cidr_block = "0.0.0.0/0"
# }

# resource "aws_route_table_association" "private" {
#   subnet_id      = aws_subnet.public.id
#   route_table_id = aws_route_table.private.id
# }