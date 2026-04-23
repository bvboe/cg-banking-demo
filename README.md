# Chainguard Banking Demo

A demo showing the value of running Chainguard images.

This demo leverages a banking application running on the following Docker images:
- banking-app - Node-based UI
- banking-worker - Python-based service
- banking-postgres - Database running Postgres

The repository contains two branches: v1, which deploys the application using public images from Docker Hub, and v2, running on images from Chainguard. We're going to deploy the application on Kubernetes using Kind, use a scanner to identify the applications' vulnerabilities, upgrade to v2, and see how that changes. In addition to that, we'll also review the changes made to accommodate this migration.

## Demo pre-requisites
- kind - https://kind.sigs.k8s.io/
- chainctl with access to chainguard-private

## Demo flow
Setup kind Kubernetes cluster
```
$ kind create cluster
```

Download the v1 and v2 branches to separate directories
```
$ git clone -b v1 https://github.com/bvboe/cg-banking-demo v1
$ git clone -b v2 https://github.com/bvboe/cg-banking-demo v2
```

Deploy the vulnerability scanner
```
$ v1/scanner-deploy.sh
```

Build the containers for v1 and v2
```
$ v1/build.sh
$ v2/build.sh
```

Deploy v1
```
$ v1/deploy.sh
```

Open a port forward to view the scanner dashboard and the current state of the application
```
kubectl --namespace b2sv2 port-forward svc/bjorn2scan 8080:80
```

Open http://localhost:8080/images.html?namespaces=banking-demo in your browser.
<img width="1606" height="694" alt="image" src="https://github.com/user-attachments/assets/d2a57a12-ef2b-448c-a68d-2183a3fd1dd6" />
Note that the current images have over 2,600 CVEs, including 37 critical ones.

Let's deploy the Chainguard version, which is in the v2 folder
```
$ v2/deploy.sh
```

Go back to http://localhost:8080/images.html?namespaces=banking-demo in your browser and see how the numbers change.
<img width="1606" height="694" alt="image" src="https://github.com/user-attachments/assets/35d1b42c-d4a6-4aff-bdcd-d35b5f0e831e" />

We're now down to 11 CVEs(!).

The migration to Chainguard images was done using a pull request that can be found at the following location:
https://github.com/bvboe/cg-banking-demo/pull/1/changes
