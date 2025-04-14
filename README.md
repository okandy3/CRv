/projet
├── backend/
│   ├── Dockerfile
│   ├── main.js
│   ├── package.json
│   └── ...
├── frontend/
│   ├── Dockerfile
│   ├── package.json
│   └── ...
├── k8s/
│   ├── namespace.yaml
│   ├── redis-main-deployment.yaml
│   ├── redis-replica-deployment.yaml
│   ├── node-deployment.yaml
│   ├── prometheus-configmap.yaml
│   ├── prometheus-deployment.yaml
│   ├── grafana-deployment.yaml
│   └── hpa-node.yaml
├── loadTest/
│   ├── fetchData.js
│   └── scenario.sh
└── deploy.sh
