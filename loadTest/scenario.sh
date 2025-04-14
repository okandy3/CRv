#!/bin/bash

URL=${1:-http://localhost:8080}

echo "== DÉMARRAGE DES TESTS SUR $URL =="

echo "Test 1 : Only Server Test"
node fetchData.js server 10000 100

echo "Test 2 : Write and Read"
node fetchData.js writeRead 10000 100

echo "Test 3 : Open Pending Connections"
node fetchData.js pending 200 10000

echo "== TESTS TERMINÉS =="
