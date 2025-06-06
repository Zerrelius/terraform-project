terraform {
  backend "s3" {
    bucket = "terraform-state-753856"  # Ersetzen Sie dies mit Ihrem erstellten Bucket-Namen
    key    = "terraform/state/prod.tfstate"
    region = "eu-central-1"
    encrypt = true
  }
}