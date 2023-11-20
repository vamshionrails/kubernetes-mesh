# kuberentes-mesh
kubernetes mesh

```Shell
vamsh@Chappie MINGW64 /d/Projects/kubernetes-mesh/Clusters/deploy-eks-clusters (main)
$ kind create cluster --config web.yaml 
Creating cluster "web" ...
 • Ensuring node image (kindest/node:v1.27.3) 🖼  ...
 ✓ Ensuring node image (kindest/node:v1.27.3) 🖼
 • Preparing nodes 📦 📦 📦   ...
 ✓ Preparing nodes 📦 📦 📦 
 • Writing configuration 📜  ...
 ✓ Writing configuration 📜
 • Starting control-plane 🕹️  ...
 ✓ Starting control-plane 🕹️
 • Installing StorageClass 💾  ...
 ✓ Installing StorageClass 💾
 • Joining worker nodes 🚜  ...
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-web"
You can now use your cluster with:

kubectl cluster-info --context kind-web

Thanks for using kind! 😊

vamsh@Chappie MINGW64 /d/Projects/kubernetes-mesh/Clusters/deploy-eks-clusters (main)
$ kind create cluster --config management.yaml 
Creating cluster "mgmt" ...
 • Ensuring node image (kindest/node:v1.27.3) 🖼  ...
 ✓ Ensuring node image (kindest/node:v1.27.3) 🖼
 • Preparing nodes 📦 📦 📦   ...
 ✓ Preparing nodes 📦 📦 📦 
 • Writing configuration 📜  ...
 ✓ Writing configuration 📜
 • Starting control-plane 🕹️  ...
 ✓ Starting control-plane 🕹️
 • Installing StorageClass 💾  ...
 ✓ Installing StorageClass 💾
 • Joining worker nodes 🚜  ...
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-mgmt"
You can now use your cluster with:

kubectl cluster-info --context kind-mgmt

Have a nice day! 👋


vamsh@Chappie MINGW64 /d/Projects/kubernetes-mesh/Clusters/deploy-eks-clusters (main)
$ kind get clusters
mgmt
web


```
