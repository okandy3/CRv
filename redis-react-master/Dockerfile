# Étape 1 : Construire l'application React
FROM node:18 AS builder
WORKDIR /app

# Copier les fichiers de dépendances
COPY package.json yarn.lock ./
RUN yarn install

# Copier le reste des fichiers et construire l'application
COPY . ./
RUN yarn build

# Étape 2 : Servir les fichiers statiques avec Nginx
FROM nginx:latest
COPY --from=builder /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Lancer Nginx
CMD ["nginx", "-g", "daemon off;"]
