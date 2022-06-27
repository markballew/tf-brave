output "server_node_sg_id" {
  description = "The ID of the created Security Group"
  value       = module.server_node_sg.id
}

output "server_node_sg_arn" {
  description = "The ARN of the created Security Group"
  value       = module.server_node_sg.arn
}

output "server_node_sg_name" {
  description = "The name of the created Security Group"
  value       = module.server_node_sg.name
}