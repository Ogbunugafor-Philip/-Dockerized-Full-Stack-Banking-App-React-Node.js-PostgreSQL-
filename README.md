# Dockerization & Deployment of a Full-stack Banking App Using AWS ECR, EC2 & Terraform

## Introduction

In today's fast-paced software development landscape, Docker has emerged as a game-changing technology for packaging, shipping, and running applications consistently across various environments. This project demonstrates the end-to-end Dockerization and cloud deployment of a full-stack banking application, with Docker at its core. The frontend (React), backend (Node.js), and database (PostgreSQL) are containerized using Docker and orchestrated using Docker Compose for local development. For production, these Docker images are pushed to Amazon Elastic Container Registry (ECR) and deployed on EC2 instances using Terraform. This project showcases how Docker can streamline application delivery, simplify infrastructure dependency management, and support scalable deployments in a cloud environment.
Statement of the Problem
Traditional application deployment often leads to "it works on my machine" issues, configuration mismatches, and lengthy manual processes. This is especially critical in financial applications like banking systems, where reliability, consistency, and rapid updates are essential. Without Docker, developers and DevOps teams face difficulties in replicating environments, ensuring portability, and managing dependencies across systems. There is a need for a Docker-centric solution that enables seamless development-to-production workflows, backed by cloud services for scalability and resilience.

## Objectives
i.	To containerize the full-stack banking application using Docker, ensuring consistent development and production environments for the frontend, backend, and database.

ii.	To demonstrate Docker Compose for orchestrating multi-container setups during local development and testing.

iii.	To push Docker images to Amazon ECR and deploy the application to AWS EC2 instances using Docker, ensuring portability and runtime consistency.

iv.	To use Terraform only as an automation tool for provisioning cloud infrastructure, allowing Docker to remain the primary technology driving the deployment lifecycle.

## Tools and Technologies

i.	Visual Studio Code – Used as the main code editor for managing frontend, backend, and infrastructure code.

ii.	Docker – Used to containerize the frontend, backend, and PostgreSQL database for consistent environments across development and production.

iii.	Docker Compose – Orchestrates multi-container setups locally, enabling the banking app, backend, and database to run together.

iv.	Amazon Elastic Container Registry (ECR) – A managed Docker image registry used to store and retrieve container images for deployment on AWS.

v.	Terraform – Used for automating the provisioning of cloud infrastructure such as EC2, RDS, VPCs, and security groups.

vi.	Amazon EC2 – Hosts the Dockerized backend application, pulling images directly from ECR for deployment.

vii.	Amazon RDS (PostgreSQL) – Provides a managed relational database backend for the banking application.

viii.	Application Load Balancer (ALB) – Distributes incoming traffic to EC2 instances running the Dockerized backend.

ix.	Auto Scaling Group (ASG) – Automatically scales EC2 instances based on traffic demand to maintain availability.

x.	Amazon S3 – Used to host the static files of the React frontend after build.

xi.	AWS CloudFront – Distributes the frontend globally with low latency and HTTPS support.

xii.	AWS CLI – Enables command-line interactions with AWS services, especially for Docker-ECR authentication and Terraform execution.

xiii.	Git – Used for version control, tracking code changes and enabling collaboration during development.

## Project Steps

Step 1: Project Setup (VS Code)

Step 2: Dockerization

Step 3: Push Docker Images to AWS ECR

Step 4: Infrastructure Provisioning with Terraform

Step 5: Frontend Hosting (S3 + CloudFront)

Step 6: Backend Deployment (EC2 + ALB + ASG)

Step 7: Testing and Monitoring

## Project Implementation

## Step 1: Project Setup (VS Code)
In this step, we prepare the application for local development by opening the project in Visual Studio Code and confirming the structure of both the frontend and backend. The backend (Node.js) is located in the server/ folder, while the frontend (React) is built from the src/ and public/ directories. We run npm install and npm start in both sections to verify that the app works properly on a developer machine before moving into Dockerization and cloud deployment.
The goal of this step is to run the application locally (backend + frontend) and confirm everything works before Dockerizing.


- Create a github repository named Docker_Project

