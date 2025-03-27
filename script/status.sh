#!/bin/bash

echo "📊 Vérification de l’état des ressources Kubernetes..."
echo ""

# Afficher les pods
echo "🔹 Pods en cours d’exécution :"
kubectl get pods -o wide
echo ""

# Afficher les services
echo "🔹 Services exposés :"
kubectl get svc
echo ""

# Afficher l’AutoScaler
echo "🔹 AutoScaler (HPA) :"
kubectl get hpa
echo ""

# Afficher les déploiements
echo "🔹 Déploiements :"
kubectl get deployments
echo ""

# Afficher les réplicas de Redis
echo "🔹 StatefulSets Redis :"
kubectl get statefulsets
echo ""

echo "✅ Vérification terminée !"
