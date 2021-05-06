## What is VPC in AWS

VPC (Virtual Private Network) is a network logical isolated from the other things on AWS Cloud and dedicated for your AWS account. 

### VPC
You control how the instances in your VPC access resources outside the VPC

- IP Address 
- Subnets
- SGs
- Route tables

#### Subnet
Range of IP address for AWS 

- Public Subnet for resources that must connect to theinternet
- Private Subnets for resources that won't be connected oninternet
- Multiple layers of security
    - ACL Access Control lists
    - Security groups

#### VPC Default by AWS
After 2013-13-04 AWS has a default VPC that you can launch resources into it if you do not specify the VPC/subnet. This VPC has a subnet for each Availability Zone. Your default VPC includes a internet gateway and each subnet is a public subnet

- Each instance in the default VPC can communicate outside the VPC through the internet gateway.

##### Nondefault VPC
Created by us in our account

##### Nondefault subnets
Created by us in our default or non default VPC

##### Internet Gateway (IG) for default VPC
Enables your instances to connect outside AWS through AWS EC2 network edge

#### Route tables
A set of rules called route that control the direction of the traffic in a VPC. You can associate a Route table to a subnet, otherwise the subnet will be associate with the main route table that exists in the VPC.

##### Route
Each route specify a range of IP address to go, you can redirect to a gateway, network interface or connection through which to send the traffic (The target) 


### VPC Images

#### Default VPCs
![Default VPC](https://docs.aws.amazon.com/vpc/latest/userguide/images/default-vpc-diagram.png)

As we can see in the default VPC image we have a internet gateway to allow the instances inside the VPC to communicate outside this AWS VPC. Also we have one subnet by Availibility zone created by default and a range IP for them, each instance inside those subnets has a private and public IP assigned to them by default because these are public subnets. Also we can see a main route table assigned to the VPC and for the subnets providing a range IP for local communication having the Local as the target and another one providing communication for where ever through internet gateway

- Internet gateway, created by default in a default VPC and provides connection for outside the AWS VPC
- Public subnet, created by default in a default VPC for each Availibility Zone and it gives a Public/Private IPv4 for each instance inside that subnet 
- Route Table, main route table to the VPC that redirect the traffic from specific ranges of IP to the target
- Availibility Zone, a specific zone in a Data center that's phisycally sepparated

#### Non default subnets
![non default subnets](https://docs.aws.amazon.com/vpc/latest/userguide/images/nondefault-vpc-diagram.png)

For a VPC with non default subnets each instance that you launch into a non default subnet has no Public IP address assigned to them, unless you specify it in the isntance or mark the option for subnet. As we can see the instances can only communicate each other.

- Non Default subnet, a custom created subnet with a specify range of IP
- Instance in a non default subnet, each instance will receive a IPv4 address and those can only communicate each other
- Route table, main route table in the VPC that provides local communication for each instance can communicate each other

#### Internet access for a non default subnet
![internet access for a non default subnet](https://docs.aws.amazon.com/vpc/latest/userguide/images/internet-gateway-diagram.png)

As we can see we can enable internet access for the instances in a non default subnet by attaching a internet gateway to its VPC and associating a Elastic IP address with the instance

- Internet Gateway, a custom igw created to its VPC
- Custom route table, a custom rtb for the non default subnet having the redirect for the outside AWS VPC through igw
- Elastic IP, a elastic IP attached to the instances 


#### Internet access for a non default subnet thorugh a NAT device
Alternatively to the option above you can use a NAT device from the instances to the internet sending first for the igw. You can redirect the traffic from the instance in a private subnet to a NAT device and then the NAT device redirects it to the igw that will redirect it to the internet.

NAT device translate the IPv4 from a instance to communicate outside VPC and also translate what returns to the instance from the internet

- Not supported for IPv6 traffic
- Nat gateway, offered by AWS (Don't require administrations effort)
- Nat device, in the EC2 called Nat instance

#### Instances associated with a NAT gateway
![Instances associated with a NAT gateway](https://docs.aws.amazon.com/pt_br/vpc/latest/userguide/images/nat-gateway-diagram.png)

In the image the main Route table sends the traffic from the instances to the nateway gateway (0.0.0.0/0 nat-gateway-id) and the NAT gateway sends the traffic for the internet using a Elastic IP associated to him. In the first private subnet (10.0.0.0/24) we have a custom route table that's redirecting the traffic for the internet gateway from the NAT gateway