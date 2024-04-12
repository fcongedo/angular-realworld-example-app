# Usa una imagen base con Node.js preinstalado
FROM node:20.9.0 AS builder

# Instala Angular CLI globalmente
RUN npm install -g @angular/cli

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos de package.json y package-lock.json al directorio de trabajo
COPY package*.json /app

# Instala las dependencias
RUN npm install

# Copia el resto de los archivos al directorio de trabajo
COPY . /app

# Compila la aplicación en modo producción utilizando --configuration=production
RUN npm run build -- --configuration=production

# Establece la imagen base final
FROM nginx:alpine

# Copia los archivos compilados de la aplicación al directorio de Nginx
COPY --from=builder /app/dist/ /usr/share/nginx/html

# Expone el puerto 80 para que la aplicación esté disponible
EXPOSE 80

# Comando de inicio para Nginx
CMD ["nginx", "-g", "daemon off;"]