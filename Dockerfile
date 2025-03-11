
FROM node:18

WORKDIR /app

# Copier uniquement les fichiers nécessaires pour optimiser le cache
COPY redis-node-master/package.json redis-node-master/package.json ./
RUN npm install --legacy-peer-deps


# Copier le reste des fichiers du backend
COPY redis-node-master .

# Configurer l'URL de Redis
ENV REDIS_URL=redis://my-redis:6379

CMD ["node", "main.js"]
EXPOSE 3000
