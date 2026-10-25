# 🚀 Serverless Event-Driven Lead Capture Pipeline on AWS

An enterprise-grade, event-driven serverless web application and lead capture pipeline built on **Amazon Web Services (AWS)** and provisioned 100% through **Modular Infrastructure as Code (Terraform)**.

This project delivers a secure, highly responsive landing page hosted globally via CloudFront and backed by a completely serverless microservice architecture. When visitors submit lead details, requests are asynchronously processed through API Gateway and AWS Lambda, automatically persisting records in DynamoDB and triggering instant business notifications through Amazon SES—all operating at zero idle cost and fully within the AWS Free Tier.

---

## 🏛️ Architecture Overview

```text
[ User Browser ]
       │
       ▼ (HTTPS)
 [ CloudFront CDN ] ──(OAC)──► [ Private S3 Bucket (Landing Page) ]
       │
       ▼ (AJAX POST)
 [ API Gateway (HTTP API v2) ]
       │
       ▼ (Invoke)
 [ AWS Lambda (Python 3.12) ]
       ├─────────────────────────┐
       ▼                         ▼
[ Amazon DynamoDB ]      [ Amazon SES ]
 (Stores Lead Data)     (Sends Owner Alert)
```

### End-to-End Workflow:
1. **Global CDN Delivery**: Visitors access the eBook landing page through **Amazon CloudFront** edge locations with low latency and HTTPS enforcement.
2. **Hardened Static Origin**: Static assets reside in a private **Amazon S3** bucket, accessible strictly via **CloudFront Origin Access Control (OAC)** with direct public access blocked.
3. **Asynchronous Form Ingestion**: An AJAX request submits lead details (name, email) as JSON to **Amazon API Gateway (HTTP API v2)** with configured CORS headers.
4. **Serverless Compute**: API Gateway triggers an **AWS Lambda function** (Python 3.12).
5. **Persistence & Alerting**:
   - Lambda persists the lead record with an ISO-8601 timestamp into an on-demand **Amazon DynamoDB** table.
   - Lambda invokes **Amazon SES (Simple Email Service)** to immediately dispatch an email notification to the site administrator.

---

## ✨ Enterprise Best Practices Implemented

- **Infrastructure as Code (IaC)**: 100% provisioned via Terraform modules; zero manual console clicks.
- **Principle of Least Privilege (PoLP)**: Lambda IAM roles are granularly scoped strictly to `dynamodb:PutItem` on the target table ARN and `ses:SendEmail` on the verified identity ARN.
- **S3 Bucket Hardening**: Public access block enabled (`block_public_acls = true`, `block_public_policy = true`); bucket contents are only reachable through CloudFront OAC.
- **Decoupled Architecture**: Independent, reusable Terraform modules (`s3-static-website`, `cloudfront`, `api-gateway`, `lambda`, `dynamodb`, `ses`) with circular dependencies resolved at the root layer.
- **Cost-Optimized & Serverless**: DynamoDB uses `PAY_PER_REQUEST` billing; CloudFront uses `PriceClass_100`; completely stays within the AWS Free Tier.

---

## 📂 Repository Structure

```text
├── Ebook/                          # Static website frontend
│   ├── css/                        # Bootstrap & custom styling
│   ├── js/                         # Custom JS with async API handler
│   └── index.html                  # Responsive eBook landing page
├── modules/
│   ├── api-gateway/                # HTTP API v2 route and integration
│   ├── cloudfront/                 # CloudFront distribution & OAC
│   ├── dynamodb/                   # NoSQL table with pay-per-request
│   ├── lambda/                     # Function, IAM role, & Python handler
│   │   └── src/index.py
│   ├── s3-static-website/          # S3 bucket, MIME mappings, upload logic
│   └── ses/                        # Email identity configuration
├── main.tf                         # Root orchestrator & dependency wiring
├── variables.tf                    # Input variable definitions
├── outputs.tf                      # CloudFront URL, API URL, Table names
├── terraform.tfvars.example        # Sample variable definitions
└── .gitignore                      # Prevents committing tfstate & secrets
```

---

## 🛠️ Prerequisites

- [Terraform](https://www.terraform.io/) >= 1.5.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with proper IAM credentials
- An active AWS Account

---

## 🚀 Deployment Guide

### 1. Clone the repository
```bash
git clone https://github.com/russelmagtibay/Serverless-Event-Driven-Lead-Capture-Pipeline-on-AWS.git
cd Serverless-Event-Driven-Lead-Capture-Pipeline-on-AWS
```

### 2. Configure variables
Copy the sample variables file:
```bash
cp terraform.tfvars.example terraform.tfvars
```
Edit `terraform.tfvars` with your email:
```hcl
aws_region         = "ap-southeast-1"
project_name       = "serverless-lead-capture"
notification_email = "your-email@example.com"
```

### 3. Initialize and Deploy
```bash
terraform init
terraform plan
terraform apply
```

### 4. Verify SES Identity
AWS will send a verification email to your configured `notification_email`. Open your inbox and click the verification link to allow SES to send emails.

### 5. Invalidate CloudFront Cache (Optional)
If updating frontend code:
```bash
aws cloudfront create-invalidation --distribution-id <YOUR_DISTRIBUTION_ID> --paths "/*"
```

---

## 🧹 Teardown

To tear down all provisioned resources and prevent unintended AWS charges:
```bash
terraform destroy -auto-approve
```

---

## 💼 Key Skills Demonstrated

`AWS (S3, CloudFront OAC, API Gateway, Lambda, DynamoDB, SES)` • `Terraform (IaC)` • `Python 3.12` • `REST APIs & CORS` • `Least Privilege IAM` • `Event-Driven Architecture` • `Git/GitHub`
