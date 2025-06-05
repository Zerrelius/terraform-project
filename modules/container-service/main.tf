resource "docker_container" "service" {
  name  = var.container_name
  image = var.image

  # Hinzufügen von Command und Working Dir
  command     = var.command
  working_dir = var.working_dir

  # Starte Container im "always" Modus
  restart = "always"

  ports {
    internal = var.internal_port
    external = var.external_port
  }

  dynamic "volumes" {
    for_each = var.volumes
    content {
      container_path = volumes.value.container_path
      volume_name    = volumes.value.host_path # Verwende volume_name statt host_path
      read_only      = false
    }
  }

  networks_advanced {
    name = var.network_name
  }

  # Umgebungsvariablen als Liste statt dynamischem Block
  env = [for k, v in var.environment_variables : "${k}=${v}"]

  healthcheck {
    test         = ["CMD", "curl", "-f", "http://localhost:${var.internal_port}/health"]
    interval     = "30s"
    timeout      = "10s"
    retries      = 3
    start_period = "10s"
  }
}