- Next is to clone the created github repository. Open your git bash and run;
  git clone <repository url>

- Go to you zipped application, right click it and extract it into your cloned github repo and then open the repo via VS Code. 

- Navigate into the server/ folder (where the backend code lives). This is necessary so that the npm install and npm start commands run in the correct directory. To navigate to the         server folder, run
  ```bash
  cd fullstack_banking_app-master
  ```
  
  ```bash
  cd server
  ```

- Install Node Package Manager in the server folder. Run;
  ```bash
  npm install
 
- Now let’s start the Node Package Manager. Run;
  ```bash
  npm start
 
- Next, move back to the fullstack_banking_app-master folder by running the command;
  ```bash
  cd ..

- On the root folder, run the command;
  ```bash
  npm install -g yarn
  
  ```
  ```bash
  yarn install
  ```
  ```bash
  yarn start

once you enter the yarn start, if would re-direct you to a browser and the app would render
 

In this step, we set up the full-stack banking application locally using Visual Studio Code. The GitHub repo was cloned, and both the backend (Node.js) and frontend (React) were installed and run successfully. The application is now fully functional at http://localhost:3000, confirming that both the UI and backend work as expected. With this foundation in place, we’re now ready to containerize the application.

## Step 2: Dockerization
In this step, we’ll containerize the backend and frontend by creating separate Dockerfiles in their respective folders. We’ll then define a docker-compose.yml file at the project root to coordinate three services: backend, frontend, and PostgreSQL. After setup, we’ll test everything locally using docker-compose up --build to confirm that all containers work together smoothly.

Firstly, let us install docker

- Go to: https://www.docker.com/products/docker-desktop

- Click Download for Windows and install

- During installation:
  - Accept using WSL 2 (recommended).
  - Enable required features when asked.

- After installation:
  - Open Docker Desktop.
  - Wait until it shows "Docker is running" (may take a minute).

