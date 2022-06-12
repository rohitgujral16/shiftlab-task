###### Mongo DB user Management #########################
########  Pre-requisite   ###############################
# Export below  environment variables                   #
# MONGODB_ATLAS_PUBLIC_KEY & MONGODB_ATLAS_PRIVATE_KEY  #

# Defining provider

provider "mongodbatlas" {
}

# Defining variable that will read values from variable file
variable "user_creds" {
  description = "username , password and role are passed"
}


# Defining resource to take username, password and role as input

resource "mongodbatlas_database_user" "user_role" {
  project_id             = "Shiftlab"
  auth_database_name     = "admin"
  count                  = length(var.user_creds)
  username               = var.user_creds[count.index].name
  password               = var.user_creds[count.index].password
  roles {
    role_name            = var.user_creds[count.index].role
    database_name        = "shiftlabdb"
  }
}
