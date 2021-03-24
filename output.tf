output "instance_public_ip" { 
  value = aws_instance.dev_work.public_ip
}

output "instance_public_dns" { 
  value = aws_instance.dev_work.public_dns
}