provider "docker" {}

resource "docker_image" "postgres-database" {
  name         = "postgres:15"
}

resource "docker_network" "private_network" {
  name = "DE_zoomcamp_2024"
}

resource "docker_container" "postgres-database" {
  name  = "DE_zoomcamp_postgres_2024"
  image = docker_image.postgres.image_id

  env = [ "POSTGRES_USER=${var.username}", "POSTGRES_PASSWORD=${var.password}", "POSTGRES_DB=${var.database}" ]

  ports {
    internal = 5432
    external = 5435
  }

  networks_advanced {
    name = docker_network.private_network.name
  }
}

resource "docker_image" "pgadmin" {
  name         = "dpage/pgadmin4"
}

resource "docker_container" "pgadmin" {
  name  = "DE_zoomcamp_pgadmin_2024"
  image = docker_image.postgres.image_id

  env = [       
    "PGADMIN_DEFAULT_EMAIL=${var.email}",
    "PGADMIN_DEFAULT_PASSWORD=${var.password}" ]

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name = docker_network.private_network.name
  }
}