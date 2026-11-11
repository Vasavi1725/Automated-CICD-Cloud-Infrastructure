# Automated CI/CD Pipeline on Cloud Infrastructure — Demo

This is a **small learning/demo scaffold** based on the project architecture in the internship report. It is not evidence that a production AWS deployment was completed.

## Architecture

GitHub repository → GitHub Actions (test + Docker build) → Docker image  
Terraform → AWS ECR repository (optional cloud resource)  
Kubernetes manifests → deployment + service + health probes

## 1. Run the application locally (Windows)

1. Install Python 3.12 or later.
2. Open this folder in VS Code.
3. Open Terminal in VS Code.
4. Create and activate a virtual environment:

   ```powershell
   py -m venv .venv
   .\.venv\Scripts\Activate.ps1
   ```

5. Install packages and run tests:

   ```powershell
   pip install -r requirements.txt
   pytest -q
   ```

6. Start the web app:

   ```powershell
   python app.py
   ```

7. Open these URLs in your browser:
   - http://127.0.0.1:5000/
   - http://127.0.0.1:5000/health

Expected health response: `{"status":"ok","version":"local-demo"}`

## 2. Optional Docker demonstration

Install and start Docker Desktop, then run:

```powershell
docker build -t cicd-cloud-demo:local .
docker run --rm -p 5000:5000 cicd-cloud-demo:local
```

Open http://127.0.0.1:5000/health.

## 3. Optional GitHub Actions demonstration

Create a new GitHub repository, upload these files, and push to the `main` branch. Open the repository's **Actions** tab. The workflow runs tests and builds the Docker image. This demo workflow does not push to AWS or deploy to a live cluster.

## 4. Optional Kubernetes configuration

The manifests are illustrative and expect an image named `cicd-cloud-demo:local` to be available to your Kubernetes cluster.

```powershell
kubectl apply -f k8s/
kubectl get deployments
kubectl get services
```

Only run these commands if you have a working local Kubernetes cluster and have loaded the image into it.

## 5. Optional Terraform / AWS ECR

This creates a real AWS ECR repository and may incur charges for related AWS usage. Do not run unless you have an AWS account, configured credentials, and permission to create resources.

```powershell
cd terraform
terraform init
terraform validate
terraform plan
```

Review the plan. `terraform apply` is intentionally not included in the basic demo instructions.

## Viva explanation

"When code is pushed to GitHub, GitHub Actions runs the automated tests. If the tests pass, it builds a Docker image. Docker packages the application with its dependencies. Terraform can provision cloud resources such as an ECR image repository. Kubernetes manifests describe how the application should run, including replicas and health checks. This reduces repetitive manual work and makes releases more consistent."

## Be honest in the external

You can demonstrate the local Flask app and tests after running them. GitHub Actions runs only after you push the files to your own repository. Docker, Kubernetes and AWS parts require their respective tools/accounts. Do not say a live AWS/Kubernetes production deployment was completed unless you actually perform and verify it.
