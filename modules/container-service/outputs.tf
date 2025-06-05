output "container_id" {
  description = "ID des erstellten Containers"
  value       = docker_container.service.id
}

output "container_name" {
  description = "Name des erstellten Containers"
  value       = docker_container.service.name
}

output "network_data" {
  description = "Netzwerk Informationen des Containers"
  value       = docker_container.service.networks_advanced
}

output "container_ip" {
  description = "IP Adresse des Containers"
  value       = docker_container.service.network_data[0].ip_address
}