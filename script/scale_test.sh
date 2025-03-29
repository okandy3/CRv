#!/bin/bash

echo "🚀 Test de charge sur l'API Node.js et Redis..."

# Lancer un pod qui bombarde l'API Node.js avec des requêtes HTTP
kubectl run load-generator-nodejs --image=busybox -- /bin/sh -c "while true; do wget -q -O- backend-service; done" &

# Lancer un pod qui bombarde Redis avec des requêtes
kubectl run load-generator-redis --image=busybox -- /bin/sh -c "while true; do wget -q -O- redis-master-service:6379; done" &

echo "📊 Suivi du scaling de Redis et du Node.js..."
watch "kubectl get hpa,pods,svc"
