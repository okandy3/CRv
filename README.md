# CRV

# Guide de Mise en Place et Déploiement du Projet
## 📋 Table des matières

## Introduction

Prérequis 

Architecture du Projet

Création des images

Déploiement Kubernetes

Étapes de déploiement

# **Guide de Mise en Place et Déploiement du Projet**

## 📋 **Table des matières**
1. [Introduction](#introduction)
2. [Prérequis](#prérequis)
3. [Architecture du Projet](#architecture-du-projet)
4. [Création des images](#Création-des-images)
5. [Déploiement Kubernetes](#déploiement-kubernetes)
    * [Étapes de déploiement](#étapes-de-déploiement)
6. [Mise en Place de Prometheus et Grafana](#mise-en-place-de-prometheus-et-grafana)
7. [Automatisation via Scripts](#automatisation-via-scripts)


---

## 🛠 **1. Introduction**

Ce projet consiste à déployer une **application stateless Node.js** connectée à une **base de données Redis**, le tout orchestré avec **Kubernetes**. Des outils de **monitoring**, comme **Prometheus** et **Grafana**, seront également mis en place pour surveiller les performances de l'infrastructure.

---

## 🔧 **2. Prérequis**

Avant de commencer le déploiement, assurez-vous d'avoir les outils suivants installés sur votre machine :
- [Docker](https://www.docker.com/products/docker-desktop)
- [Kubernetes (kubectl)](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Minikube](https://minikube.sigs.k8s.io/docs/) ou un cluster Kubernetes fonctionnel
- [Prometheus](https://prometheus.io/docs/introduction/overview/) et [Grafana](https://grafana.com/docs/grafana/latest/getting-started/)

---

## 🏗 **3. Architecture du Projet**

crv  
├── backend  
│   ├── .dockerignore  
│   ├── .gitignore  
│   ├── Dockerfile  
│   ├── main.js  
│   ├── package.json  
│   ├── yarn.lock  
├── frontend  
│   ├── public/  
│   ├── src/  
│   ├── Dockerfile  
│   ├── package.json  
│   └── yarn.lock  
├── k8s  
│   ├── backend  
│   │   ├── autoscaling_js.yaml  
│   │   ├── deploy_js.yaml  
│   │   ├── service_js.yaml  
│   ├── frontend  
│   │   ├── deploy_react.yaml  
│   │   └── react_service.yaml  
│   ├── database  
│   │   ├── redis_autoscaling.yaml  
│   │   ├── redis_master_service.yaml  
│   │   ├── redis_replicas_service.yaml  
│   │   ├── redis_master.yaml  
│   │   ├── redis_replicas.yaml  
│   │    
│   │     
│   ├── monitoring  
│   │   ├── deploy_grafana.yaml  
│   │   ├── deploy_promeu.yaml  
│   │   ├── promeu_config.yaml  
│   │   ├── promeu_service.yaml  
│   │   └── grafana_service.yaml  
├── script  
│   ├── delete_all.sh  
│   ├── deploy_all.sh  
│   ├── scale_test.sh  
│   ├── status.sh  
│   ├── update_nodejs.sh  
├── README.md  

## 4. Création des images 

***Créer l'Image Docker pour le Backend Node.js***

cd crv/backend

docker build -t redis-nodejs-backend:latest .



Vérifier la création de l'image :
docker images

docker push node_js/backend-nodejs:latest

***Créer l'Image Docker pour le Frontend React***

cd crv/frontend

docker build -t redis-nodejs-frontend:latest .


***Créer l'image officielle Redis***

docker pull redis


***Docker depuis Minikube***

eval $(minikube -p minikube docker-env)


## 5. Déploiement Kubernetes
Étapes de déploiement
Voici les étapes pour déployer l'infrastructure Kubernetes à l'aide des fichiers YAML fournis :

Démarrage du Cluster Kubernetes avec Minikube :

minikube start

Vérifiez que Kubernetes fonctionne :

kubectl get nodes

***Déployer le Backend Node.js*** 

Naviguez dans le répertoire k8s/backend/ et déployez le backend avec le fichier deploy_js.yaml 

***commandes :***

kubectl apply -f deploy_js.yaml

kubectl apply -f service_js.yaml

kubectl apply -f autoscaling_js.yaml


***Déployer le Frontend React (non scalé)***

Naviguez dans le répertoire k8s/frontend/ et déployez le frontend.

***commmandes :*** 

kubectl apply -f deploy_react.yaml

kubectl apply -f react_service.yaml



***Déployer Redis avec Autoscaling***

Allez dans le dossier k8s/database/ et appliquez les fichiers de déploiement Redis.

***commandes :*** 

kubectl apply -f redis_master.yaml

kubectl apply -f redis_replicas.yaml

kubectl apply -f redis_master_service.yaml

kubectl apply -f redis_replicas_service.yaml

kubectl apply -f redis_autoscaling.yaml



***Déployer Prometheus et Grafana pour Monitoring***

Allez dans le répertoire k8s/monitoring/ et déployez Prometheus et Grafana.

***commandes :***

kubectl apply -f deploy_promeu.yaml

kubectl apply -f promeu_service.yaml

kubectl apply -f deploy_grafana.yaml

kubectl apply -f grafana_service.yaml


kubectl create namespace monitoring

kubectl apply -f deploy_promeu.yaml -n monitoring

kubectl apply -f promeu_service.yaml -n monitoring



## 6. Mise en Place de Prometheus et Grafana
Prometheus est configuré pour surveiller le backend Node.js et Redis. Le tableau de bord Grafana est pré-configuré pour afficher les données de performance et de scaling.

Accéder à Prometheus :
Après avoir déployé Prometheus, vous pouvez y accéder via son service Kubernetes exposé (en utilisant kubectl port-forward ou en configurant un service de type LoadBalancer).

commande : 
kubectl port-forward svc/prometheus-server 9090:9090

Accédez ensuite à http://localhost:8080 dans votre navigateur.

Accéder à Grafana :
Grafana est déployé avec un tableau de bord de base pour visualiser les métriques.

commande : 
kubectl port-forward svc/grafana 3000:3000

Accédez ensuite à http://localhost:3000 avec les identifiants par défaut :
Username : admin
Password : admin

## 7. Automatisation via Scripts
***Vous avez plusieurs scripts disponibles pour faciliter le déploiement, la mise à l'échelle, et la gestion de votre infrastructure Kubernetes :***

***deploy_all.sh :***
Déploie toutes les ressources nécessaires (backend, frontend, Redis, Prometheus, Grafana).
\
***commande :***
\
chmod +x script/deploy_all.sh
\
./script/deploy_all.sh
\
\
***delete_all.sh :***
Supprime toutes les ressources Kubernetes du cluster.
\
***commande :***
\
chmod +x script/delete_all.sh
\
./script/delete_all.sh
\
\
***scale_test.sh :***
Simule une charge pour tester l’AutoScaling de Redis.
\
***commande :*** 
\
chmod +x script/scale_test.sh
\
./script/scale_test.sh
\
\
***status.sh :***
Affiche l'état des pods, services, et HPA.
\
***commande :***
\
chmod +x script/status.sh
\
./script/status.sh
\
\
***update_nodejs.sh :*** Met à jour l’image Docker de votre serveur Node.js dans Kubernetes.
\
***commande :***
\
chmod +x script/update_nodejs.sh
\
./script/update_nodejs.sh

