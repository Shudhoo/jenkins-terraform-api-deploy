terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

/*terraform {
  backend "s3" {
    bucket = "proj-state-locking-bucket-300425"
    key = "terraform_state"
    region = "us-west-2"

    #New feat to enable s3 navtive locking
    use_lockfile = true
  }
}
*/