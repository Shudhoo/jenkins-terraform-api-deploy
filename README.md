
# Jenkins-Terraform-Infrastructure-Deploy

This Terraform project helped me focus on various important Terraform concepts. I am building a 3-tier architecture on AWS using Terraform, which is an Infrastructure as Code (IaC) tool that uses HCL (HashiCorp Configuration Language). HCL is easy to read and understand, but implementing complex infrastructure like a 3-tier architecture can be challenging. To overcome this complexity, I followed a modular approach to build the entire infrastructure, with a strong emphasis on code reusability and security.

After creating the entire infrastructure, I will automate the provisioning process using a Jenkins pipeline 

### Prerequisites:

Jenkins must be installed on the local machine or server.

Terraform must also be installed on the same machine where Jenkins is running, so Jenkins can execute Terraform commands during the pipeline execution.

* Java Installation
```bash
sudo apt update
sudo apt install fontconfig openjdk-21-jre
java -version
openjdk version "21.0.3" 2024-04-16
OpenJDK Runtime Environment (build 21.0.3+11-Debian-2)
OpenJDK 64-Bit Server VM (build 21.0.3+11-Debian-2, mixed mode, sharing)
```

* Jenkins Installation
```bash
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

* Terraform Installation
```bash
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

* To Clone Repository

```bash
git clone https://github.com/Shudhoo/jenkins-terraform-infrastructure-deploy.git
```
After installing and configuring Jenkins, start the Jenkins service. Jenkins listens on port 8080, so if you're using an AWS EC2 instance, make sure to open port 8080 in the associated security group to access the Jenkins dashboard.
Next, clone the repository to your machine. After cloning, update the terraform.tfvars file to include your specific resource identifiers such as AMI ID, key pair name, etc. These are required to provision the infrastructure.

Make sure to review the variables.tf file to understand all mandatory input variables for the infrastructure. Feel free to modify the setup—for example, you can add an Auto Scaling Group and a Load Balancer between the web server and app server to enhance security, scalability, and high availability.


## Steps to Provision the Infrastructure:

#### 1.  Initializing Terraform

```bash
  terraform init
```

This command initializes the Terraform working directory. It downloads the required provider plugins (e.g., AWS), sets up the backend for state management (if configured), and prepares Terraform to execute your configuration.

- Note: After adding any new modules, always run terraform init again to initialize those modules properly.

#### 2.  Terraform Plan 

```bash
  terraform plan
```

This command creates an execution plan. It shows which resources will be created, updated, or destroyed in your AWS environment based on the code. It also helps catch syntax or logical errors before applying the changes.

#### 3. Terraform applying

```bash
  terraform apply
```

This command applies the changes required to reach the desired state of the configuration. After running the command, Terraform will prompt for confirmation (yes/no). Once you confirm, it will begin provisioning your infrastructure.

- Note: Since this project involves multiple resources (VPC, EC2, subnets, etc.), provisioning may take several minutes.

#### 4. Terraform Destroy

```bash
  terraform apply
```

This command is used to tear down and delete all the infrastructure created by Terraform.


## Jenkins Pipeline

The Jenkins pipeline in this project acts like your personal cloud assistant that builds and manages AWS infrastructure using Terraform.

### Here’s how it works, step by step:

* Starts on Demand or Automatically
Jenkins can run when you click "Build Now" or whenever you push code to your repo.

* Parameterized Builds
We’ve set up the pipeline with parameters so you can choose what you want Jenkins to do—like:

      1. plan – Just show what changes Terraform will make without actually making them.

      2. apply – Actually create or update the infrastructure on AWS.

      3. destroy – Tear down and delete everything safely when you're done.

* Fetches the Terraform Code
Jenkins pulls the latest version of your Terraform code from GitHub (or your local repository).

* Initializes Terraform (terraform init)
This step sets up all the required plugins and configurations.

* Performs Your Selected Action
Depending on your choice (plan, apply, or destroy), Jenkins executes the right command and takes action accordingly.

* Automatic, Safe, and Repeatable
You don’t have to touch the terminal. Jenkins handles it all with consistency and safety every time.


## Acknowledgements

 - [Terraform](https://developer.hashicorp.com/terraform) for infrastructure provisioning.
 - [Jenkins](https://www.jenkins.io/) for automating the build process. 
 - [AWS Cloud](https://aws.amazon.com/free/?trk=14a4002d-4936-4343-8211-b5a150ca592b&sc_channel=ps&ef_id=Cj0KCQjwlMfABhCWARIsADGXdy-m6EzJq51Qx0-90dAsZkfKT1JWg6t2ESKEcoJ_73t2Z6UXfyaYt5QaAl5cEALw_wcB:G:s&s_kwcid=AL!4422!3!453325184782!e!!g!!aws!10712784856!111477279771&gad_campaignid=10712784856&gbraid=0AAAAADjHtp8fBpfYH0EogOG-b4JsEG2re&gclid=Cj0KCQjwlMfABhCWARIsADGXdy-m6EzJq51Qx0-90dAsZkfKT1JWg6t2ESKEcoJ_73t2Z6UXfyaYt5QaAl5cEALw_wcB&all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all) for providing the cloud infrastructure.

 ### Thank you for checking out this project! 🚀




    
