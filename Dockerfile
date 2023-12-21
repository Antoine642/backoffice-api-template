# Utilisation d'une image Node.js LTS
FROM node:18-alpine AS build

# Définir le répertoire de travail
WORKDIR /app/backoffice

# Copier les fichiers nécessaires
COPY package*.json .
RUN npm install


COPY . .

# Installer les dépendances
RUN npm run build

FROM nginx:alpine

# Copier le reste des fichiers
COPY --from=build /app/backoffice/dist /usr/share/nginx/html

# Exposer le port 8081 (ou le port de votre choix)
EXPOSE 80

# Commande pour lancer le backoffice
CMD ["nginx", "-g", "daemon off;"]
