#!/bin/bash


# 🚀 Étape 1 : Déploiement Kubernetes

echo "📦 Déploiement Redis (master + replicas + exporter)..."
kubectl apply -f k8s/database/redis_master.yaml
kubectl apply -f k8s/database/redis_master_service.yaml
kubectl apply -f k8s/database/redis_replicas.yaml
kubectl apply -f k8s/database/redis_replicas_service.yaml
kubectl apply -f k8s/database/redis_exporter.yaml
kubectl apply -f k8s/database/redis_exporter_service.yaml

echo "🚀 Déploiement du backend Node.js..."
kubectl apply -f k8s/backend/deploy_backend.yaml
kubectl apply -f k8s/backend/service_backend.yaml

echo "🚀 Déploiement frontend React..."
kubectl apply -f k8s/frontend/deploy_frontend.yaml
kubectl apply -f k8s/frontend/service_frontend.yaml

echo "📊 Déploiement de Prometheus & Grafana..."
kubectl apply -f k8s/monitoring/prometheus_config.yaml
kubectl apply -f k8s/monitoring/deploy_prometheus.yaml
kubectl apply -f k8s/monitoring/prometheus_service.yaml
kubectl apply -f k8s/monitoring/deploy_grafana.yaml
kubectl apply -f k8s/monitoring/grafana_service.yaml

# 🚀 Étape 2 : Auto-scaling
echo "📈 Déploiement des autoscalers..."
kubectl apply -f k8s/database/redis_autoscaling.yaml
kubectl apply -f k8s/backend/autoscaling_backend.yaml

echo "✅ Déploiement complet terminé avec succès ! 🎉"
