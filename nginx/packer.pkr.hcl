packer {
  required_plugins {
    googlecompute = {
      version = "= 1.0.16"
      source  = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "nginx" {
  project_id   = "custom-servers-poc"
  source_image_family = "ubuntu-2204-lts"
  ssh_username = "erick"
  image_name = "nginx-1"
  zone         = "us-central1-a"
}


build {
  sources = ["sources.googlecompute.nginx"]
  
  provisioner "shell" {
    pause_before = "60s"
    inline = ["sudo apt-get update",
      "sudo apt install -y curl gnupg2 ca-certificates lsb-release",
      "sudo apt install -y debian-archive-keyring",
      "sudo curl https://nginx.org/keys/nginx_signing.key | sudo gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null",
      "export OS=$(lsb_release -is | tr '[:upper:]' '[:lower:]')",
      "export RELEASE=$(lsb_release -cs)",
      "echo \"deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/$OS $RELEASE nginx\" | sudo tee /etc/apt/sources.list.d/nginx.list",
      "sudo apt-get update",
      "sudo apt-get install -y nginx"]
  }
}
