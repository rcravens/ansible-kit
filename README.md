# 🚀 Ansible Kit 🚀

Here lies a collection of Ansible playbooks that simplify provisioning of a Docker Swarm in the cloud. Right now only Amazon AWS is supported.

> [!TIP]
> Because I have already built and pushed a Docker image to Docker Hub, you do not need this repository to make the following work.

> [!NOTE]
> The intent is for this image to be integrated into the <a href="https://github.com/rcravens/kit">Application Start Kit</a> so that you can run "kit commands" like:
> - `kit make server prod`
> - `kit provision prod`
> - `kit teardown prod`
> - `kit app:prod deploy`
>

## 💥 Features

The above will provision the following in the Amazon cloud:

- Domain / DNS
  - Hosted zone for the domain
  - Sub-domain with TLS/SSL certificates
- Networking
  - VPC
  - Internet Gateway (IGW)
  - Subnets (public and private)
  - Routing Table route between public subnet and IGW
  - NAT Gateway
  - Routing Table route between private subnet and the NAT
- Security
  - IAM Role to allow EC2 to access ECR. This allows EC2 to pull Docker Images from Amazon ECR.
  - Security Groups to allow outside access to: SSL(22), HTTPS(443), HTTP(80), HTTP(8080)
  - Security Groups to allow inside Docker Swarm node communication.
- Database / Caching
  - RDS MySQL instance
  - ElastiCache Redis instance
- Compute Resources
  - Creates a Key Pair used to access EC2 instances.
  - Creates in the public subnet, one EC2 instance for use as an ssh "jump box" or "bastion" server.
  - Creates in the private subnet, one EC2 instance for the Docker Swarm manager and a configurable number of EC2 instance(s) for Docker Swarm workers.
  - Installs common Linux packages, Docker, and AWS CLI along with all necessary packages on each EC2 instance.
- Load Balancing
  - ALB instance balancing load to Docker Swarm nodes
  - Configures a Docker Swarm (one manager and multiple worker nodes)
- Deployment
  - Allows easy deployment of "stacks" to Docker Swarm
  - Zero down time deployments
  - Scalable number of replicas

