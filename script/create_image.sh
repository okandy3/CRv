#!/bin/bash

# 🚀 Étape 0 : Connexion à Docker Hub
echo "🔐 Connexion à Docker Hub..."
read -p "👤 Docker Hub Username: " DOCKER_USER
read -s -p "🔑 Docker Hub Password: " DOCKER_PASS
echo
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

if [ $? -ne 0 ]; then
  echo "❌ Échec de la connexion à Docker Hub. Vérifie tes identifiants."
  exit 1
fi

# 🚀 Étape 1 : Configuration des variables
K8S_NAMESPACE="default"
BACKEND_IMAGE="arthurescriou/node-redis:1.0.6"
FRONTEND_IMAGE="$DOCKER_USER/my-react-app:latest"
REDIS_IMAGE="redis:latest"

echo "🔹 Namespace Kubernetes : $K8S_NAMESPACE"
echo "🔹 Image Backend : $BACKEND_IMAGE"
echo "🔹 Image Frontend : $FRONTEND_IMAGE"
echo "🔹 Image Redis : $REDIS_IMAGE"

# 🚀 Étape 2 : Téléchargement des images Docker

echo "🐳 Téléchargement de l’image Backend Node.js..."
docker pull $BACKEND_IMAGE

echo "🐳 Construction de l’image Frontend React..."
cd frontend || { echo "❌ Dossier 'frontend' introuvable."; exit 1; }
docker build -t $FRONTEND_IMAGE .
docker push $FRONTEND_IMAGE
cd ..

echo "🐳 Téléchargement de l'image Redis..."
docker pull $REDIS_IMAGE

echo "✅ Images Docker prêtes et poussées sur Docker Hub !"
