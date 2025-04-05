# Étape 1 : Construction de l'application React
FROM node:16-alpine AS build

WORKDIR /app
COPY . .

RUN yarn install
RUN yarn build

# Étape 2 : Serveur pour l'application React
FROM nginx:alpine

# Copie les fichiers construits par React
COPY --from=build /app/build /usr/share/nginx/html

# Expose le port 80
EXPOSE 80

# Démarre le serveur Nginx pour servir les fichiers statiques
CMD ["nginx", "-g", "daemon off;"]
