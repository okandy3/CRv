# Utiliser l'image officielle de Node.js pour construire l'app
FROM node:16 AS build

# Créer et définir le répertoire de travail
WORKDIR /app

# Copier package.json et yarn.lock
COPY package.json yarn.lock ./

# Installer les dépendances
RUN yarn install

# Copier tout le code source
COPY . .

# Construire l'application React pour la production
RUN yarn build

# Utiliser une image Nginx pour servir l'app construite
FROM nginx:alpine

# Copier le build de React vers le répertoire de Nginx
COPY --from=build /app/build /usr/share/nginx/html

# Exposer le port 80 pour que Nginx puisse servir l'app
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
