
resource "random_pet" "ourhoard" {
  count  = var.pets_count
  length = var.pet_words
  keepers = {
    # Generate a new pet name each time the time changes
    make_on_every_apply = timestamp()
  }
}

resource "random_string" "random" {
  count            = var.pets_count
  length           = var.string_length
  special          = true
  override_special = "/@£$"
  keepers = {
    # Generate a new string  each time the time changes
    make_on_every_apply = timestamp()
  }
}

#output "demo" {
#  value = "${random_pet.demo.id}"
#}
