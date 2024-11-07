variable "environment" {
  description = "Nome ambiente"
  default     = "production"
}

variable "vpc_cidr" {
  description = "VPC CIDR bloco"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "AZs para usar"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "bucket_name" {
  description = "Bucket S3 da Aplicação"
  type        = string
  default     = "application-bucket-public-s3"
}

variable "instance_type" {
  description = "Tipo de instância EC2"
  type        = string
  default     = "t2.micro"
}
