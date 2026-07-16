##################################################
# Bastion Host Security Group
##################################################

resource "aws_security_group" "bastion" {

  name        = "${local.name_prefix}-bastion-sg"
  description = "Bastion Host Security Group"
  vpc_id      = aws_vpc.this.id

  ingress {

    description = "SSH"

    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-bastion-sg"
    }
  )

}

##################################################
# EKS Control Plane Security Group
##################################################

resource "aws_security_group" "eks_cluster" {

  name        = "${local.name_prefix}-eks-cluster-sg"
  description = "Amazon EKS Control Plane"
  vpc_id      = aws_vpc.this.id

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-sg"
    }
  )

}

##################################################
# EKS Worker Nodes
##################################################

resource "aws_security_group" "eks_nodes" {

  name        = "${local.name_prefix}-eks-nodes-sg"
  description = "Amazon EKS Worker Nodes"
  vpc_id      = aws_vpc.this.id

  egress {

    from_port = 0
    to_port   = 0
    protocol  = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-nodes-sg"
    }
  )

}

##################################################
# Cluster -> Nodes
##################################################

resource "aws_security_group_rule" "cluster_to_nodes" {

  type = "ingress"

  from_port = 443
  to_port   = 443
  protocol  = "tcp"

  security_group_id = aws_security_group.eks_nodes.id

  source_security_group_id = aws_security_group.eks_cluster.id

}

##################################################
# Nodes -> Cluster
##################################################

resource "aws_security_group_rule" "nodes_to_cluster" {

  type = "ingress"

  from_port = 10250
  to_port   = 10250
  protocol  = "tcp"

  security_group_id = aws_security_group.eks_cluster.id

  source_security_group_id = aws_security_group.eks_nodes.id

}

##################################################
# Node-to-Node Communication
##################################################

resource "aws_security_group_rule" "node_to_node" {

  type = "ingress"

  from_port = 0
  to_port   = 65535
  protocol  = "tcp"

  security_group_id = aws_security_group.eks_nodes.id

  source_security_group_id = aws_security_group.eks_nodes.id

}
