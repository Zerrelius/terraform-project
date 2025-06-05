output "database_connection" {
  description = "Datenbank Verbindungsinformationen"
  value = {
    host = module.database.container_name
    port = var.database_port
    name = local.database_config.name
    user = local.database_config.user
  }
  sensitive = true
}

output "service_endpoints" {
  description = "Zugangspunkte der Services"
  value = {
    frontend = "http://localhost:${var.frontend_port}"
    backend  = "http://localhost:${var.backend_port}"
    database = "postgresql://localhost:${var.database_port}"
  }
}

output "container_status" {
  description = "Status aller Container"
  value = {
    database = module.database.container_name
    backend  = module.backend.container_name
    frontend = module.frontend.container_name
  }
}

output "network_info" {
  description = "Docker Netzwerk Informationen"
  value = {
    name = docker_network.app_network.name
    id   = docker_network.app_network.id
  }
}