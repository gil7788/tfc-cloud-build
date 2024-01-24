# Managing infrastructure as code with Terraform, Cloud Build, and GitOps

This is the repo for the [Managing infrastructure as code with Terraform, Cloud Build, and GitOps](https://cloud.google.com/solutions/managing-infrastructure-as-code) tutorial. This tutorial explains how to manage infrastructure as code with Terraform and Cloud Build using the popular GitOps methodology. 

## Configuring your **dev** environment

Just for demostration, this step will:
 1. Configure an apache2 http server on network '**dev**' and subnet '**dev**-subnet-01'
 2. Open port 80 on firewall for this http server 

```bash
cd ../environments/dev
terraform init
terraform plan
terraform apply
terraform destroy
```

## Promoting your environment to **production**

Once you have tested your app (in this example an apache2 http server), you can promote your configuration to prodution. This step will:
 1. Configure an apache2 http server on network '**prod**' and subnet '**prod**-subnet-01'
 2. Open port 80 on firewall for this http server 

```bash
cd ../prod
terraform init
terraform plan
terraform apply
terraform destroy
```

## Setup
This section explains how to set up `terraform` config in this repository with Google Cloud Platform (GCP).
### Setup Github
Create a Github repositroy with the following branches:
- `master`
- `prod`

### Setup GCP
- Enable Google Cloud API's
    - `gcloud config set project <GCP-project_id>`
    - `gcloud services enable cloudbuild.googleapis.com compute.googleapis.com`
- Create a Cloud Bucket
    - `CLOUDBUILD_SA="$(gcloud projects describe $PROJECT_ID \
    --format 'value(projectNumber)')@cloudbuild.gserviceaccount.com"`

    - `gcloud projects add-iam-policy-binding $PROJECT_ID \
    --member serviceAccount:$CLOUDBUILD_SA --role roles/editor`
    Where $PROJECT_ID is GCP project id.`
- Connect Cloud Build with Github Repository
    - Go to the GitHub Marketplace page for the Cloud Build app: [Link](https://github.com/marketplace/google-cloud-build)

### Cloud Build Setup Instructions
- 1. Enable Cloud Build and Artifact Registry APIs

Execute the following command to enable necessary services in your GCP project:

```bash
gcloud services enable \
    cloudbuild.googleapis.com \
    artifactregistry.googleapis.com \
    --project=<PROJECT-ID>
```

- 2. Create a Shell Script (run.sh)
Create a script named run.sh that will define your build or deployment commands.

- 3. Create a Dockerfile
Prepare a Dockerfile to define the steps for creating your Docker image.

- 4. Create a New Docker Repository
Use this command to create a Docker repository in the Artifact Registry:
```bash
gcloud artifacts repositories create quickstart-docker-repo \
    --repository-format=docker \
    --location=us-west2 \
    --description="Docker repository"
```

- 5. Verify the Repository Creation
Ensure your repository has been successfully created:

```bash
gcloud artifacts repositories list
```

- 6. Create cloudbuild.yaml
Prepare your cloudbuild.yaml file with the necessary build steps:
```yaml
steps:
  - name: 'gcr.io/cloud-builders/docker'
    script: |
      docker build -t us-west2-docker.pkg.dev/$PROJECT_ID/quickstart-docker-repo/quickstart-image:tag1 .
    automapSubstitutions: true
images:
  - 'us-west2-docker.pkg.dev/<PROJECT-ID>/quickstart-docker-repo/quickstart-image:tag1'
```

- 7. Submit the Build
Trigger the Cloud Build using the following command:
```bash
gcloud builds submit \
    --region=us-west2 --config \
    cloudbuild.yaml
```
These steps will guide you through setting up a Cloud Build process in GCP, including creating a Docker image and storing it in the Artifact Registry. Remember to replace `<PROJECT-ID>` with your actual GCP project ID.

- 8. Ensure running user has Cloud Run Admin IAM Permissions

### Configure Terraform Files
- Make sure that project name is set correctly in the following files:
    -   `environments/dev/backend.tf`
    -    `environments/dev/terraform.tfvars`
    -    `environments/prod/backend.tf`
    -    `environments/prod/terraform.tfvars`

## References
Terrafrom managing infrastructure as code: [Link](https://cloud.google.com/docs/terraform/resource-management/managing-infrastructure-as-code)