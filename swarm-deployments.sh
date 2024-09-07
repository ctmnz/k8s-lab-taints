number_of_pods=100
for a in $(seq 1 $number_of_pods)
do
cat >deployments/deployment-$a.yaml <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: deployments-ns-${a}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: busybox-sleep-${a}-deployment
  namespace: deployments-ns-${a}
  labels:
    app: busybox-sleep-${a}
spec:
  replicas: 3
  selector:
    matchLabels:
      app: busybox-sleep-${a}
  template:
    metadata:
      labels:
        app: busybox-sleep-${a}
    spec:    
      containers:
      - name: busybox
        image: busybox:1.28
        args:
        - sleep
        - "1000000"
EOF
done
kubectl apply -f deployments/

# kubectl delete -f pods/


