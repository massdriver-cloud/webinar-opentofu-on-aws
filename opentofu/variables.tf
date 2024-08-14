variable "bucket_name" {
  type        = string
  default     = "webinar-opentofu-on-aws"
  description = "The name of the bucket."
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The region to use deploy resources to."
}
