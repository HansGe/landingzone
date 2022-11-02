locals {
  # Set the location abbreviation
  lz_location = var.location == "westeurope" ? "we" : "ne"
}