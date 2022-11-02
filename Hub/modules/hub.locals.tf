locals {
  # Set the location abbreviation
  location = var.location == "westeurope" ? "we" : "ne"
}