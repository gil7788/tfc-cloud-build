resource "null_resource" "create_user_service" {
  provisioner "local-exec" {
    command = "bash ../create_user_services.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "generate_substitutions" {
  provisioner "local-exec" {
    command = "bash ../generate_substitutions.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [null_resource.create_user_service]
}

resource "null_resource" "run_cloudbuild" {
  provisioner "local-exec" {
    command = "gcloud builds submit --config ../tfc_cloudbuild.yaml ."
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [null_resource.generate_substitutions]
}
