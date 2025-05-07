# react-todo-demo

A minimal React Todo List application built with Hooks, containerized using Docker, and deployable to both `kind` (local Kubernetes) and `EKS` (AWS Elastic Kubernetes Service). This project serves as a frontend demo for learning Docker, Kubernetes, and CI/CD deployment automation.

## Features

- Add, toggle, and delete todo items
- Built with React functional components and hooks
- Dockerized for easy containerization and deployment
- Supports both local `kind` and cloud `EKS` Kubernetes clusters
- Includes shell scripts to automate build, load, deploy, and scale operations

---

## Project Structure

```

react-todo-demo/
├── eks/
│   ├── build.sh                # Builds and pushes the image to AWS ECR
│   ├── common.sh               # Shared variables and functions
│   ├── create-cluster.sh       # Creates an EKS cluster named eks-react-todo
│   ├── delete-cluster.sh       # Deletes the EKS cluster
│   ├── delete.sh               # Deletes the Kubernetes Deployment and Service from EKS
│   ├── deploy.sh               # Deploys the app using todo-deployment.yml and todo-service.yml
│   ├── scale-replica.sh        # Scales the number of replicas on EKS
│   ├── todo-deployment.yml     # Kubernetes Deployment for EKS
│   └── todo-service.yml        # Kubernetes Service (LoadBalancer) for EKS
├── kind/
│   ├── build.sh                # Builds the Docker image and loads it into the local kind cluster
│   ├── common.sh               # Shared variables and functions (e.g., image name, namespace)
│   ├── create-cluster.sh       # Creates a local kind cluster named kind-react-todo
│   ├── delete-cluster.sh       # Deletes the local kind cluster
│   ├── delete.sh               # Deletes the Kubernetes Deployment and Service
│   ├── deploy.sh               # Deploys the app using todo-deployment.yml and todo-service.yml
│   ├── kind-config.yml         # Used for kind cluster config
│   ├── scale-replica.sh        # Scales the number of replicas (e.g., ./scale-replica.sh 2)
│   ├── todo-deployment.yml     # Kubernetes Deployment for kind
│   └── todo-service.yml        # Kubernetes Service (NodePort) for kind
├── public/                     # for React Todo List
├── src/                        # for React Todo List
├── .dockerignore
├── .gitignore
├── Dockerfile
├── package.json
└── README.md

````

---

## Local Development

```bash
npm install
npm start
````

Visit: [http://localhost:3000](http://localhost:3000)

---

## Build & Run with Docker

```bash
docker build -t react-todo-demo:latest .
docker run -p 3000:3000 react-todo-demo:latest
```

---

## Deploy to Local Kubernetes with kind

> Assumes Docker & kind are installed.

### 1. Create Cluster

```bash
sh kind/create-cluster.sh
```

### 2. Build and Load Image

```bash
sh kind/build.sh
```

### 3. Deploy to Cluster

```bash
sh kind/deploy.sh
```

### 4. Scale Replica

```bash
sh kind/scale-replica.sh <replica-count>
```

### 5. Delete App Resources

```bash
sh kind/delete.sh
```

### 6. Delete Cluster

```bash
sh kind/delete-cluster.sh
```

---

## Deploy to AWS EKS

> Make sure your AWS CLI & kubectl are configured for your EKS cluster and your IAM role is in the `aws-auth` ConfigMap.

### 1. Create Cluster

```bash
sh eks/create-cluster.sh
```

### 2. Build and Push Image

```bash
sh eks/build.sh
```

### 3. Deploy to EKS

```bash
sh eks/deploy.sh
```

### 4. Scale Replica

```bash
sh eks/scale-replica.sh <replica-count>
```

### 5. Delete App Resources

```bash
sh eks/delete.sh
```

### 6. Delete Cluster

```bash
sh eks/delete-cluster.sh
```

---

## Useful Commands

```bash
# List pods
kubectl get pods -n default

# View logs
kubectl logs -f <pod-name> -n default

# Port-forward for testing
kubectl port-forward svc/react-todo-service 8080:80 -n default
```

---

## Troubleshooting

* **ImagePullBackOff on kind**: make sure you're loading the image into the kind cluster, not pushing to Docker Hub.
* **Unauthorized on EKS**: check that your IAM role is added to the `aws-auth` ConfigMap with `system:masters` group.
* **Multi-architecture builds**: use `docker buildx build --platform linux/amd64` if running on M1/M2 Mac.
