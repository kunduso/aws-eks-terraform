[![License: Unlicense](https://img.shields.io/badge/license-Unlicense-white.svg)](https://choosealicense.com/licenses/unlicense/) [![GitHub pull-requests closed](https://img.shields.io/github/issues-pr-closed/kunduso/aws-eks-terraform)](https://github.com/kunduso/aws-eks-terraform/pulls?q=is%3Apr+is%3Aclosed) [![GitHub pull-requests](https://img.shields.io/github/issues-pr/kunduso/aws-eks-terraform)](https://GitHub.com/kunduso/aws-eks-terraform/pull/) 
[![GitHub issues-closed](https://img.shields.io/github/issues-closed/kunduso/aws-eks-terraform)](https://github.com/kunduso/aws-eks-terraform/issues?q=is%3Aissue+is%3Aclosed) [![GitHub issues](https://img.shields.io/github/issues/kunduso/aws-eks-terraform)](https://GitHub.com/kunduso/aws-eks-terraform/issues/) 
[![terraform-infra-provisioning](https://github.com/kunduso/aws-eks-terraform/actions/workflows/terraform.yml/badge.svg)](https://github.com/kunduso/aws-eks-terraform/actions/workflows/terraform.yml) 
[![checkov-static-analysis-scan](https://github.com/kunduso/aws-eks-terraform/actions/workflows/code-scan.yml/badge.svg?branch=main)](https://github.com/kunduso/aws-eks-terraform/actions/workflows/code-scan.yml) 

![EKS Architecture](https://via.placeholder.com/800x400/0066cc/ffffff?text=EKS+Cluster+Architecture)

## Introduction
The objective was to create a secure Amazon EKS (Elastic Kubernetes Service) cluster with all supporting infrastructure including VPC, security groups, IAM roles, and monitoring using **Terraform and GitHub Actions**.

<br />This implementation follows AWS security best practices including:
- Private EKS cluster endpoint configuration
- KMS encryption for ECR repositories and CloudWatch logs
- Least privilege IAM policies and security group rules
- Automated security scanning with Checkov
- Cost monitoring with Infracost (in pull requests)

<br />The entire infrastructure is provisioned using Infrastructure as Code (IaC) principles with Terraform, and deployed through a fully automated pipeline using GitHub Actions.

<br />This repository also includes **Infracost** estimates to monitor and control cloud costs. The pipeline automatically generates cost estimates for infrastructure changes in pull requests.

<br />*Note: This implementation focuses on the core EKS infrastructure. Application deployments, ingress controllers, and service mesh configurations are not included in this repository.*

## Architecture Components
This repository provisions the following AWS resources:
- **EKS Cluster** with private endpoint access and comprehensive logging
- **VPC** with public subnets, internet gateway, and VPC Flow Logs
- **EKS Node Groups** with auto-scaling configuration
- **Security Groups** with least privilege access rules
- **IAM Roles and Policies** for EKS cluster and worker nodes
- **ECR Repository** with KMS encryption and image scanning
- **CloudWatch Log Groups** with KMS encryption
- **OIDC Provider** for service account integration
- **KMS Keys** for encryption at rest

## Prerequisites
This repository uses a trusted OpenID connect identity provider in Amazon Identity and Access Management to provision AWS Cloud resources in the specified AWS account. You can read about it [here](https://skundunotes.com/2023/02/28/securely-integrate-aws-credentials-with-github-actions-using-openid-connect/) to get a detailed explanation with steps.
<br />The `ARN` of the `IAM Role` is stored as a GitHub secret which is referred in the [`terraform.yml`](https://github.com/kunduso/aws-eks-terraform/blob/main/.github/workflows/terraform.yml) file.
<br />As part of the *Infracost* integration, an `INFRACOST_API_KEY` was created and stored as a GitHub Actions secret. The cost estimate process was managed using a GitHub Actions variable `INFRACOST_SCAN_TYPE` where the value is either `hcl_code` or `tf_plan`, depending on the type of scan desired.

## Usage
Ensure that the policy attached to the IAM role whose credentials are being used in this configuration has permission to create and manage all the resources that are included in this repository.
<br />
<br />Review the code including the [`terraform.yml`](./.github/workflows/terraform.yml) to understand the steps in the GitHub Actions pipeline. Also review the `terraform` code to understand all the concepts associated with creating a secure EKS cluster, VPC, security groups, IAM roles, and encryption configurations.
<br />If you want to check the pipeline logs, click on the **Build Badge** (terraform-infra-provisioning) above the image in this ReadMe.

## Security Features
This implementation includes several security best practices:
- **Private EKS Endpoint**: Cluster API server is not publicly accessible
- **KMS Encryption**: ECR repositories and CloudWatch logs are encrypted at rest
- **Security Group Rules**: Specific ingress/egress rules following least privilege
- **IAM Roles**: Separate roles for cluster and worker nodes with minimal permissions
- **VPC Flow Logs**: Network traffic monitoring and analysis
- **Image Scanning**: Automatic vulnerability scanning for container images
- **Automated Security Scanning**: Checkov integration for infrastructure security validation

## Contributing
If you find any issues or have suggestions for improvement, feel free to open an issue or submit a pull request. Contributions are always welcome!

## License
This code is released under the Unlicense License. See [LICENSE](LICENSE).