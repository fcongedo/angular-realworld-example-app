# Usa una imagen base con Node.js preinstalado
FROM node:20.9.0 AS builder

# Instala Angular CLI globalmente
RUN npm install -g @angular/cli

# Establece el directorio de trabajo en /app
WORKDIR /app

# Copia los archivos de package.json y yarn.lock al directorio de trabajo
COPY package.json package-lock.json /app/

# Instala las dependencias utilizando Yarn
RUN yarn install

# Copia el resto de los archivos al directorio de trabajo
COPY . .

# Compila la aplicación en modo producción utilizando --configuration=production
RUN ng build --configuration=production

# Establece la imagen base final
FROM nginx:alpine

# Elimina los archivos de la configuración predeterminada de Nginx
RUN rm -rf /usr/share/nginx/html/*

# Copia los archivos compilados de la aplicación al directorio de Nginx
COPY --from=builder /app/dist /usr/share/nginx/html

# Expone el puerto 80 para que la aplicación esté disponible
EXPOSE 80

# Comando de inicio para Nginx
CMD ["nginx", "-g", "daemon off;"]
