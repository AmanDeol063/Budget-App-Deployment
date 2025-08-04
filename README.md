# Budget-App-Deployment

This project demonstrates the end-to-end deployment of a Ruby on Rails application with PostgreSQL using Docker, Kubernetes, Jenkins for CI/CD, and ArgoCD for GitOps. It also integrates security scanning tools like Trivy, Brakeman, and bundler-audit to ensure DevSecOps best practices. The application is containerized, tested, and deployed through a fully automated pipeline.

---

## What I Did

### 🐳 Step 1: Docker
- I created a `Dockerfile` to containerize the Rails app.
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

### 🔁 Step 4: Jenkins CI/CD
- I created a Jenkins pipeline that:
  - Clones the Rails app from GitHub
  - Builds the Docker image
  - Runs DevSecOps tools like Brakeman, bundler-audit, and Trivy
  - Pushes the image to Docker Hub
  - Updates the image tag in the Kubernetes manifest
  - Commits changes to the GitHub repo for ArgoCD to sync and deploy

---

## Files in This Project

```text
docker/     → Dockerfile and docker-compose
k8s/        → Kubernetes YAML files
gitops/     → ArgoCD config files
jenkins/    → Jenkins pipeline (Jenkinsfile)
 ```

## Tools Used

* Docker & Docker Compose
* Kubernetes (Minikube)
* ArgoCD (GitOps)
* Jenkins (CI/CD)
* Trivy, Brakeman, bundler-audit (DevSecOps)
* Docker Hub

## About Me

**Aman Deol**
Learning DevOps and Cloud ☁️

🔗 **Social Links**

* [LinkedIn](https://www.linkedin.com/in/amandeol063)
* [Credly](https://www.credly.com/users/amandeol063)

