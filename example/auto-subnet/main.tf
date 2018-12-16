module "auto-vpc" {
    source  = "../../"

    name                    = "test-vpc"

    // forces for module project to complete and give ID before executing "auto-vpc"
    module_dependency       = "${module.project.id}"
}