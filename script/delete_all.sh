#!/bin/bash

echo "🗑 Suppression des ressources Kubernetes..."
kubectl delete -f k8s/

echo "🧹 Suppression de l’image Docker locale..."
docker rmi mon-dockerhub/redis-node-app:latest -f

echo "✅ Suppression terminée !"
