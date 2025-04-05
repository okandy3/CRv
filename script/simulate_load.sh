#!/bin/bash

# URL du backend (remplace par l'URL correcte de ton backend)
BASE_URL_NODEJS='http://localhost:7000/endpoint'  # Assurez-vous que ce soit le bon point de terminaison pour Node.js
BASE_URL_REDIS='redis://localhost:6379'           # URL pour Redis (si vous avez un service Redis)

# Nombre de requêtes à envoyer
NUM_REQUESTS=1000

# Afficher un message de début
echo "🌐 Simulation de charge sur l'API Node.js et Redis..."

# Boucle pour envoyer les requêtes vers Node.js
for i in $(seq 1 $NUM_REQUESTS)
do
    # Requête GET sur Node.js
    echo "🔍 Requête GET (Node.js) : $i"
    curl -s "$BASE_URL_NODEJS" > /dev/null

    # Requête POST sur Node.js
    echo "📝 Requête POST (Node.js) : $i"
    curl -s -X POST "$BASE_URL_NODEJS" -d '{"key": "value"}' -H "Content-Type: application/json" > /dev/null

    # Requête PUT sur Node.js
    echo "✏️ Requête PUT (Node.js) : $i"
    curl -s -X PUT "$BASE_URL_NODEJS/1" -d '{"key": "updated_value"}' -H "Content-Type: application/json" > /dev/null

    # Requête DELETE sur Node.js
    echo "🗑 Requête DELETE (Node.js) : $i"
    curl -s -X DELETE "$BASE_URL_NODEJS/1" > /dev/null

    # Pause aléatoire entre 0 et 1 seconde pour simuler un comportement utilisateur naturel
    sleep $(echo "scale=2; $RANDOM/32768" | bc)
done

# Simulation de charge pour Redis
echo "🚀 Simulation de charge sur Redis..."

for i in $(seq 1 $NUM_REQUESTS)
do
    # Lecture (GET) sur Redis
    echo "🔍 Requête GET (Redis) : $i"
    curl -s "$BASE_URL_REDIS/endpoint" > /dev/null

    # Création (SET) sur Redis
    echo "📝 Requête SET (Redis) : $i"
    curl -s -X SET "$BASE_URL_REDIS" -d '{"key": "value"}' > /dev/null

    # Mise à jour (SET) sur Redis
    echo "✏️ Requête SET (Redis) : $i"
    curl -s -X SET "$BASE_URL_REDIS" -d '{"key": "updated_value"}' > /dev/null

    # Suppression (DEL) sur Redis
    echo "🗑 Requête DEL (Redis) : $i"
    curl -s -X DEL "$BASE_URL_REDIS" > /dev/null

    # Pause aléatoire entre 0 et 1 seconde pour simuler un comportement utilisateur naturel
    sleep $(echo "scale=2; $RANDOM/32768" | bc)
done

echo "✅ Simulation terminée avec succès !"
