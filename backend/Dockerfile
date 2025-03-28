# Utiliser une image Node.js officielle comme base
FROM node:16

# Créer et définir le répertoire de travail
WORKDIR /usr/src/app

# Copier package.json et yarn.lock
COPY package.json yarn.lock ./

# Installer les dépendances
RUN yarn install

# Copier le reste du code source
COPY . .

# Exposer le port sur lequel l'app va tourner
EXPOSE 3000

# Démarrer le serveur Node.js
CMD ["node", "main.js"]
