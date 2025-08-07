
#Creating VPC

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = var.enable_dns_hostnames

  tags = merge(
    {
      Name = local.name
    },
    var.common_tags
  )

}

##Creating Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.igw_tags,
    {
      Name = local.name
    }

  )

}

#Creating public subnet

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.public_subnets_cidr)
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    var.common_tags,
    var.public_subnets_tags,
    {
      Name = "${local.name}-public-${local.az_names[count.index]}"
    }
  )
}

#Creating private subnet

resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.private_subnets_cidr)
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    var.common_tags,
    var.private_subnets_tags,
    {
      Name = "${local.name}-private-${local.az_names[count.index]}"
    }
  )
}

#Creating Database subnet

resource "aws_subnet" "database" {
  vpc_id            = aws_vpc.main.id
  count             = length(var.database_subnets_cidr)
  cidr_block        = var.database_subnets_cidr[count.index]
  availability_zone = local.az_names[count.index]
  tags = merge(
    var.common_tags,
    var.database_subnets_tags,
    {
      Name = "${local.name}-database-${local.az_names[count.index]}"
    }
  )
}

#Creating EIP

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "${local.name}"
  }

}

#Creating NAT Gateway

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.gw]

  tags = merge(
    var.common_tags,
    var.nat_gateway_tags,
    {
      Name = "${local.name}"
    }
  )
}

#Creating Public Route table

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.public_route_table_tags,
    {
      Name = "${local.name}-public"
    }
  )
}

#Creating Private Route table

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.private_route_table_tags,
    {
      Name = "${local.name}-private"
    }
  )
}

#Creating database Route table

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.common_tags,
    var.database_route_table_tags,
    {
      Name = "${local.name}-database"
    }
  )
} 

#Creating Route for public

resource "aws_route" "public" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.gw.id
}

#Creating Route for private

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.main.id
}

#Creating Route for database

resource "aws_route" "database" {
  route_table_id            = aws_route_table.database.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id = aws_nat_gateway.main.id
}

#Creating Public Route table association

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public[*].id, count.index)
  route_table_id = aws_route_table.public.id
}

#Creating Private Route table association

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets_cidr)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
  route_table_id = aws_route_table.private.id
}

#Creating Database Route table association

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets_cidr)
  subnet_id      = element(aws_subnet.database[*].id, count.index)
  route_table_id = aws_route_table.database.id
}