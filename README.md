
---

## ✅ Step 1: Docker

- **Dockerfile** is created to containerize the Ruby on Rails application.
- PostgreSQL runs in a separate container using `docker-compose.yml`.
- Simple Rails app created with PostgreSQL as backend.

📁 Files:
- `docker/Dockerfile`
- `docker/entrypoint.sh`
- `docker/docker-compose.yml`

---

## ☸️ Step 2: Kubernetes

- Rails app is deployed using a `Deployment` and `Service`.
- PostgreSQL is deployed using a `StatefulSet` for persistent storage.
- Ingress is configured for external access (e.g., via NGINX Ingress Controller).

📁 Files:
- `k8s/rails-deployment.yaml`
- `k8s/rails-service.yaml`
- `k8s/postgres-statefulset.yaml`
- `k8s/ingress.yaml`

---

## 🚀 Step 3: GitOps with ArgoCD

- ArgoCD is used to manage the Kubernetes deployment.
- Configuration includes linking to the private GitHub repository.
- Access control and repository credentials are set via config maps and secrets.

📁 Files:
- `gitops/application.yaml`
- `gitops/argocd-cm.yaml`
- `gitops/argocd-rbac-cm.yaml`
- `gitops/repo-secret.yaml`

---

## 🔁 Step 4: Tekton CI/CD Pipeline

- Tekton pipeline clones the source code, builds the Docker image using Kaniko, and pushes to Docker Hub.
- Pipeline is triggered manually from Tekton Dashboard.

📁 Files:
- `tekton/git-clone.yaml`
- `tekton/kaniko-build.yaml`
- `tekton/pipeline.yaml`
- `tekton/pipeline-run.yaml`

---

## 🛠 Prerequisites

- Docker & Docker Compose
- Minikube / K3d (for Kubernetes cluster)
- ArgoCD CLI or UI
- Tekton Pipelines and Tekton Dashboard installed
- Kubernetes Ingress Controller (like NGINX)
- Docker Hub account (for pushing image)

---

## 🎬 Demo Video

> Link to video demo of the entire setup: _[Add your video demo link here]_

---

## 📎 Submission

This repo includes:
- Dockerfile & Compose setup
- Kubernetes Manifests
- ArgoCD GitOps configs
- Tekton Pipeline configs

---

## 🔒 Note

This repository is kept private as per the assessment requirement. No sensitive keys or credentials are committed.

---

## 🙋‍♂️ Author

Aman Deol  
DevOps Learner | Cloud Enthusiast  
[LinkedIn](https://www.linkedin.com/in/amandeol) | [HackerRank](https://www.hackerrank.com/profile/amandeol)

---
