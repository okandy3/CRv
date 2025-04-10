#!/bin/bash

# URL des services dans le cluster Kubernetes
BASE_URL_NODEJS='http://backend-service:7000'  # Service Node.js exposé
REDIS_HOST='redis-master-service'                      # Service Redis maître

# Nombre de requêtes à envoyer
NUM_REQUESTS=1000

# Affichage du message de démarrage
echo "🌐 Simulation de charge sur l'API Node.js..."

for i in $(seq 1 $NUM_REQUESTS)
do
    # Requête GET sur Node.js
    echo "🔍 Requête GET / (Node.js) : $i"
    curl -s "$BASE_URL_NODEJS/" > /dev/null

    # Requête POST sur /item de Node.js (création)
    echo "📝 Requête POST /item (Node.js) : $i"
    curl -s -X POST "$BASE_URL_NODEJS/item" \
        -H "Content-Type: application/json" \
        -d '{"id": "test-key", "val": "value"}' > /dev/null

    # Requête DELETE sur /item de Node.js (suppression)
    echo "🗑 Requête DELETE /item (Node.js) : $i"
    curl -s -X DELETE "$BASE_URL_NODEJS/item" \
        -H "Content-Type: application/json" \
        -d '{"id": "test-key"}' > /dev/null

    # Pause aléatoire entre 0 et 1 seconde pour simuler un comportement utilisateur naturel
    sleep $(echo "scale=2; $RANDOM/32768" | bc)
done

echo "🚀 Simulation de charge sur Redis..."

for i in $(seq 1 $NUM_REQUESTS)
do
    # Requête GET sur Redis
    echo "🔍 Requête GET (Redis) : $i"
    redis-cli -h "$REDIS_HOST" -p 6379 GET test-key > /dev/null

    # Requête SET sur Redis
    echo "📝 Requête SET (Redis) : $i"
    redis-cli -h "$REDIS_HOST" -p 6379 SET test-key "value" > /dev/null

    # Mise à jour de la clé dans Redis
    echo "✏️ Requête SET updated (Redis) : $i"
    redis-cli -h "$REDIS_HOST" -p 6379 SET test-key "updated_value" > /dev/null

    # Suppression de la clé dans Redis
    echo "🗑 Requête DEL (Redis) : $i"
    redis-cli -h "$REDIS_HOST" -p 6379 DEL test-key > /dev/null

    # Pause aléatoire entre 0 et 1 seconde pour simuler un comportement utilisateur naturel
    sleep $(echo "scale=2; $RANDOM/32768" | bc)
done

echo "✅ Simulation terminée avec succès !"
