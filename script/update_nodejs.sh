#!/bin/bash

# 🚀 Étape 1 : Variables
DOCKER_IMAGE="mon-dockerhub/redis-node-app:latest"  # Image Docker mise à jour
K8S_DEPLOYMENT_NAME="nodejs-app"  # Nom du déploiement à mettre à jour

echo "🔹 Mise à jour de l'image Docker à : $DOCKER_IMAGE"
echo "🔹 Déploiement Kubernetes : $K8S_DEPLOYMENT_NAME"
echo ""

# 🚀 Étape 2 : Construire et pousser la nouvelle image Docker
cd nodejs
echo "🐳 Reconstruction de l’image Docker..."
docker build -t $DOCKER_IMAGE .

echo "📤 Pushing de l’image Docker..."
docker push $DOCKER_IMAGE
cd ..

# 🚀 Étape 3 : Mettre à jour l'image dans le déploiement Kubernetes
echo "🔄 Mise à jour de l’image dans Kubernetes..."

kubectl set image deployment/$K8S_DEPLOYMENT_NAME nodejs=$DOCKER_IMAGE

# 🚀 Étape 4 : Vérifier que le déploiement a été mis à jour
echo "📊 Vérification de l'état du déploiement..."
kubectl rollout status deployment/$K8S_DEPLOYMENT_NAME

echo "✅ Mise à jour terminée !"
