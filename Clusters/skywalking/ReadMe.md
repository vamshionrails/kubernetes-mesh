# kuberentes-mesh
kubernetes mesh

```Shell

vamsh@Chappie MINGW64 /d/Projects/kubernetes-mesh/Clusters/deploy-eks-clusters (main)
$ kind create cluster --name apache-skywalking --config skywalking-cluster.yaml

 ```


```Shell

banayandb
---------

export REPO=chart
git clone https://github.com/apache/skywalking-banyandb-helm
cd skywalking-banyandb-helm
helm install banyandb ${REPO} -n apache-skywalking --create-namespace


export SKYWALKING_RELEASE_VERSION=4.3.0  # change the release version according to your need
export SKYWALKING_RELEASE_NAME=skywalking  # change the release name according to your scenario
export SKYWALKING_RELEASE_NAMESPACE=apache-skywalking  # change the namespace to where you want to install SkyWalking
 

$ export REPO=skywalking

vamsh@Chappie MINGW64 /d/Projects/kubernetes-mesh/helmcharts (main)
$ helm repo add ${REPO} https://apache.jfrog.io/artifactory/skywalking-helm
"skywalking" has been added to your repositories

$ helm repo add elastic https://helm.elastic.co
"elastic" has been added to your repositories

$ kubectl create ns apache-skywalking
namespace/apache-skywalking created

export REPO=chart
git clone https://github.com/apache/skywalking-helm
cd skywalking-helm
helm install "${SKYWALKING_RELEASE_NAME}" \
  ${REPO}/skywalking \
  -n "${SKYWALKING_RELEASE_NAMESPACE}" \
  --set oap.image.tag=9.5.0 \
  --set oap.storageType=postgresql \
  --set ui.image.tag=9.5.0 \
  --set elasticsearch.enabled=false \
  --set banyandb.enabled=true 


 echo "Visit http://127.0.0.1:8080 to use your application"
  kubectl port-forward svc/skywalking-ui 8080:80 --namespace apache-skywalking

helm install my-postgresql bitnami/postgresql --version 13.2.9 -n postgresql --create-namespace


$ kind create cluster --config skywalking-cluster.yaml --name apache-skywalking
Creating cluster "apache-skywalking" ...
 ✓ Ensuring node image (kindest/node:v1.27.3) 🖼
 ✓ Preparing nodes 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-apache-skywalking"
You can now use your cluster with:

kubectl cluster-info --context kind-apache-skywalking

Thanks for using kind! 😊


helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/

 helm install dashboard kubernetes-dashboard/kubernetes-dashboard -n kubernetes-dashboard --create-namespace

 kubectl apply -f service-account.yaml
        serviceaccount/admin-user created
        clusterrolebinding.rbac.authorization.k8s.io/admin-user created

  kubectl -n kubernetes-dashboard create token admin-user

 kubectl proxy --address='0.0.0.0' --accept-hosts='^*$'

 ```