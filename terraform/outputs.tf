output "public_ip" {
  value = aws_instance.devops_server.public_ip
}

output "ssh_command" {
  value = "ssh -i devops-key.pem ubuntu@${aws_instance.devops_server.public_ip}"
}

output "server_info" {
  value = {
    public_ip  = aws_instance.devops_server.public_ip
    app_url    = "http://${aws_instance.devops_server.public_ip}"
    grafana    = "http://${aws_instance.devops_server.public_ip}:3001"
    prometheus = "http://${aws_instance.devops_server.public_ip}:9090"
  }
}