# Define resources for the Jenkins server
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-security-group"
  description = "Enable SSH and HTTP access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update with your allowed IP ranges
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Update with your allowed IP ranges
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  vpc_id = var.vpc_id

}

resource "aws_iam_role" "Terraform_Ssm_Role" {
  name = "Terraform_Ssm_Role"

  assume_role_policy = <<-EOF
    {
      "Version":"2012-10-17",
      "Statement":[
        {
          "Effect":"Allow",
          "Principal": {
            "Service": [
              "ec2.amazonaws.com"
            ]
          },
          "Action":"sts:AssumeRole"
        }
      ]
    }
  EOF
}

# IAM Instance Profile with the Role
resource "aws_iam_instance_profile" "Terraform_Ssm_Role" {
  name = "Terraform_Ssm_Role"
  role = aws_iam_role.Terraform_Ssm_Role.name
}

# Attach AdministratorAccess managed policy to the IAM role
resource "aws_iam_role_policy_attachment" "AdministratorAccessAttachment" {
  role       = aws_iam_role.Terraform_Ssm_Role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_instance" "jenkins_server" {
  ami                         = "ami-08116b9957a259459"
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  user_data                   = base64encode(file("./user-data.sh"))
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.Terraform_Ssm_Role.name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]
}


