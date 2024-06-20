terraform {
  required_version = "~> 1.5.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.20.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.5.1"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.4"
    }
  }
}
