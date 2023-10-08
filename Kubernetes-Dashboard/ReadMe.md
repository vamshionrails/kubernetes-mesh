## Kuberenetes Dashboard <a name="lab-01---deploy-eks-clusters-"></a>

![EKS Setup](images/kubernetes-dashboard.png)

* Deploy Kubernetes Dashboard on EKS Cluster

```shell
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
name: kubernetes-tools
nodes:
- role: control-plane
- role: worker
 
```

![EKS Setup](images/kubernetes-dashboard-cluster01.png)

* Add Helm Repo

```shell
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
```
```shell
$ docker pull kindest/node:v1.28.0@sha256:b7a4cad12c197af3ba43202d3efe03246b3f0793f162afb40a33c923952d5b31
$ docker.io/kindest/node@sha256:b7a4cad12c197af3ba43202d3efe03246b3f0793f162afb40a33c923952d5b31: Pulling from kindest/node
```
```shell
$ $ kind create cluster --config cluster.yaml --image kindest/node:v1.28.0@sha256:b7a4cad12c197af3ba43202d3efe03246b3f0793f162afb40a33c923952d5b31
Creating cluster "kubernetes-tools" ...
 ✓ Ensuring node image (kindest/node:v1.28.0) 🖼
 ✓ Preparing nodes 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-kubernetes-tools"
You can now use your cluster with:

kubectl cluster-info --context kind-kubernetes-tools

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/

```
```shell
 
$ kubectl create ns kubernetes-tools
namespace/kubernetes-tools created

```
```shell

$helm repo list
NAME                    URL
kubernetes-dashboard    https://kubernetes.github.io/dashboard/
devtron                 https://helm.devtron.ai
nginx-stable            https://helm.nginx.com/stable
ingress-nginx           https://kubernetes.github.io/ingress-nginx
metallb                 https://metallb.github.io/metallb
grafana                 https://grafana.github.io/helm-charts
cilium                  https://helm.cilium.io/
gloo-platform           https://storage.googleapis.com/gloo-platform/helm-charts
eks                     https://aws.github.io/eks-charts

$helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

$   helm install dashboard kubernetes-dashboard/kubernetes-dashboard -n kubernetes-dashboard --create-namespace
NAME: dashboard
LAST DEPLOYED: Sun Oct  8 16:25:21 2023
NAMESPACE: kubernetes-dashboard
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
*********************************************************************************
*** PLEASE BE PATIENT: kubernetes-dashboard may take a few minutes to install ***
*********************************************************************************

Get the Kubernetes Dashboard URL by running:
  export POD_NAME=$(kubectl get pods -n kubernetes-dashboard -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=dashboard" -o jsonpath="{.items[0].metadata.name}")
  echo https://127.0.0.1:8443/
  kubectl -n kubernetes-dashboard port-forward $POD_NAME 8443:8443
```
```shell

$ kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'
Starting to serve on [::]:8001

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:dashboard-kubernetes-dashboard:https/proxy/#/login

```
![EKS Setup](images/login.png)

```shell
![EKS Setup](images/login.png)

Serviceaccount.yaml
==================

apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kubernetes-dashboard
---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kubernetes-dashboard


  $ kubectl apply -f service-account.yaml 
serviceaccount/admin-user created
clusterrolebinding.rbac.authorization.k8s.io/admin-user created

$ kubectl -n kubernetes-dashboard create token admin-user
eyJhbGciOiJSUzI1NiIsImtpZCI6IlFvXzVES2JlR1BkUWpLdUI5bjQtVE9NT2ticTc5WDdtcWo4ZnZEd0p5MDAifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiXSwiZXhwIjoxNjk2ODA0NDIyLCJpYXQiOjE2OTY4MDA4MjIsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJrdWJlcm5ldGVzLWRhc2hib2FyZCIsInNlcnZpY2VhY2NvdW50Ijp7Im5hbWUiOiJhZG1pbi11c2VyIiwidWlkIjoiMDcwNjRjNzAtYjk0NC00MDNjLWE3ZjAtMGNkYzYxOWEzNTkzIn19LCJuYmYiOjE2OTY4MDA4MjIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlcm5ldGVzLWRhc2hib2FyZDphZG1pbi11c2VyIn0.EUh0ykAnFdMeAtaXcPHS4GeILoCDuXw4fYmyDN7PONQydnL0e9kRQD15Bvn60pXhyYD1gQ9JX0EwgkUHxhcSEgtWgAO9dUuX_xn0SNQmG04AalhSdfMTPoa5AimKd748aS2VTkNNWok0wsyPNImvnE_YndVGskhDQvux4VE_Nh5YtPSwfdLayWvpNt67PLeKh8pVf3__lRPJJB-BlpzErZzWt5e7jaZ7QlbPQpROSp-ZRgHVbDqElqFvMVuzKvj8dvupc6Aa_iyQMKz6TVk87du3mg-WmHmLm6cCak0hEQAOYJgiTaqGg5_ZQXTijUznTPYvbYnlohk0ozecJTcAyA
```
![EKS Setup](images/Screenshot 2023-10-08 163437.png)
```shell



  ```