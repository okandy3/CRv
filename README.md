### Partipants: Kitoko David et Kandil Omar


Scénarios intéressants
Ressources allouées
Pour obtenir des résultats réalistes et intéressants on veut limiter les ressources de conteneurs. En effet dans le cas de déploiement sur des serveurs dans le cloud ou chez un fournisseurs de machine virtuelle les machines ont rarement autant de ressources que nos ordinateurs.

Par exemple les VM d’aws EC2 de base ont 2 giga de ram et 1 seul CPU. On veut donc limiter de la même manière les ressources données à notre serveur et à sa base à l’aide des conteneur kubernetes.

Charge
L’autre chose que l’on veut simuler c’est l’utilisation de l’application, et donc simuler des utilisateurs qui se connectent et utilise le serveur. Pour ça le plus simple et de créer un script (bash, python ou js) qui lance des requêtes HTTP sur le endpoint du serveur.

Pensez bien à varier les types d’utilisations : Le comportement du serveur et de sa base peuvent varier si les utilisateurs font seulement de la lecture ou si il y a également des écritures en base de données. Pour ça veillez bien à utiliser les différents endpoints du serveur (create, request, update, delete).

Monté à l’échelle
Lorsque que le serveur est beaucoup sollicité il est possible de dupliquer l’instance de pod du serveur. Il est possible de le faire manuellement ou avec une configuration qui l’automatise avec les deploiement kubernetes. (Il est très interessant d’observer quelles conditions d’utilisations déclenchent ce genre de monté à l’échelle automatique).



# Scénarios de Test pour l'Application avec Kubernetes, Redis, Node.js et React

## 1. Architecture du Projet
Le projet déploie une application avec une base de données **Redis** en mode **Master/Replica**, un **Backend Node.js** pour gérer les requêtes API, et un **Frontend React** pour l'interface utilisateur.

Les ressources sont limitées pour simuler des environnements de production. L'auto-scaling est configuré pour adapter le nombre de réplicas du backend et de Redis en fonction de la charge. Le monitoring est mis en place avec **Prometheus** et **Grafana**.

---

## 2. Scénarios de Test

### 2.1 **Limiter les Ressources Allouées aux Conteneurs**
Nous limitons les ressources CPU et mémoire pour chaque composant du projet afin de simuler un environnement de production avec des ressources limitées.

**Commandes :**
- Pour appliquer les ressources limitées, vérifie les fichiers YAML de déploiement dans `k8s/` (comme `redis_master.yaml`, `backend/deploy_backend.yaml`).

Exemple de **backend** avec ressources limitées :
``
resources:
  requests:
    memory: "512Mi"
    cpu: "500m"
  limits:
    memory: "1Gi"
    cpu: "1"


### 2.2 **Simuler la Charge Utilisateur**

Simulation des utilisateurs qui effectuent des actions sur l'application en envoyant des requêtes HTTP sur les différents endpoints (GET, POST, PUT, DELETE).

Exécuter le script pour simuler la charge :
./scripts/simulate_load.sh


### 2.3 **Monter à l’Échelle Automatiquement avec Kubernetes**


Déploiement de l'ensemble de l'application :

./script/deploy_all.sh

Vérifier que Prometheus collecte bien les métriques :

kubectl port-forward svc/prometheus 9090:9090

Accédez ensuite à http://localhost:9090 dans votre navigateur.

kubectl port-forward svc/grafana 3000:3000 

Accède à http://localhost:3000 et connecte-toi avec les identifiants par défaut


Simulation de charge utilisateur : 

./script/simulate_load.sh


Vérification de l'état de l'auto-scaling : 

./script/status.sh
