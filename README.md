# DevOps Take-Home Assignment

## Overview

This repository contains my solution for the DevOps Take-Home Assignment. The project demonstrates provisioning a production-like Kubernetes environment on AWS using **Terraform**, deploying a **Hello World** microservice using **Helm**, and configuring **Prometheus** and **Grafana** to monitor both the Kubernetes cluster and the deployed application.

---

# Tech Stack

* AWS EKS
* Terraform
* Docker
* Amazon ECR
* Kubernetes
* Helm
* Prometheus
* Grafana
* AWS EBS CSI Driver
* Metrics Server

---

# Project Structure

```text
.
├── terraform/
│   ├── providers.tf
│   ├── variables.tf
│   ├── vpc.tf
│   ├── eks.tf
│   ├── addon.tf
│   ├── ecr.tf
│   ├── outputs.tf
│   └── terraform.tfvars
│
├── hello-world/
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── helm/
│
├── screenshots/
│
└── README.md
```

---

# Architecture

```text
                   Terraform
                       │
                       ▼
                 AWS Infrastructure
                       │
          ┌────────────┴────────────┐
          │                         │
         VPC                   Amazon EKS
                                    │
                    ┌───────────────┴───────────────┐
                    │                               │
          Hello World Application          Monitoring Stack
                    │                    Prometheus + Grafana
                    ▼
            Kubernetes Service
```

---

# Features

* Provisioned Amazon EKS using Terraform
* Created custom VPC and networking components
* Configured managed node groups
* Built and pushed Docker image to Amazon ECR
* Packaged and deployed the application using Helm
* Configured AWS EBS CSI Driver with IRSA
* Installed Prometheus for metrics collection
* Installed Grafana for visualization
* Installed Metrics Server
* Configured Kubernetes monitoring dashboards

---

# Deployment

## Clone Repository

```bash
git clone https://github.com/iamaayushdeep/lucidity.git

cd lucidity
```

## Provision Infrastructure

```bash
cd terraform

terraform init

terraform plan

terraform apply
```

Terraform provisions:

* VPC
* Private Subnets
* Route Tables
* Internet Gateway
* NAT Gateway
* Amazon EKS Cluster
* Managed Node Group
* Amazon ECR Repository
* IAM Roles
* EKS Add-ons

---

## Configure kubectl

```bash
aws eks update-kubeconfig --region ap-south-1 --name eks-demo
```

Verify the cluster:

```bash
kubectl get nodes
```

---

## Build and Push Docker Image

```bash
docker build -t hello-world .
```

Authenticate with Amazon ECR and push the image.

---

## Deploy the Application

```bash
cd hello-world/helm

helm install hello-world .
```

Verify deployment:

```bash
kubectl get pods
kubectl get svc
```

---

## Install Monitoring

Install Prometheus:

```bash
helm install prometheus prometheus-community/prometheus \
-n monitoring \
--create-namespace
```

Install Grafana:

```bash
helm install grafana grafana/grafana \
-n monitoring
```

Install Metrics Server:

```bash
helm install metrics-server metrics-server/metrics-server \
-n kube-system
```

---

# Validation

Verify cluster nodes:

```bash
kubectl get nodes
```

Verify Kubernetes system components:

```bash
kubectl get pods -n kube-system
```

Verify monitoring stack:

```bash
kubectl get pods -n monitoring
```

---

# Screenshots

The following screenshots demonstrate successful infrastructure provisioning, application deployment, and monitoring.

## AWS Infrastructure

Terraform successfully provisioned the VPC and Amazon EKS cluster.

### Amazon VPC

![](screenshots/vpc.png)

### Amazon EKS Cluster

![](screenshots/eks.png)

---

## Kubernetes Cluster

The Kubernetes cluster was successfully created and all worker nodes joined the cluster in the **Ready** state.

![](screenshots/nodes.png)

---

## Monitoring Stack

Prometheus, Grafana, kube-state-metrics, Pushgateway, and Node Exporter are deployed successfully.

![](screenshots/monitoring.png)

---

## Grafana Dashboards

Grafana is configured with Prometheus as the datasource and provides dashboards for monitoring Kubernetes nodes, pods, CPU, memory, storage, and overall cluster health.

![](screenshots/Node-exporter.png)

![](screenshots/K8s-cluster.png)

![](screenshots/k8s-cluster-2.png)

---

## Hello World Application

The sample application has been deployed successfully using Helm.

![](screenshots/hello-world.png)

---

# Cleanup

To remove all AWS resources:

```bash
cd terraform

terraform destroy
```
