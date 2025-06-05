# Erstelle Docker Netzwerk
resource "docker_network" "app_network" {
  name = local.network_name
}

# Erstelle Volume für die Datenbank
resource "docker_volume" "postgres_data" {
  name = "${local.project_name}-db-data"
}

# Datenbank Service
module "database" {
  source = "./modules/container-service"

  container_name = "${local.project_name}-db"
  image          = local.container_defaults.postgres.image
  internal_port  = local.container_defaults.postgres.port
  external_port  = var.database_port

  environment_variables = {
    POSTGRES_DB       = local.database_config.name
    POSTGRES_USER     = local.database_config.user
    POSTGRES_PASSWORD = local.database_config.password
  }

  volumes = [
    {
      container_path = "/var/lib/postgresql/data"
      host_path      = docker_volume.postgres_data.name
    }
  ]

  network_name = docker_network.app_network.name
}

# Backend Service
module "backend" {
  source = "./modules/container-service"

  container_name = "${local.project_name}-backend"
  image          = local.container_defaults.backend.image
  internal_port  = local.container_defaults.backend.port
  external_port  = var.backend_port

  # Hinzufügen des Startbefehls
  command     = ["/bin/sh", "-c", "npm install && npm start"]
  working_dir = "/app"

  environment_variables = {
    DATABASE_URL = "postgresql://${local.database_config.user}:${local.database_config.password}@${module.database.container_name}:${local.database_config.port}/${local.database_config.name}"
    NODE_ENV     = var.environment
  }

  network_name         = docker_network.app_network.name
  depends_on_container = module.database.container_name
}

# Frontend Service
module "frontend" {
  source = "./modules/container-service"

  container_name = "${local.project_name}-frontend"
  image          = local.container_defaults.frontend.image
  internal_port  = local.container_defaults.frontend.port
  external_port  = var.frontend_port

  network_name         = docker_network.app_network.name
  depends_on_container = module.backend.container_name
}