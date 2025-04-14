#!/bin/bash

# VARIABLES — à adapter si besoin
NAMESPACE=observabilite
BACKEND_IMAGE=mon-backend-node
FRONTEND_IMAGE=mon-frontend-react
URL=http://localhost:3001

echo "== 📦 BUILD DES IMAGES =="
# Backend
docker build -t $BACKEND_IMAGE ./backend

# Frontend
docker build -t $FRONTEND_IMAGE ./frontend

echo "✅ IMAGES CONSTRUITES"

# Si tu veux les pusher sur Docker Hub :
# docker tag $BACKEND_IMAGE tonuser/$BACKEND_IMAGE
# docker tag $FRONTEND_IMAGE tonuser/$FRONTEND_IMAGE
# docker push tonuser/$BACKEND_IMAGE
# docker push tonuser/$FRONTEND_IMAGE

echo "== 📤 DEPLOIEMENT DANS KUBERNETES =="

# Créer le namespace si non existant
kubectl get namespace $NAMESPACE >/dev/null 2>&1 || kubectl create namespace $NAMESPACE

# Appliquer les manifestes
kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/redis-main-deployment.yaml
kubectl apply -f k8s/redis-replica-deployment.yaml
kubectl apply -f k8s/node-deployment.yaml
kubectl apply -f k8s/prometheus-configmap.yaml
kubectl apply -f k8s/prometheus-deployment.yaml
kubectl apply -f k8s/grafana-deployment.yaml
kubectl apply -f k8s/hpa-node.yaml

echo "✅ DEPLOIEMENT TERMINÉ"

echo "== 🕒 PATIENCE : Attente des pods prêts =="
kubectl wait --for=condition=available --timeout=180s deployment --all -n $NAMESPACE

echo "✅ TOUS LES PODS SONT PRÊTS"

echo "== 🧪 LANCEMENT DES TESTS DE CHARGE =="

# Lancer les tests de charge (adapter l'URL si nécessaire)
cd loadTest
./scenario.sh $URL

echo "✅ TESTS TERMINÉS"

echo "== ✅ TOUT EST FAIT ✅ =="
