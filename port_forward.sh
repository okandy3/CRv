#!/bin/bash

NAMESPACE=observabilite

echo "Port-forward node-redis (port 8080)"
kubectl port-forward service/node-redis 8080:8080 -n $NAMESPACE &
REDIS_PID=$!

echo "Port-forward Prometheus (port 9090)"
kubectl port-forward service/prometheus 9090:9090 -n $NAMESPACE &
PROM_PID=$!

echo "Port-forward Grafana (port 3000)"
kubectl port-forward service/grafana 3000:3000 -n $NAMESPACE &
GRAFANA_PID=$!

echo "Ports forwards en cours. PIDs : $REDIS_PID $PROM_PID $GRAFANA_PID"
wait
