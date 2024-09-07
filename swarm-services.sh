number_of_pods=100
for a in $(seq 1 $number_of_pods)
do
cat >services/service-$a.yaml <<EOF
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
      - name: nginx
        image: nginx:latest
        ports:
          - containerPort: 80
            name: http-web-svc
---
apiVersion: v1
kind: Service
metadata:
  name: busybox-sleep-${a}-service
  namespace: deployments-ns-${a}
spec:
  selector:
    app: busybox-sleep-${a}
  ports:
  - name: name-of-service-port
    protocol: TCP
    port: 80
    targetPort: http-web-svc
EOF
done
kubectl apply -f services/

# kubectl delete -f pods/


