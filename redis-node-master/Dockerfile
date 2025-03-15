# Étape 1 : Utiliser l'image officielle Node.js comme base
FROM node:18

# Étape 2 : Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Étape 3 : Copier les fichiers de configuration des dépendances
COPY package.json yarn.lock ./

# Étape 4 : Installer les dépendances
RUN yarn install

# Étape 5 : Copier tous les fichiers du projet dans le conteneur
COPY . ./

# Étape 6 : Exposer le port du serveur (si tu écoutes sur le port 3000)
EXPOSE 3000

# Étape 7 : Démarrer le serveur avec `node main.js`
CMD ["yarn", "start"]  
