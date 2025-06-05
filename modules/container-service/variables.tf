variable "container_name" {
  description = "Name des Containers"
  type        = string
}

variable "image" {
  description = "Docker Image für den Container"
  type        = string
}

variable "internal_port" {
  description = "Interner Container Port"
  type        = number
}

variable "external_port" {
  description = "Externer Port Mapping"
  type        = number
}

variable "environment_variables" {
  description = "Umgebungsvariablen für den Container"
  type        = map(string)
  default     = {}
}

variable "network_name" {
  description = "Name des Docker Netzwerks"
  type        = string
}

variable "volumes" {
  description = "Liste der Volume Mounts"
  type = list(object({
    container_path = string
    host_path      = string
  }))
  default = []
}

variable "depends_on_container" {
  description = "Container von dem dieser Service abhängt"
  type        = string
  default     = ""
}

variable "command" {
  description = "Startbefehl für den Container"
  type        = list(string)
  default     = []
}

variable "working_dir" {
  description = "Arbeitsverzeichnis im Container"
  type        = string
  default     = ""
}