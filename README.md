## 📌 Project Overview
An enterprise-grade, event-driven serverless web application and lead capture pipeline built on **Amazon Web Services (AWS)** and provisioned 100% through **Modular Infrastructure as Code (Terraform)**.
This project delivers a secure, highly responsive landing page hosted globally via CloudFront and backed by a completely serverless microservice architecture. When visitors submit lead details, requests are asynchronously processed through API Gateway and AWS Lambda, automatically persisting records in DynamoDB and triggering instant business notifications through Amazon SES—all operating at zero idle cost and fully within the AWS Free Tier.
### 🔑 Key Highlights:
- **100% Infrastructure as Code**: Zero manual console configuration; fully reproducible via modular Terraform.
- **Enterprise-Grade Security**: Origin Access Control (OAC) with S3 public access blocked, least-privilege IAM policies, and HTTPS encryption.
- **Zero-Idle Serverless Compute**: Microservices powered by AWS Lambda (Python 3.12) and DynamoDB (Pay-Per-Request).
- **Global Low-Latency Delivery**: Static assets served through Amazon CloudFront edge locations with automatic compression and caching.

  
