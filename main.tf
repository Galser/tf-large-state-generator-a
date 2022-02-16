
resource "random_pet" "ourhoard" {
  count  = var.pets_count
  length = var.pet_words
}

resource "random_string" "random" {
  count            = var.pets_count
  length           = 1024
  special          = true
  override_special = "/@£$"
}

#output "demo" {
#  value = "${random_pet.demo.id}"
#}
