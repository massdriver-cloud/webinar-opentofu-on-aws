## Modules

- **Avoid Monolithic Modules**: Design modules with a narrow scope focused on a single cloud resource and its dependencies. This increases reusability and limits the potential impact of changes.
- **Encode Expertise in Modules**: Build modules that incorporate your company's requirements, security policies, and standard. Avoid generic modules that pass through values without adding configuration expertise.
- **Pin Module and Provider Versions**: Ensure infrastructure reproducibility and stability by pinning module and provider versions to specific versions or version ranges.

## Examples

### Narrow scoping

<details open>
<summary>Do:</summary>

```terraform
module "vpc" {
  source = "./modules/vpc"
  name   = "my-vpc"
}

module "storage" {
  source = "./modules/storage"
  name   = "my-storage"
}

module "vm" {
  source = "./modules/vm"
  name   = "my-vm"
}
```

</details>
<details open>
<summary>Don't do:</summary>

```terraform
module "my-module" {
  source       = "./modules/my-module"
  vpc_name     = "my-vpc"
  storage_name = "my-storage"
  vm_name      = "my-vm"
}
```

</details>

### Opinionated modules

<details open>
<summary>Do:</summary>

```terraform
resource "aws_vpc" "network" {
  cidr_block                   = var.cidr_block
  instance_tenancy             = "default"
  enable_dns_support           = true
  enable_network_usage_metrics = true
  enable_dns_hostnames         = true
}
```

```terraform
module "network" {
  source     = "./modules/network"
  cidr_block = "10.0.0.0/16"
}
```

</details>
<details open>
<summary>Don't do:</summary>

```terraform
resource "aws_s3_bucket" "storage" {
  cidr_block                   = var.cidr_block
  instance_tenancy             = var.instance_tenancy
  enable_dns_support           = var.enable_dns_support
  enable_network_usage_metrics = var.enable_network_usage_metrics
  enable_dns_hostnames         = var.enable_dns_hostnames
}

```

```terraform
module "network" {
  source                       = "./modules/network"
  cidr_block                   = "10.0.0.0/16"
  instance_tenancy             = "default"
  enable_dns_support           = true
  enable_network_usage_metrics = true
  enable_dns_hostnames         = true
}
```

</details>

### Pin versions

<details open>
<summary>Do:</summary>

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

```terraform
module "network" {
  source     = "github.com/myord/terraform-modules//modules/network?ref=abcdefg"
  cidr_block = "10.0.0.0/16"
}
```

</details>
<details open>
<summary>Don't do:</summary>

```terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
```

```terraform
module "network" {
  source     = "github.com/myord/terraform-modules//modules/network"
  cidr_block = "10.0.0.0/16"
}
```

</details>
