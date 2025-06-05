locals {
  project_name = "multi-container-app"
  network_name = "${local.project_name}-network"

  database_config = {
    name     = "postgres"
    user     = "appuser"
    password = "changeme" # In Produktion sollte dies über sichere Variablen kommen
    port     = 5432
  }

  container_defaults = {
    postgres = {
      image = "postgres:alpine"
      port  = local.database_config.port
    }
    backend = {
      image = "node:alpine"
      port  = 3000
    }
    frontend = {
      image = "nginx:alpine"
      port  = 80
    }
  }
}