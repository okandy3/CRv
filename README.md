***Partipants : Kitoko David & Kandil Omar***

# Architecture du projet 

# Architecture du projet

## /projet
- `backend/`
  - `Dockerfile`
  - `main.js`
  - `package.json`
  - ...

- `frontend/`
  - `Dockerfile`
  - `package.json`
  - ...

- `k8s/`
  - `namespace.yaml`
  - `redis-main-deployment.yaml`
  - `redis-replica-deployment.yaml`
  - `node-deployment.yaml`
  - `prometheus-configmap.yaml`
  - `prometheus-deployment.yaml`
  - `grafana-deployment.yaml`
  - `hpa-node.yaml`

- `loadTest/`
  - `fetchData.js`
  - `scenario.sh`

- `deploy.sh`
- `port_forward.sh`
- `status.sh`



# 1️⃣ Démarrer Minikube avec un profil dédié "observabilite"
minikube start --profile observabilite --cpus=2 --memory=4096

# 2️⃣ Vérifier le statut du cluster Minikube
minikube status --profile observabilite

# 3️⃣ Se connecter au contexte Kubernetes "observabilite"
kubectl config use-context observabilite

# 4️⃣ Créer le namespace "observabilite"
kubectl create namespace observabilite

# 5️⃣ Lancer le déploiement complet (Redis, Node.js, Prometheus, Grafana, HPA)
./deploy_all.sh

# 6️⃣ Lancer les port-forward nécessaires (Node.js, Prometheus, Grafana)
./port_forward.sh

# 7️⃣ Lancer les tests de charge
./loadTest/scenario.sh
