data "aws_availability_zones" "available" {}

/*

    Log group that accepts VPC flow log logs

*/
resource "aws_cloudwatch_log_group" "group" {
  name       = "/aws/vpc/${var.company_name}/${var.environment}/${var.vpc_name}"
  kms_key_id = var.kms_key_arn
  tags       = var.tags
}

/*

    VPC flow log, monitors traffic to and from VPC resources

*/
resource "aws_flow_log" "flow_log" {
  iam_role_arn             = aws_iam_role.role.arn
  log_destination          = aws_cloudwatch_log_group.group.arn
  traffic_type             = "ALL"
  vpc_id                   = aws_vpc.main.id
  max_aggregation_interval = 60
  tags                     = var.tags
}

/*

    IAM role that allows flow logs to publish to Cloudwatch

*/
resource "aws_iam_role" "role" {
  name = substr("${var.company_name}-${var.environment}-${var.vpc_name}-loggrouprole", 0, 64)
  tags = var.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

/*

    Policy to attach to the flow log role

*/
resource "aws_iam_role_policy" "policy" {
  name = "${var.company_name}-${var.environment}-${var.vpc_name}-loggrouppolicy"
  role = aws_iam_role.role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

/*

    VPC to deploy

*/
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}"
    }
  )
}

/*

    Internet gateway to allow traffic to and from the internet for public subnets, and NAT gateways in public subnets

*/
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}"
    }
  )
}

/*

    Elastic IP for the NAT gateway

*/
resource "aws_eip" "nat" {
  vpc = true
}

/*

    NAT Gateway to allow outgoing traffic to the internet from private VPC resources

*/
resource "aws_nat_gateway" "gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public0.id
  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}"
    }
  )
}

/*

    Public subnets

*/
resource "aws_subnet" "public0" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 0)
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-public-0"
      Tier = "Public"
      "kubernetes.io/role/elb" = 1
    },
  )
}

resource "aws_subnet" "public1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 1)
  availability_zone = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-public-1"
      Tier = "Public"
      "kubernetes.io/role/elb" = 1
    }
  )
}

/*

    Private subnets for non-application resources like databases

*/
resource "aws_subnet" "private0" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 3)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-private-0"
      Tier = "Private"
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 4)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-private-1"
      Tier = "Private"
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

/*

    Private subnets for application resources like ECS tasks

*/
resource "aws_subnet" "private_app_0" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 5)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-private-app-1"
      Tier = "Private"
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

resource "aws_subnet" "private_app_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 4, 6)
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-private-app-2"
      Tier = "Private"
      "kubernetes.io/role/internal-elb" = 1
    }
  )
}

/*

    Public route table

*/
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-public"
    }
  )
}

/*

    Route to Internet gateway for the public route table

*/
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig.id
}

/*

    Assocoiate public subnets with the public route table

*/
resource "aws_route_table_association" "rta-public-0" {
  subnet_id      = aws_subnet.public0.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "rta-public-1" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.public-rt.id
}

/*

    Private route table

*/
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-${var.vpc_name}-private"
    }
  )
}

/*

    Route and route associations for private route table, used by app-specific and non-app-specific subnets

*/
resource "aws_route" "private" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.gw.id
}

resource "aws_route_table_association" "rta-private0" {
  subnet_id      = aws_subnet.private0.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "rta-private1" {
  subnet_id      = aws_subnet.private1.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "rta-private2" {
  subnet_id      = aws_subnet.private_app_0.id
  route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "rta-private3" {
  subnet_id      = aws_subnet.private_app_1.id
  route_table_id = aws_route_table.private-rt.id
}

/*

    Public NACL

*/
resource "aws_network_acl" "public" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.public0.id, aws_subnet.public1.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-public-nacl"
    }
  )
}

/*

    Private NACL

*/
resource "aws_network_acl" "private" {
  vpc_id     = aws_vpc.main.id
  subnet_ids = [aws_subnet.private0.id, aws_subnet.private1.id]

  tags = merge(
    var.tags,
    {
      Name = "${var.company_name}-${var.environment}-private-nacl"
    }
  )
}

/*

    Dynamic egress and ingress rules for the public NACL. Default rules are set in variables
    TODO doc more, lots more, talk about how it's optional but future stuff. Same for any other optional tool

*/
resource "aws_network_acl_rule" "public_variable_ingress_rules" {
  count          = length(var.public_nacl_ingress_rules)
  network_acl_id = aws_network_acl.public.id
  rule_number    = var.public_nacl_ingress_rules[count.index].rule_number
  protocol       = var.public_nacl_ingress_rules[count.index].protocol
  rule_action    = "allow"
  cidr_block     = var.public_nacl_ingress_rules[count.index].cidr
  from_port      = var.public_nacl_ingress_rules[count.index].from_port
  to_port        = var.public_nacl_ingress_rules[count.index].to_port
}

resource "aws_network_acl_rule" "public_variable_egress_rules" {
  count          = length(var.public_nacl_egress_rules)
  network_acl_id = aws_network_acl.public.id
  rule_number    = var.public_nacl_egress_rules[count.index].rule_number
  protocol       = var.public_nacl_egress_rules[count.index].protocol
  rule_action    = "allow"
  cidr_block     = var.public_nacl_egress_rules[count.index].cidr
  from_port      = var.public_nacl_egress_rules[count.index].from_port
  to_port        = var.public_nacl_egress_rules[count.index].to_port
  egress         = true
}

/*

    Dynamic egress and ingress rules for the private NACL. Default rules are set in variables

*/
resource "aws_network_acl_rule" "private_variable_ingress_rules" {
  count          = length(var.private_nacl_ingress_rules)
  network_acl_id = aws_network_acl.private.id
  rule_number    = var.private_nacl_ingress_rules[count.index].rule_number
  protocol       = var.private_nacl_ingress_rules[count.index].protocol
  rule_action    = "allow"
  cidr_block     = var.private_nacl_ingress_rules[count.index].cidr
  from_port      = var.private_nacl_ingress_rules[count.index].from_port
  to_port        = var.private_nacl_ingress_rules[count.index].to_port
}

resource "aws_network_acl_rule" "private_variable_egress_rules" {
  count          = length(var.private_nacl_egress_rules)
  network_acl_id = aws_network_acl.private.id
  rule_number    = var.private_nacl_egress_rules[count.index].rule_number
  protocol       = var.private_nacl_egress_rules[count.index].protocol
  rule_action    = "allow"
  cidr_block     = var.private_nacl_egress_rules[count.index].cidr
  from_port      = var.private_nacl_egress_rules[count.index].from_port
  to_port        = var.private_nacl_egress_rules[count.index].to_port
  egress         = true
}
