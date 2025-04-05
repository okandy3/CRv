#!/bin/bash

# 🚮 Suppression des ressources Kubernetes
echo "🗑 Suppression des ressources Kubernetes..."
kubectl delete -f k8s/ --ignore-not-found

# 🧹 Suppression des images Docker locales
echo "🧹 Suppression des images Docker locales..."

# (Optionnel) Suppression de l’image Backend si elle est présente localement
echo "🔸 Suppression image Backend (si présente)..."
docker rmi arthurescriou/node-redis:latest -f 2>/dev/null || echo "Image non trouvée en local."

# Suppression de l’image Docker Frontend React
echo "🔸 Suppression image Frontend React..."
docker rmi your-dockerhub-user/react-frontend:latest -f 2>/dev/null || echo "Image non trouvée."

# Suppression de l'image officielle Redis
echo "🔸 Suppression image Redis..."
docker rmi redis:latest -f 2>/dev/null || echo "Image non trouvée."

echo "✅ Suppression terminée avec succès !"
