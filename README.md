# VPC Module

This project includes:  
- **S3 Backend for State Management**: A secure, versioned, and highly available storage solution for Terraform state files, with lifecycle policies, encryption, and public access blocked. Also uses DynamoDB for state locking.  
- **VPC Module**: Provisions a secure, scalable, and highly available VPC, using best practices like dynamic availability zones, multiple subnets (public, private, and database), NAT gateways, and fully managed route tables. Includes dynamic tagging and consistent resource naming.  

---

## Why This Project?

### S3 Remote State Management (`s3-backend`)
The `s3-backend` module creates an S3 bucket with multiple security layers:  
- **Versioning** to enable rollbacks if necessary.  
- **Lifecycle policies** to prevent accidental deletion of state files.  
- **Server-side encryption** to protect state data at rest.  
- **Public access blocked** to avoid unauthorized access.  
- **DynamoDB table** for state locking, which prevents simultaneous state changes that could corrupt the infrastructure.  

These features ensure that the Terraform state is secure, consistent, and reliable.  

### VPC Module (`terraform-vpc-module`)
The `terraform-vpc-module` provisions the following resources:  
- A **VPC** with a flexible CIDR block.  
- **Dynamic availability zones**: Uses `data.aws_availability_zones` with `slice()` to automatically select the first two available zones.  
- **Subnets**: Creates public, private, and database subnets using `count.index` and `length` for dynamic allocation.  
- **Internet Gateway (IGW)** for internet access.  
- **NAT Gateway** with an **Elastic IP** for private subnet internet access.  
- **Route Tables** configured for public, private, and database subnets, with correct route associations.  
- **Resource Naming and Tagging** using `locals` and `merge()` for consistent resource management.  

This design simplifies VPC deployment and ensures high availability and maintainability.  

---

## Testing the Module (`vpc-module-test`)
Use the `vpc-module-test` directory to test the VPC module with sample configurations and validate outputs.  

---

## Directory Structure

```
.
├── terraform-vpc-module/ # Contains the VPC module code
├── vpc-module-test/ # Directory for testing the VPC module
└── s3-backend/ # S3 bucket and DynamoDB table for state management
```


---

## AWS VPC Module Overview

This module provisions the following resources:  
- VPC  
- Internet Gateway with VPC association  
- 2 public subnets (one in each of the first two availability zones)  
- 2 private subnets (one in each of the first two availability zones)  
- 2 database subnets (one in each of the first two availability zones)  
- Elastic IP  
- NAT Gateway in the first public subnet  
- Public Route Table  
- Private Route Table  
- Database Route Table  
- Subnet and route table associations  
- VPC peering (if requested by the user)  
  - Adds the peering route in the default VPC if the user does not provide an acceptor VPC explicitly.  
  - Adds peering routes in public, private, and database route tables.  

---

## Inputs

- **project_name** *(Required)*: Name of your project.  
- **environment** *(Required)*: Environment name (e.g., dev, prod).  
- **vpc_cidr** *(Optional)*: Default `10.0.0.0/16`, can be overridden.  
- **enable_dns_hostnames** *(Optional)*: Default `true`.  
- **common_tags** *(Optional)*: Recommended for consistent tagging.  
- **vpc_tags** *(Optional)*: Default `{}`. Type: map.  
- **igw_tags** *(Optional)*: Default `{}`. Type: map.  
- **public_subnets_cidr** *(Required)*: Provide 2 valid CIDR blocks.  
- **public_subnets_tags** *(Optional)*: Default `{}`. Type: map.  
- **private_subnets_cidr** *(Required)*: Provide 2 valid CIDR blocks.  
- **private_subnets_tags** *(Optional)*: Default `{}`. Type: map.  
- **database_subnets_cidr** *(Required)*: Provide 2 valid CIDR blocks.  
- **database_subnets_tags** *(Optional)*: Default `{}`. Type: map.  
- **nat_gateway_tags** *(Optional)*: Default `{}`. Type: map.  
- **public_route_table_tags** *(Optional)*: Default `{}`. Type: map.  
- **private_route_table_tags** *(Optional)*: Default `{}`. Type: map.  
- **database_route_table_tags** *(Optional)*: Default `{}`. Type: map.  

---

## Outputs

- **vpc_id**: The ID of the created VPC.  
- **public_subnet_ids**: List of the 2 public subnet IDs created.  
- **private_subnet_ids**: List of the 2 private subnet IDs created.  
- **database_subnet_ids**: List of the 2 database subnet IDs created.  
