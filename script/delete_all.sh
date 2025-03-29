#!/bin/bash

# 🚮 Suppression des ressources Kubernetes
echo "🗑 Suppression des ressources Kubernetes..."
kubectl delete -f k8s/

# 🧹 Suppression des images Docker locales
echo "🧹 Suppression des images Docker locales..."

# Suppression de l'image Docker Backend Node.js
docker rmi redis-nodejs-backend:latest -f

# Suppression de l'image Docker Frontend React
docker rmi redis-nodejs-frontend:latest -f

# Suppression de l'image officielle Redis
docker rmi redis:latest -f

echo "✅ Suppression terminée !"
