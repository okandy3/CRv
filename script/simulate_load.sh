#!/bin/bash

# URL du backend (remplace par l'URL correcte de ton backend)
BASE_URL="http://<TON_BACKEND_URL>"

# Nombre de requêtes à envoyer
NUM_REQUESTS=1000

# Afficher un message de début
echo "🌐 Simulation de charge sur l'API..."

# Boucle pour envoyer les requêtes
for i in $(seq 1 $NUM_REQUESTS)
do
    # Lecture (GET)
    echo "🔍 Requête GET : $i"
    curl -s "$BASE_URL/endpoint" > /dev/null

    # Création (POST)
    echo "📝 Requête POST : $i"
    curl -s -X POST "$BASE_URL/endpoint" -d '{"key": "value"}' -H "Content-Type: application/json" > /dev/null

    # Mise à jour (PUT)
    echo "✏️ Requête PUT : $i"
    curl -s -X PUT "$BASE_URL/endpoint/1" -d '{"key": "updated_value"}' -H "Content-Type: application/json" > /dev/null

    # Suppression (DELETE)
    echo "🗑 Requête DELETE : $i"
    curl -s -X DELETE "$BASE_URL/endpoint/1" > /dev/null

    # Pause aléatoire entre 0 et 1 seconde pour simuler un comportement utilisateur naturel
    sleep $(echo "scale=2; $RANDOM/32768" | bc)
done

echo "✅ Simulation terminée avec succès !"
