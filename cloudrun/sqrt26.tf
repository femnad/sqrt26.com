provider "google" {
  credentials = var.service_account_file
  project     = var.project
  region      = var.region
  zone        = var.zone
}

resource "null_resource" "submit-build" {

  triggers = {
    build-file-content = filesha512("cloudbuild.yaml")
  }
  provisioner "local-exec" {
    command = "gcloud builds submit --config cloudbuild.yaml ."
  }

}

resource "google_cloud_run_service" "sqrt26" {
  depends_on = [null_resource.submit-build]

  name     = "sqrt26-cloudrun-service"
  location = var.cloud_run_location

  traffic {
    latest_revision = true
    percent         = 100
  }

  metadata {
    annotations = {
      "client.knative.dev/user-image" = "gcr.io/foolproj/sqrt26:${var.tag}"
    }
    labels = {
      "cloud.googleapis.com/location" = "europe-west1"
    }
    namespace = "foolproj"
  }

  template {
    spec {

      containers {
        image = "gcr.io/${var.project}/sqrt26:latest"

        resources {
          limits = {
            "cpu"    = "1000m"
            "memory" = "256Mi"
          }
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.sqrt26.location
  project  = google_cloud_run_service.sqrt26.project
  service  = google_cloud_run_service.sqrt26.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

resource "google_dns_record_set" "verification-txt" {
  name = var.dns_root
  type = "TXT"
  ttl  = 60

  managed_zone = var.managed_zone

  rrdatas = [var.verification_txt]
}

resource "google_dns_record_set" "www-cname" {
  name = var.dns_name
  type = "CNAME"
  ttl  = 60

  managed_zone = var.managed_zone

  rrdatas = ["ghs.googlehosted.com."]
}

resource "google_dns_record_set" "root-ipv4-dns" {
  name = var.dns_root
  type = "A"
  ttl  = 60

  managed_zone = var.managed_zone

  rrdatas = ["216.239.32.21", "216.239.34.21", "216.239.36.21", "216.239.38.21"]
}

output "url" {
  value = "https://${var.mapped_domain}"
}