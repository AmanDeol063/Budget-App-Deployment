# Budget-App-Deployment
This project is part of a DevOps assessment where I had to deploy a simple Ruby on Rails application with PostgreSQL using various DevOps tools like Docker, Kubernetes, ArgoCD, and Tekton.

---

## What I Did

### 🐳 Step 1: Docker
- I created a `Dockerfile` to containerize a Rails app.
- PostgreSQL runs in a separate container using `docker-compose`.
- This helped me understand how to run app and database in different containers.

### ☸️ Step 2: Kubernetes
- I wrote Kubernetes YAML files to deploy the Rails app and PostgreSQL.
- PostgreSQL runs using a StatefulSet for better data handling.
- I also set up Ingress so I could access the app from my browser.

### 🚀 Step 3: ArgoCD (GitOps)
- I installed ArgoCD and used it to deploy the app using GitOps.
- I created an `application.yaml` and other config files like `argocd-cm` and `rbac`.
- My Kubernetes files are stored in a private GitHub repo and synced using ArgoCD.

### 🔁 Step 4: Tekton CI/CD
- I created a Tekton pipeline that:
  - Clones the Rails app from GitHub
  - Builds the Docker image using Kaniko
  - Pushes the image to Docker Hub
- I used the Tekton Dashboard to manually run the pipeline.

---

## Files in This Project

```text
docker/     → Dockerfile and docker-compose
k8s/        → Kubernetes YAML files
gitops/     → ArgoCD config files
tekton/     → Tekton pipeline files