- Open Command Prompt or Git Bash and run:
  ```bash
  docker –version

```bash
docker compose version
```
In the server directory, we would create a file named Dockerfile. The file defines how to package your backend application into a Docker container.

- Paste the below script into the Dockerfile created
  code reference

- This script would do the following;
  - Pulls a Node.js environment
  - Installs your app’s dependencies
  - Copies your backend code into the container
  - Starts the server using npm start
 

- Now we will containerize our React frontend by creating a Dockerfile inside the fullstack_banking_app-master folder.

  Paste the below script into the Dockerfile created

  Code reference

- This Dockerfile will:
  
  - Use Node.js to build your React app.
  - Use Nginx to serve the built site on port 80.
 
- Now we’ll create a docker-compose.yml file to aid us run all 3 services together:
  - Backend (Node.js in server/)
  - Frontend (React in root)
  - PostgreSQL database

- In our root folder fullstack_banking_app-master, we would create a file named docker-compose.yml
  
  - We would paste the below script in our created docker-compose.yml file

    Code Reference
    
- The above script would allow:
  - PostgreSQL runs on port 5432 and stores data in a named volume.
  - Backend is built from server/, runs on port 5000, and connects to the database.
  - Frontend is built from root and served via Nginx on port 3000.

- Now we’ll build and run all three services (frontend, backend, and database) using Docker Compose.
  - Open your terminal and go to the root folder
```bash
cd fullstack_banking_app-master
```

- Run the Docker Compose command there. Run;
```bash
docker-compose up –build
``` 

- Test to make sure your app is Dockerized. To test the backend, run this url on your browser
http://localhost:5000/test
 
- To test the frontend, run this url on your browser
http://localhost:3000/
 

We have successfully Dockerized the full stack banking application, encapsulating the frontend (React), backend (Node.js/Express), and PostgreSQL database into isolated, reproducible containers.

Using Dockerfile and docker-compose.yml, we achieved:

i.	Backend Containerization: Node.js backend packaged in a Docker image and exposed via port 5000.

ii.	Frontend Containerization: React app built and served through Nginx on port 3000.

iii.	Database Integration: PostgreSQL service running in a persistent Docker volume on port 5432.

## Step 3: Push Docker Images to AWS ECR
Push Images to Amazon ECR involves preparing your Dockerized application for cloud deployment by uploading your container images to AWS. You’ll first create two ECR repositories: one for the frontend and one for the backend. Then, you’ll authenticate Docker to ECR using the AWS CLI, tag each image with its respective ECR URL, and push them to the cloud. This ensures that your images are accessible to AWS services like EC2 or ECS during deployment.
Before we start this step, we need to install AWS CLI
i.	Download the Installer
	Go to the official AWS CLI v2 download page: https://awscli.amazonaws.com/AWSCLIV2.msi
ii.	Run the Installer
	Double-click the downloaded AWSCLIV2.msi file.
	Follow the installation wizard steps.
	Leave all settings at default and click "Next" until it installs.
iii.	Step 3: Confirm Installation
iv.	After installation, open Command Prompt and run this command
aws –version
	Get AWS Access Key and Secret Access Key
	Sign into your AWS console
	Go to IAM (Identity and Access Management). In the search bar at the top, type IAM and open it.
	On the left sidebar, click Users, then create user
 

	When creating your user, type your user name, click attach polices directly, search and select AdministratorAccess, click next and click create user.
 

	To create Access Key, click the username created and click create access key
 

	Select CLI and click next, then create the access key. Do not forget to download your access key
	Next, in your terminal run this command aws configure and fill the following
	Access Key ID
	Secret Access Key
	Region (e.g., us-east-1)
	Output format (json)

	To confirm that your AWS CLI is set up correctly, run the command;
aws sts get-caller-identity

	We’ll create two repositories on Amazon ECR (Elastic Container Registry): banking-backend and banking-frontend. Run these commands separately
aws ecr create-repository --repository-name banking-backend
 

aws ecr create-repository --repository-name banking-frontend
 

	We would now authenticate Docker to AWS ECR so that Docker will be able to push and pull images from your ECR repositories. Run the command;
aws ecr get-login-password | docker login --username AWS --password-stdin 321552776361.dkr.ecr.us-east-1.amazonaws.com
 

	Now, let’s tag and Push Backend Docker Image to ECR. From inside the /server folder of your project, run these two commands one after another;
docker tag fullstack_banking_app-master-backend:latest 321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-backend:latest

docker push 321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-backend:latest
 

	Now, let’s tag and Push Frontend Docker Image to ECR. From inside the / fullstack_banking_app-master folder of your project, run these two commands one after another;
docker tag fullstack_banking_app-master-frontend:latest 321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-frontend:latest

docker push 321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-frontend:latest
 

In this step, began this phase by configuring the AWS CLI with our access credentials, enabling secure command-line access to AWS services. Next, we created dedicated ECR repositories for the backend and frontend services. After authenticating Docker to AWS ECR using temporary credentials, we tagged the locally built Docker images and pushed them to their respective repositories. This setup ensures that our application containers are securely stored in ECR and ready for deployment in the next phase.

Step 4: Infrastructure Provisioning with Terraform
In this step, we’ll use Terraform to set up the core AWS infrastructure. This includes creating a VPC with subnets and an internet gateway, security groups, a launch template for Docker-ready EC2 instances, and an IAM role for ECR access. We’ll also provision an RDS PostgreSQL database, set up an Application Load Balancer with Auto Scaling, and prepare an S3 bucket with CloudFront for hosting the frontend.
	In our root folder, well create a folder named terraform and create three files (main.tf, variables.tf and outputs.tf) inside and one folder namely modules
 


	In the terraform folder, create a file named provider.tf and paste the below script in it
terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "local" {}
}

provider "aws" {
  region = "us-east-1"  
}

	In our terraform folder, we would run the command terraform init to initialize the backend, download the AWS provider and prepare Terraform to use all the .tf files in that folder (including provider.tf, main.tf, etc.)
 

	In the modules folder, create a folder named vpc. In the vpc folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named security_groups. In the security_groups folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named launch_template. In the launch_template folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named rds. In the rds folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named alb. In the alb folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named asg. In the asg folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference


	Next, update the main.tf in the terraform root with the below;
Script Reference

	In the modules folder, create a folder named s3_cloudfront. In the s3_cloudfront folder, create three files;
main.tf
variables.tf
outputs.tf
Update the files with the code reference

	Next, update the main.tf in the terraform root with the below;
Script Reference

Now that we have finished all the infrastructure provisioning, we need to build in our AWS.
These are the command we would run;
	terraform init: Initializes your Terraform environment, downloading necessary modules and providers.
 

	terraform plan: Checks your configuration and provides a summary of resources Terraform will create.
 
	terraform apply -auto-approve: Builds your AWS infrastructure as defined in your .tf files without manual confirmation.
 
This step involved setting up the foundational AWS components essential for the full-stack banking application, including the VPC, subnets, internet gateway, EC2 launch templates, security groups, IAM roles, RDS PostgreSQL instance, application load balancer, auto-scaling group, and the S3 bucket with CloudFront distribution for the frontend.
With this robust and scalable infrastructure now in place, the environment is ready to support the Dockerized application deployment and ensure high availability, security, and seamless connectivity between services.

Step 5: Frontend Hosting (S3 + CloudFront)
In this phase, we deploy the React frontend application by first building the production-ready files using npm run build. The resulting /build folder is uploaded to an S3 bucket configured for static website hosting. To ensure secure, fast, and reliable delivery, we configure CloudFront as a CDN in front of the S3 bucket, enabling HTTPS access for end users globally.
This process makes the frontend application scalable and accessible with low latency while integrating seamlessly into the AWS infrastructure.
	Run these commands from the frontend project directory (fullstack_banking_app-master).
npm install
 


npm run build
 

	We would upload the /build folder contents to our S3 bucket with this command
aws s3 sync ./build s3://docker-project-frontend-bucket1989 –delete
 

Now let’s enable static website hosting on our S3 bucket (via AWS Console)
	Open the AWS Management Console and go to S3.
	Find and click your bucket: docker-project-frontend-bucket1989.
 
	Click the Properties tab.
	Scroll down to Static website hosting.
	Select Enable.
	For Index document, enter: index.html
	For Error document, also enter: index.html (this supports SPA routing)
 

	Click Save changes.

Next we need to set up CloudFront to serve app via HTTPS.
	Log in to AWS Console and go to CloudFront service.
	Find your existing CloudFront distribution in the list and click its ID to open its details.
	Check and update Origin Domain Name. Ensure the Origin Domain Name is your S3 bucket regional endpoint (e.g., docker-project-frontend-bucket1989.s3.us-east-1.amazonaws.com).

 






Next we would need to test the frontend by pasting the cloudfront domain name in a browser
https://ddt2rqwv0i2k7.cloudfront.net
 

Step 6: Backend Deployment (EC2 + ALB + ASG)
	Launch a Standalone EC2 Instance (For Backend Testing)
	Create or reuse a group that allows:
	SSH (port 22) from your IP
	HTTP (port 5000) from anywhere (0.0.0.0/0) — for test access
 

	IAM Role: Attach a role that has the following managed policy:
AmazonEC2ContainerRegistryReadOnly
 

	Attach Role to EC2
	Go to EC2 → Instances
	Select your backend test EC2 instance
	Click Actions → Security → Modify IAM Role
	Choose the role you just created (ECRReadOnlyRole)
	Click Update IAM role

	SSH into the instance. Run;
ssh -i "docker_project.pem" ec2-user@ec2-98-81-201-203.compute-1.amazonaws.com
 

	Install Docker by running these command
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
sudo usermod -aG docker ec2-user
 
After running these command log out and login again from your ec2 terminal

	Now let’s login to Amazon ecr. Run;
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 321552776361.dkr.ecr.us-east-1.amazonaws.com
 

	Now, run this command to pull your backend Docker image
docker pull 321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-backend
 

	Now let’s run your container and pass in the necessary environment variables for connecting to your PostgreSQL RDS. Run
docker run -d -p 5000:5000 \
  -e DB_HOST=docker-banking-db.c4lsm6coorl1.us-east-1.rds.amazonaws.com \
  -e DB_USER=Docker_project_db \
  -e DB_PASSWORD=Osita1989 \
  321552776361.dkr.ecr.us-east-1.amazonaws.com/banking-backend

	Check if the container is running. Run;
docker ps
 

	To test if the backend is running correctly, run the command
curl -i localhost:5000
 


This output means that
This means:
	The Express.js app is running
	It is listening on port 5000

Now, let’s connect our EC2 Backend to ALB
	In AWS Console, go to EC2 → Load Balancing → Target Groups
	Find your backend target group (likely created in Step 4 or 6)
	Click the Target Group name
	Go to the “Targets” tab
	Click “Register targets”
 

Register This EC2 Instance
	Select your running backend EC2 instance (the one where the container is working)
	Under Port, enter 5000
	Click Include as pending
	Click Register pending targets
 

Let us access the Backend from the Internet
	Go to EC2 → Load Balancers
	Click your Application Load Balancer
	Copy the DNS name (e.g., backend-alb-123456.elb.amazonaws.com)
	Open this in your browser or run:
http://docker-app-alb-1786682442.us-east-1.elb.amazonaws.com/test
 
To conclude this step 6, we would need to configure our Auto Scaling Group
We need to create a New Launch Template Version
	Go to EC2 → Instances
	Find the backend EC2 instance you manually launched and tested (Docker_Test)
	Select the instance
	Click Actions → Create template from instance
In the launch template creation page:
	Name: backend-launch-template 
	Version description: Working backend config with ECR and RDS
	Keep everything as default and then click launch template
 

Let us attach the New Launch Template to our ASG
	Go to EC2 → Auto Scaling Groups
	Select your existing ASG (used for backend)
	Click Actions → Edit
In the Edit Screen:
	Launch Template, Choose: backend-launch-template
	Version: Latest (very important)
	Leave everything else as-is
	Click Update
 
We successfully deployed and tested our backend EC2 instance, connected it to RDS, registered it with the ALB, and confirmed public access via /test. Finally, we created a new launch template from the working instance and updated our ASG to use it, ensuring backend scaling is now fully automated.

Step 7: Testing and Monitoring
In this step, we’ll validate the full end-to-end functionality of our application — from the CloudFront-hosted frontend to the backend API and database. We'll also test auto-scaling behavior under load and implement Cloudwatch monitoring to ensure visibility, performance, and reliability across the infrastructure.
	Access the CloudFront Frontend
	Go to AWS Console → CloudFront → Distributions
	Look for your frontend distribution (it was created for your S3 bucket)
	In the list, under Domain name, copy the full value
                       👉 https://ddt2rqwv0i2k7.cloudfront.net (Paste that into your browser and press Enter)
 
	Let us verify frontend connects to backend via ALB and ensure backend communicates with RDS.
	Trigger a Backend Call
	Interact with the app (e.g., login, register, click “dashboard”)
 

Our frontend is successfully communicating with the backend via ALB because:
	The /sign in request was sent from the browser
	The ALB received and forwarded it to the backend container
	The backend responded with a 400 (invalid credentials), not a network or CORS error
Our Backend Connects to RDS because the backend returned:
"Email/password does not match"
...which means it queried the PostgreSQL RDS, found a user mismatch, and returned a valid message.
So RDS is already connected and queried.
We successfully verified end-to-end communication across the frontend, backend, ALB, and RDS. Frontend requests are reaching the backend via ALB, and the backend is querying the RDS as expected. With this, the application stack is fully functional and production-ready.
Conclusion
This project successfully demonstrated the end-to-end Dockerization and cloud deployment of a full-stack banking application using modern DevOps practices and AWS services. By containerizing the React frontend, Node.js backend, and PostgreSQL database, we eliminated environment inconsistencies and streamlined local development with Docker Compose.

The integration of Amazon Elastic Container Registry (ECR) enabled secure image storage, while EC2 instances powered by a scalable Auto Scaling Group ensured high availability and performance. Terraform was used to provision the cloud infrastructure efficiently, providing a repeatable and automated deployment pipeline. Static frontend hosting via S3 and CloudFront offered global content delivery with HTTPS support. 
Ultimately, this project solved key deployment challenges—such as dependency conflicts, inconsistent environments, and manual infrastructure setup—by adopting a container-first approach, backed by infrastructure-as-code and cloud-native services.





