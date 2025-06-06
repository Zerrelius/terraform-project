terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "docker" {
  host = "npipe:////.//pipe//docker_engine"
}

provider "aws" {
  region = "eu-central-1"
}