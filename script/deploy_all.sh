#!/bin/bash

# 🚀 Étape 1 : Configuration des variables
DOCKER_IMAGE="mon-dockerhub/redis-node-app:latest"
K8S_NAMESPACE="default"

echo "🔹 Déploiement dans le namespace: $K8S_NAMESPACE"
echo "🔹 Image Docker: $DOCKER_IMAGE"

# 🚀 Étape 2 : Construction et push de l’image Docker
cd nodejs
echo "🐳 Construction de l’image Docker..."
docker build -t $DOCKER_IMAGE .

echo "📤 Pushing de l’image..."
docker push $DOCKER_IMAGE
cd ..

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

echo "🚀 Déploiement du monitoring..."
kubectl apply -f k8s/monitoring/promeu_config.yaml
kubectl apply -f k8s/monitoring/promeu_service.yaml
kubectl apply -f k8s/monitoring/deploy_promeu.yaml
kubectl apply -f k8s/monitoring/deploy_grafana.yaml
kubectl apply -f k8s/monitoring/grafana_service.yaml




echo "📊 Déploiement de l’AutoScaler..."
kubectl apply -f k8s/database/redis_autoscaling.yaml
kubectl apply -f k8s/backend/autoscaling_js.yaml

echo "✅ Déploiement terminé !"
