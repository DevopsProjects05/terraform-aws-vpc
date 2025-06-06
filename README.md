

# VPC Module

This module includes:
- **S3 Bucket for State Management**: Ensures secure, versioned, and highly available storage of Terraform state files, with lifecycle policies, encryption, and public access blocked. Also uses DynamoDB for state locking.
- **VPC Module**: Provisions a secure and scalable VPC with best practices like dynamic availability zones, multiple subnets (public, private, and database), NAT gateways, and fully managed route tables. Includes dynamic tagging and resource naming for consistency and easy maintenance.


---

### AWS VPC Module

This module creates following resources. We are using HA, we are getting first 2 AZ automatically.
* VPC
* Internet Gateway with VPC association
* 2 Public subnets in 1a and 1b
* 2 Private subnets in 1a and 1b
* 2 Database subnets in 1a and 1b
* Elastic IP
* NAT gateway in 1a public subnet
* Public Route Table
* Private Route Table
* Database Route Table
* Subnets and Route table associations
* VPC peering if user requests
* Adding the peering route in default VPC, if user don't provide acceptor VPC explicitly.
* Adding the peering routes in public, private and database route tables

### Inputs
* project_name (Required) - your project name
* environment (Required) - which environment you are working in
* vpc_cidr (Optional) - Default value is 10.0.0.0/16, user can override
* enable_dns_hostnames (Optional) - Default value is true
* common_tags (Optional) - Better to provide
* vpc_tags (Optional) - Default value is empty. type is map
* igw_tags (Optional) - Default value is empty. type is map
* public_subnets_cidr (Required) - User must provide 2 valid public subnets CIDR
* public_subnets_tags (Optional) - Default value is empty. type is map
* private_subnets_cidr (Required) - User must provide 2 valid private subnets CIDR
* private_subnets_tags (Optional) - Default value is empty. type is map
* database_subnets_cidr (Required) - User must provide 2 valid database subnets CIDR
* database_subnets_tags (Optional) - Default value is empty. type is map
* nat_gateway_tags (Optional) - Default value is empty. type is map
* public_route_table_tags (Optional) - Default value is empty. type is map
* private_route_table_tags (Optional) - Default value is empty. type is map
* database_route_table_tags (Optional) - Default value is empty. type is map

### Outputs
* vpc_id -  VPC ID created
* public_subnet_ids - 2 public subnet ID created
* private_subnet_ids - 2 private subnet ID created
* database_subnet_ids - 2 database subnet ID created


