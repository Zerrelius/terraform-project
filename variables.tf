variable "environment" {
  description = "Umgebung (development, staging, production)"
  type        = string
  default     = "development"

  validation {
    condition     = contains(["development", "staging", "production"], var.environment)
    error_message = "Environment muss development, staging oder production sein."
  }
}

variable "database_port" {
  description = "Externer Port für die Postgres Datenbank"
  type        = number
  default     = 5432

  validation {
    condition     = var.database_port > 1024 && var.database_port < 65535
    error_message = "Der Datenbank-Port muss zwischen 1024 und 65535 liegen."
  }
}

variable "backend_port" {
  description = "Externer Port für den Backend Service"
  type        = number
  default     = 3000

  validation {
    condition     = var.backend_port > 1024 && var.backend_port < 65535
    error_message = "Der Backend-Port muss zwischen 1024 und 65535 liegen."
  }
}

variable "frontend_port" {
  description = "Externer Port für den Frontend Service"
  type        = number
  default     = 8080

  validation {
    condition     = var.frontend_port > 1024 && var.frontend_port < 65535
    error_message = "Der Frontend-Port muss zwischen 1024 und 65535 liegen."
  }
}