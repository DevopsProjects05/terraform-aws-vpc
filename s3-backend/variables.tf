variable "project_name" {
    type = string
    default = "Roboshop"
   
  
}
variable "environment" {
  description = "The environment name"
  type        = string
  default = "dev"
}


variable "bucket_name" {
    type = string
    default = "roboshop-bucket-123"
    
  
}