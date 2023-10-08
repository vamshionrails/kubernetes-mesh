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


 
$ kubectl create ns kubernetes-tools
namespace/kubernetes-tools created


$ helm install kubernetes-dashhboard kubernetes-dashboard/kubernetes-dashboard -n kubernetes-tools
NAME: kubernetes-dashhboard
LAST DEPLOYED: Sun Oct  8 15:22:53 2023
NAMESPACE: kubernetes-tools
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
*********************************************************************************
*** PLEASE BE PATIENT: kubernetes-dashboard may take a few minutes to install ***
*********************************************************************************

Get the Kubernetes Dashboard URL by running:
  export POD_NAME=$(kubectl get pods -n kubernetes-tools -l "app.kubernetes.io/name=kubernetes-dashboard,app.kubernetes.io/instance=kubernetes-dashhboard" -o jsonpath="{.items[0].metadata.name}")
  echo https://127.0.0.1:8443/
  kubectl -n kubernetes-tools port-forward $POD_NAME 8443:8443



$ kubectl logs kubernetes-dashhboard-kubernetes-dashboard-865bcd99d4-5262g -n kubernetes-tools
2023/10/08 20:24:10 Starting overwatch
2023/10/08 20:24:10 Using namespace: kubernetes-tools
2023/10/08 20:24:10 Using in-cluster config to connect to apiserver
2023/10/08 20:24:10 Using secret token for csrf signing
2023/10/08 20:24:10 Initializing csrf token from kubernetes-dashboard-csrf secret
2023/10/08 20:24:10 Empty token. Generating and storing in a secret kubernetes-dashboard-csrf
2023/10/08 20:24:10 Successful initial request to the apiserver, version: v1.28.0
2023/10/08 20:24:10 Generating JWE encryption key
2023/10/08 20:24:10 New synchronizer has been registered: kubernetes-dashboard-key-holder-kubernetes-tools. Starting
2023/10/08 20:24:10 Starting secret synchronizer for kubernetes-dashboard-key-holder in namespace kubernetes-tools
2023/10/08 20:24:10 Initializing JWE encryption key from synchronized object
2023/10/08 20:24:10 no metrics provider selected, will not check metrics.
2023/10/08 20:24:10 Auto-generating certificates
2023/10/08 20:24:10 Successfully created certificates
2023/10/08 20:24:10 Serving securely on HTTPS port: 8443



$ kubectl get pods -n kubernetes-tools
NAME                                                          READY   STATUS    RESTARTS   AGE
kubernetes-dashhboard-kubernetes-dashboard-865bcd99d4-5262g   1/1     Running   0          2m4s



  ```