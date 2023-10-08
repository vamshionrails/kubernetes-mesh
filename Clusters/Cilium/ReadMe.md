helm repo add cilium https://helm.cilium.io/
docker pull quay.io/cilium/cilium:v1.14.2

kind load docker-image quay.io/cilium/cilium:v1.14.2 --name cluster1
kind load docker-image quay.io/cilium/cilium:v1.14.2 --name cluster2

helm install cilium cilium/cilium \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set ipam.mode=kubernetes

$docker exec cluster2-control-plane ls -al /proc/self/ns/cgroup
lrwxrwxrwx 1 root root 0 Oct  7 18:11 /proc/self/ns/cgroup -> cgroup:[4026533372]

$ docker exec cluster1-control-plane ls -al /proc/self/ns/cgroup
lrwxrwxrwx 1 root root 0 Oct  7 18:12 /proc/self/ns/cgroup -> cgroup:[4026534152]

$ docker exec cluster2-worker ls -al /proc/self/ns/cgroup
lrwxrwxrwx 1 root root 0 Oct  7 18:13 /proc/self/ns/cgroup -> cgroup:[4026533370]

$docker exec cluster1-worker ls -al /proc/self/ns/cgroup
lrwxrwxrwx 1 root root 0 Oct  7 18:13 /proc/self/ns/cgroup -> cgroup:[4026533930]



kubectl cluster-info --context kind-cluster2 --retain -v 1


helm install cilium cilium/cilium \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set ipam.mode=kubernetes


kubectl cluster-info --context kind-cluster1 --retain -v 1


helm install cilium cilium/cilium \
   --namespace kube-system \
   --set image.pullPolicy=IfNotPresent \
   --set ipam.mode=kubernetes


   Restart cluster
   ----------------

   for ns in $(kubectl get ns -o jsonpath='{.items[*].metadata.name}'); do
     ceps=$(kubectl -n "${ns}" get cep \
         -o jsonpath='{.items[*].metadata.name}')
     pods=$(kubectl -n "${ns}" get pod \
         -o custom-columns=NAME:.metadata.name,NETWORK:.spec.hostNetwork \
         | grep -E '\s(<none>|false)' | awk '{print $1}' | tr '\n' ' ')
     ncep=$(echo "${pods} ${ceps}" | tr ' ' '\n' | sort | uniq -u | paste -s -d ' ' -)
     for pod in $(echo $ncep); do
       echo "${ns}/${pod}";
     done
done


cilium upgrade
-----------------------------

helm upgrade cilium cilium/cilium  \
	--namespace kube-system \
	--set operator.replicas=1 \
	--set kubeProxyReplacement=strict \
	--set k8sServiceHost=127.0.0.1 \
	--set k8sServicePort=6443 \
	--set ingressController.enabled=true \
	--set ingressController.loadbalancerMode=shared \
	--set bgpControlPlane.enabled=true \
	--set operator.replicas=1 \
	--set routingMode=native \
	--set enableIPv4Masquerade=false \
	--set enableIPv6Masquerade=false \
	--set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true \
  --set hubble.tls.auto.enabled=true \
  --set hubble.tls.server.cert=false \
  --set hubble.tls.auto.method=helm


    =====================================


    helm upgrade --install --namespace kube-system --repo https://helm.cilium.io cilium cilium --values - <<EOF
kubeProxyReplacement: strict
k8sServiceHost: cluster2-control-plane # use master node in kind network
k8sServicePort: 6443               # use api server port
hostServices:
  enabled: false
externalIPs:
  enabled: true
nodePort:
  enabled: true
hostPort:
  enabled: true
image:
  pullPolicy: IfNotPresent
ipam:
  mode: kubernetes
hubble:
  enabled: true
  relay:
    enabled: true
EOF

============================================

helm upgrade --install --namespace kube-system --repo https://helm.cilium.io cilium cilium --values - <<EOF
kubeProxyReplacement: strict
k8sServiceHost: cluster2-control-plane
k8sServicePort: 6443
hostServices:
  enabled: false
externalIPs:
  enabled: true
nodePort:
  enabled: true
hostPort:
  enabled: true
image:
  pullPolicy: IfNotPresent
ipam:
  mode: kubernetes
hubble:
  enabled: true
  relay:
    enabled: true
  ui:
    enabled: true
    ingress:
      enabled: true
      annotations:
        kubernetes.io/ingress.class: nginx
      hosts:
        - hubble-ui.127.0.0.1.nip.io
EOF



helm upgrade cilium cilium/cilium  \
	--namespace kube-system \
	--set operator.replicas=1 \
	--set kubeProxyReplacement=strict \    
	--set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true \
  --set hubble.tls.auto.enabled=true \
  --set hubble.tls.server.cert=false \
  --set hubble.tls.auto.method=helm