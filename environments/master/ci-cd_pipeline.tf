resource "null_resource" "create_user_service" {
  provisioner "local-exec" {
    command = "bash ../create_user_services.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }
}

resource "null_resource" "generate_substitutions_and_cloudbuilds" {
  provisioner "local-exec" {
    command = "bash ../generate_substitutions_and_cloudbuild.sh"
  }

  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [null_resource.create_user_service]
}
