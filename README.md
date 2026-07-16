# CloudOptimizer

CloudOptimizer is a cloud cost optimization platform that helps identify AWS cost-saving opportunities by analyzing cloud resources and usage data. It provides actionable recommendations through a web dashboard and automates periodic cost analysis using AWS Lambda and EventBridge.

## Features

- Analyze AWS costs using AWS Cost Explorer
- View EC2, S3, and EBS resources
- Generate automated cost optimization recommendations
- Store recommendations in DynamoDB
- Schedule scans using EventBridge and AWS Lambda
- Interactive dashboard with cost insights
- Export reports as CSV and PDF
- Recommendation filtering
- Containerized with Docker and Docker Compose
- Infrastructure provisioned using Terraform

## Architecture

```text
                    +----------------------+
                    |      React UI        |
                    +----------+-----------+
                               |
                               |
                    +----------v-----------+
                    |    FastAPI Backend   |
                    +----------+-----------+
                               |
        +----------------------+----------------------+
        |                      |                      |
        |                      |                      |
+-------v--------+    +--------v--------+    +--------v--------+
| Cost Explorer  |    |      EC2        |    |    S3 / EBS     |
+----------------+    +-----------------+    +-----------------+

                               ^
                               |
                      EventBridge Schedule
                               |
                               v
                    +----------------------+
                    | AWS Lambda Scanner   |
                    +----------+-----------+
                               |
                               v
                    +----------------------+
                    |      DynamoDB        |
                    +----------------------+
```

## Tech Stack

| Category | Technologies |
|----------|--------------|
| Frontend | React, JavaScript |
| Backend | FastAPI, Python |
| Infrastructure | Terraform |
| Containerization | Docker, Docker Compose |
| Cloud | AWS |
| AWS Services | EC2, Lambda, DynamoDB, EventBridge, API Gateway, S3, EBS, CloudWatch, SNS, IAM, Cost Explorer |

## Project Structure

```text
CloudOptimizer/
├── backend/
│   ├── app/
│   ├── lambda/
│   ├── Dockerfile
│   └── requirements.txt
│
├── frontend/
│   ├── src/
│   ├── public/
│   ├── Dockerfile
│   └── package.json
│
├── terraform/
│   ├── modules/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── docker-compose.yml
├── README.md
└── .gitignore
```

## Getting Started

### Prerequisites

- Docker
- Docker Compose
- Terraform
- AWS CLI
- Python 3.13
- Node.js

### Clone the Repository

```bash
git clone https://github.com/<your-username>/CloudOptimizer.git
cd CloudOptimizer
```

### Deploy Infrastructure

```bash
cd terraform

terraform init
terraform plan
terraform apply
```

### Start the Application

```bash
docker compose up --build -d
```

### Access the Application

| Service | URL |
|---------|-----|
| Frontend | http://localhost:3000 |
| Backend API | http://localhost:8000 |
| API Docs | http://localhost:8000/docs |

## Future Improvements

- Multi-account AWS support
- Cost forecasting using historical data
- User authentication and role-based access control
- Multi-region resource analysis
- Email notifications for critical recommendations