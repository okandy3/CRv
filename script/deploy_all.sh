#!/bin/bash

# 🚀 Étape 1 : Configuration des variables
K8S_NAMESPACE="default"
BACKEND_IMAGE="redis-nodejs-backend:latest"
FRONTEND_IMAGE="redis-nodejs-frontend:latest"
REDIS_IMAGE="redis:latest"

echo "🔹 Déploiement dans le namespace: $K8S_NAMESPACE"
echo "🔹 Image Backend: $BACKEND_IMAGE"
echo "🔹 Image Frontend: $FRONTEND_IMAGE"
echo "🔹 Image Redis: $REDIS_IMAGE"

# 🚀 Étape 2 : Construction des images Docker

# Construction de l’image Docker pour le Backend Node.js
cd backend
echo "🐳 Construction de l’image Docker pour le Backend Node.js..."
docker build -t $BACKEND_IMAGE .
cd ..

# Construction de l’image Docker pour le Frontend React
cd frontend
echo "🐳 Construction de l’image Docker pour le Frontend React..."
docker build -t $FRONTEND_IMAGE .
cd ..

# Télécharger l'image officielle de Redis
echo "🐳 Téléchargement de l'image officielle Redis..."
docker pull $REDIS_IMAGE

# 🚀 Étape 3 : Déploiement des ressources Kubernetes
echo "📦 Déploiement de Redis..."
kubectl apply -f k8s/database/redis_master.yaml
kubectl apply -f k8s/database/redis_replicas.yaml
kubectl apply -f k8s/database/redis_master_service.yaml
kubectl apply -f k8s/database/redis_replicas_service.yaml

echo "🚀 Déploiement du serveur Node.js..."
kubectl apply -f k8s/backend/deploy_js.yaml
kubectl apply -f k8s/backend/service_js.yaml

echo "🚀 Déploiement du framework React..."
kubectl apply -f k8s/frontend/deploy_react.yaml
kubectl apply -f k8s/frontend/service_react.yaml

echo "🚀 Déploiement du monitoring avec Prometheus et Grafana..."
kubectl apply -f k8s/monitoring/promeu_config.yaml
kubectl apply -f k8s/monitoring/promeu_service.yaml
kubectl apply -f k8s/monitoring/deploy_promeu.yaml
kubectl apply -f k8s/monitoring/deploy_grafana.yaml
kubectl apply -f k8s/monitoring/grafana_service.yaml

# 🚀 Étape 4 : Déploiement des AutoScalers
echo "📊 Déploiement de l'AutoScaler..."
kubectl apply -f k8s/database/redis_autoscaling.yaml
kubectl apply -f k8s/backend/autoscaling_js.yaml

echo "✅ Déploiement terminé !"
