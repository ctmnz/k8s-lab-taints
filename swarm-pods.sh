number_of_pods=100
for a in $(seq 1 $number_of_pods)
do
cat >pods/pod-$a.yaml <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: pod-ns-${a}
---
apiVersion: v1
kind: Pod
metadata:
  name: busybox-sleep-${a}
  namespace: pod-ns-${a}
spec:
  containers:
  - name: busybox
    image: busybox:1.28
    args:
    - sleep
    - "1000000"
EOF
done
kubectl apply -f pods/

# kubectl delete -f pods/


