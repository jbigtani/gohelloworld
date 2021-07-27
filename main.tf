# Configure GCP project
provider "google" {
  project = "disco-torus-320508"
}
# Deploy image to Cloud Run
resource "google_cloud_run_service" "mygowebapp" {
  name     = "mygowebapp"
  location = "us-central1"
  template {
    spec {
      containers {
        image = "gcr.io/disco-torus-320508/gohelloworld"
      }
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }

  timeouts {
    create = "5m"
    delete = "2h"
  }
}
# Create public access
data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.mygowebapp.location
  project     = google_cloud_run_service.mygowebapp.project
  service     = google_cloud_run_service.mygowebapp.name
  policy_data = data.google_iam_policy.noauth.policy_data
}
# Return service URL
output "url" {
  value = "${google_cloud_run_service.mygowebapp.status[0].url}"
}