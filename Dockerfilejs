# Utilisation d'une image Node.js
FROM node:18-alpine

# Définition du dossier de travail
WORKDIR /app

# Copie des fichiers nécessaires
COPY package.json package-lock.json ./
RUN npm install

# Copie du reste du code source
COPY . .

# Exposition du port 3000
EXPOSE 3000

# Commande de démarrage
CMD ["node", "server.js"]
