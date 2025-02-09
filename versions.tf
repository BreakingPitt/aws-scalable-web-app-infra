terraform {
  required_version = "~> 1.9.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.54.1"
    }

    http = {
      source  = "hashicorp/http"
      version = "~> 3.4.3"
    }

    random = {
      source  = "hashicorp/random"
      version = "~> 3.6.2"
    }

    time = {
      source  = "hashicorp/time"
      version = "~> 0.11.2"
    }

    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0.5"
    }
  }
}
