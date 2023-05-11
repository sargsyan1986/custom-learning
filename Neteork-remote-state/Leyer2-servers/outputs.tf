output "sg_id" {
  value = aws_security_group.webSG.id
}

output "natwork_details" {
  value = data.terraform_remote_state.network.outputs
}

output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
}
