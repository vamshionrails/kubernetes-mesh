kind-cluster1.yaml:
-------------------

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
 
networking:
  disableDefaultCNI: true
  podSubnet: "10.0.0.0/16"
  serviceSubnet: "10.1.0.0/16"

kind-cluster2.yaml:
-------------------

kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
networking:
  disableDefaultCNI: true
  podSubnet: "10.2.0.0/16"
  serviceSubnet: "10.3.0.0/16"


kind create cluster --name=cluster1 --config=kind-cluster1.yaml --retain -v 1
kind create cluster --name=cluster2 --config=kind-cluster2.yaml --retain -v 1

