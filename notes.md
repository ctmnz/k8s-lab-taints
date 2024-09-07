## Taint nodes

# Build kind cluster
task b

# Add taint with NoSchedule
kubectl taint nodes quick-cluster-worker nginx-node=true:NoSchedule

# Add tain with NoExecute (will evict all the pods)
kubectl taint nodes quick-cluster-worker nginx-node=true:NoExecute

# Remove taint
kubectl taint nodes quick-cluster-worker nginx-node=true:NoSchedule-

# Check taints in the nodes
kubectl get nodes -o json | jq '.items[].spec.taints'

# Experiment 01

## Create few services
./swarm-services

## Taint a node with NoExecute (this will evict all the pods from the node)
kubectl taint nodes quick-cluster-worker nginx-node=true:NoExecute

## Wait until the node is empty from pods and remove the taint
kubectl taint nodes quick-cluster-worker nginx-node=true:NoExecute-

## How do we rebalance the pods now?












# Destroy kind cluster
task d




