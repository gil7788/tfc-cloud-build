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

### Configure Terraform Files
- Make sure that project name is set correctly in the following files:
    -   `environments/dev/backend.tf`
    -    `environments/dev/terraform.tfvars`
    -    `environments/prod/backend.tf`
    -    `environments/prod/terraform.tfvars`

## References
Terrafrom managing infrastructure as code: [Link](https://cloud.google.com/docs/terraform/resource-management/managing-infrastructure-as-code)