## Putting VPC concepts in practice

As part of the study to VPCs stuff, we should create some scenarios to put what we learned in practice.


### Technologies
- Use python to act as a service in the instances
- Use Terraform to provision the infrastructure in AWS
- Use AWS as the cloud provider

### Basic VPC and private instances communicate
1. Create a custom VPC
1. Create two custom privates subnets 
1. Create one instance for each subnet
1. Make those two instances communicate each other and using python throught any protocol/port
1. Create logs in both instances to prove their communication

### Basic VPC and instances outside VPC communication
1. Create a custom VPC
1. Create a public subnet 
1. Create a internet Gateway
1. Create any python service to listen in some port and handle the requisitions
1. Create logs in the instance to prove that it's handling outside communication and doing it as well

### Advanced outside VPC communication
1. Create a custom VPC
1. Create two private subnets in two different Availibility Zones
1. Create two instances in each subnet
1. Create a internet gateway
1. Configure Elastic IP for each instances
1. Create and Configure a NAT Gateway
1. Configure the routing to outbound traffic from the instances can be translated by the NAT gateway 
1. Configure the routing from the NAT gateway for the internet gateway


### Considerations
- After the first challenge, Terraform modules can be used to create the infrastructure as well 