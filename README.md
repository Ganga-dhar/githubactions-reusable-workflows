# githubactions-reusable-workflows
# 🛡️ GitHub Actions + Trivy Security Scanning

A hands-on DevSecOps project demonstrating how to integrate **Trivy** into **GitHub Actions** to automatically scan both the **source code (Filesystem)** and **Docker images** for vulnerabilities before deployment.

---

## 📌 Project Overview

This project implements an automated security pipeline using **GitHub Actions** and **Trivy**. Every code push triggers security scans to identify vulnerabilities in:

* Source code dependencies
* Docker images
* Operating system packages
* Application libraries

The workflow is configured to fail when **HIGH** or **CRITICAL** vulnerabilities are detected, helping enforce security gates in CI/CD.

---

## 📁 Project Structure

```text
trivy-demo/
│
├── .github/
│   └── workflows/
│       └── trivy.yml
        └── docker.yml
│
├── Dockerfile
├── app.py
├── requirements.txt
└── README.md
```

---

## 🚀 Features

* GitHub Actions CI pipeline
* Trivy Filesystem (FS) scan
* Trivy Docker Image scan
* Automatic vulnerability detection
* Pipeline fails on HIGH/CRITICAL vulnerabilities
* Easy integration into DevSecOps pipelines

---

## 🔄 Workflow

```text
Developer Push
      │
      ▼
Checkout Repository
      │
      ▼
Filesystem Scan (Trivy)
      │
      ▼
Build Docker Image
      │
      ▼
Docker Image Scan (Trivy)
      │
      ▼
HIGH / CRITICAL Vulnerabilities?
      │
 ┌────┴────┐
 │         │
Yes       No
 │         │
 ▼         ▼
Fail    Continue Pipeline
```

---

## 🔍 Filesystem Scan

The filesystem scan analyzes the repository for vulnerable dependencies.

```yaml
- name: Trivy Filesystem Scan
  uses: aquasecurity/trivy-action@master
  with:
    scan-type: fs
    scan-ref: .
    format: table
    severity: HIGH,CRITICAL
    exit-code: "1"
```

This scan detects vulnerabilities in:

* Python packages
* Node.js packages
* Java dependencies
---

## 🐳 Docker Image Scan

After building the Docker image, Trivy scans it for:

* Base image vulnerabilities
* Operating system packages
* Installed libraries
* Application dependencies

```yaml
- name: Build Docker Image
  run: docker build -t trivy-demo:latest .

- name: Trivy Image Scan
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: trivy-demo:latest
    format: table
    severity: HIGH,CRITICAL
    exit-code: "1"
```

---

## 📊 Sample Pipeline Flow

```text
Push Code
    │
    ▼
Checkout Repository
    │
    ▼
Filesystem Scan
    │
    ▼
Build Docker Image
    │
    ▼
Docker Image Scan
    │
    ▼
Security Gate
    │
 ┌──┴──┐
 │     │
Pass  Fail
 │     │
 ▼     ▼
Deploy Stop Pipeline
```

---

## ⚙️ Configuration

| Parameter   | Description                                     |
| ----------- | ----------------------------------------------- |
| `scan-type` | Filesystem scan (`fs`)                          |
| `scan-ref`  | Directory to scan                               |
| `image-ref` | Docker image to scan                            |
| `severity`  | Vulnerability severity levels                   |
| `exit-code` | Fail workflow when vulnerabilities are detected |
| `format`    | Output format (`table`, `json`, `sarif`)        |

---

## 🚦 Severity Levels

Trivy supports the following severity levels:

* UNKNOWN
* LOW
* MEDIUM
* HIGH
* CRITICAL

Example:

```yaml
severity: HIGH,CRITICAL
```

---

## 📚 Future Enhancements

* Scan Terraform Infrastructure as Code
* Scan Kubernetes manifests
* Upload SARIF reports to GitHub Security
* Push scanned images to Amazon ECR or Docker Hub
* Deploy to Amazon ECS or Amazon EKS after successful scans
* Add Slack or Microsoft Teams notifications for scan results

---
