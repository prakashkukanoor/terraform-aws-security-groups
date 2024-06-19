locals {
  comman_tags = {
    Environment = var.environment
    ManagedBy   = var.team
  }
}

resource "aws_security_group" "allow_public_access" {
  count = var.public_access_sg ? 1 : 0 

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.comman_tags,
    {
        Name = "${each.key}-${var.environment}"
    }
  )
}

resource "aws_security_group" "allow_port_protocol_cidr" {
  for_each = var.ingress_rules

  ingress {
    from_port       = each.value.port
    to_port         = each.value.port
    protocol        = each.value.protocol
    cidr_blocks = each.value.cidr_ipv4
  }
  
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    local.comman_tags,
    {
        Name = "${each.key}-${var.environment}"
    }
  )
}