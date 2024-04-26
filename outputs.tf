output "instance_id" {
  value = aws_instance.jenkins_server.id
}
# After enabling public DNS assignment in the console, 
# update your outputs.tf file to retrieve the public DNS name

# output "public_dns_name" {
#   value = aws_instance.jenkins_server.public_dns_name
# }

output "public_ip" {
  value = aws_instance.jenkins_server.public_ip
}
