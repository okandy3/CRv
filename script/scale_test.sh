#!/bin/bash

echo "🚀 Test de charge sur l'API Node.js..."

# Lancer un pod qui bombarde l’API avec des requêtes
kubectl run load-generator --image=busybox -- /bin/sh -c "while true; do wget -q -O- backend-service; done" &

echo "📊 Suivi du scaling..."
watch kubectl get hpa,pods
