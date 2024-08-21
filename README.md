# 🚀 Ansible Kit 🚀

Here lies a collection of Ansible playbooks that simplify provisioning of a Docker Swarm in the cloud. Right now only Amazon AWS is supported.

> [!TIP]
> Because I have already built and pushed a Docker image to Docker Hub, you do not need this repository to make the following work.

## 💥 Quick Start

1. Copy the `settings-example.yml` to `settings.yml`
2. Update the following in `settings.yml`:

- `app_name`
- `aws_account_id`
- `aws_region`
- `swarm_worker_node_count`
- `aws_vpc_cidr_block`
- `aws_subnet_cidr_block`

The rest of the variables are probably good left as their defaults.

3. To provision the resources run:

`docker run --rm -it -v ./deploy.yml:/ansible/settings.yml -v ~/.ssh:/root/.ssh -v ~/.aws:/root/.aws rcravens/ansible ansible-playbook playbooks/provision.yml`

4. To tear down the resources run:

`docker run --rm -it -v ./deploy.yml:/ansible/settings.yml -v ~/.ssh:/root/.ssh -v ~/.aws:/root/.aws rcravens/ansible ansible-playbook playbooks/teardown.yml`



> [!NOTE]
> The intent is for this image to be integrated into the <a href="https://github.com/rcravens/docker_starter_for_laravel">Laravel Start Kit</a> so that you can run "kit commands" like:
> - `kit provision`
> - `kit teardown`
> - `kit deploy <STACK>`
>

## 💥 Features

The above will provision the following in Amazon:

- A new VPC
- Internet Gateway (IGW) for the VPC
- Subnet for the VPC
- Routing Table route between Subnet and IGW
- IAM Role to allow EC2 to access ECR. This allows EC2 to pull Docker Images from Amazon ECR.
- Security Groups to allow outside access to: SSL(22), HTTPS(443), HTTP(80), HTTP(8080)
- Security Groups to allow inside Docker Swarm node communication.
- Creates a Key Pair (PEM file stored here `aws_key_pair_local_path`). Used to access EC2 instances.
- Creates one EC2 instance for the manager and `swarm_worker_node_count` EC2 instance(s) for workers.
- Installs common Linux packages, Docker, and AWS CLI along with all necessary packages on each EC2 instance.
- Configures a Docker Swarm

