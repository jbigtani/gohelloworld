# gohelloworld

## Google Cloud Run
This branch has code to run given hello world function in go on Google Cloud Run
 - main.tf: creates Cloud Run resource from container in GCR.

## gcloud commands
 Command to build container image using Google Cloud Build
  - gcloud builds submit --tag gcr.io/disco-torus-320508/gohelloworld
 Command to deploy the conatiner on Google Cloud Run
  - gcloud run deploy --image gcr.io/disco-torus-320508/gohelloworld
