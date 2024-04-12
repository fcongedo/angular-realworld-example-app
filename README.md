## Paso 0: Instalación de Herramientas/Entorno de trabajo 

 Este `README` proporciona instrucciones básicas para la instalación de herramientas necesarias y la configuración de una máquina virtual con Vagrant con las herramientas necesarias para el desafio (docker, minikube, kubectl)

## Configuración de Vagrant :

En el directorio de tu proyecto, encontrarás una carpeta llamada "Vagrant". Esta carpeta contiene la configuración necesaria para levantar una máquina virtual.

1. **Iniciar la Máquina Virtual**: Ejecuta el siguiente comando dentro del directorio "Vagrant":
   ```bash
   vagrant up
   ```
2. **Conexión SSH**:  Para conectarte a la máquina virtual por SSH, utiliza el siguiente comando:
   ```bash
   vagrant ssh
   ```
3. **Túnel a la Máquina Host**: Puedes crear un túnel desde la máquina virtual a tu máquina host para acceder a servicios que se ejecuten en la VM desde el host. Utiliza el siguiente comando para configurar el túnel:
   ```bash
   vagrant ssh -- -L 8080:localhost:80
   ```

## Paso 1: Dockerfile

 Para construir la imagen de docker podremos hacerlo de forma manual descargando el codigo y haciendo un docker build o utilizar la github action ya configurada para que en cada cambio que hagamos en algun archivo del directorio Docker, se ejecute y haga el proceso de construir la imagen y subirla a dockerhub, es importante haber activado Github Actions y configurado los secretos para subir la imagen a dockerhub.

## Uso de docker

1. **Primero debemos descargar la imagen manualmente**: Para descargar la imagen alojada en un repositorio de dockerhub, debemos ejecutar el siguiente comando:
   ```bash
   docker pull fcongedo/app-angular:2
   ```
   
2. **Crear la Imagen de Docker Manualmente**:Para crear una imagen de Docker de manera manual, ejecuta el siguiente comando, que mapea el puerto 80 de la máquina virtual al puerto  del contenedor. Asegúrate de cambiar los nombres y versiones según tu configuración:
   ```bash
   docker run -d -p 80:80 fcongedo/app-angular:2 
   ```

3. **Crear la Imagen de Docker con Docker Compose**: Dirígete al directorio /angular-realworld-example-app/Docker-compose en la máquina virtual y ejecuta el siguiente comando para crear la imagen utilizando Docker Compose
   ```bash
   docker compose up -d
   ```
4. **Verificar su funcionamiento**: utilizando un tunel de vagrant o desde curl localhost:8080
   ```bash
   vagrant ssh -- -L 8080:localhost:80
   ```

## Paso 2: Kubernetes

0. **Iniciar Minikube:** Ejecuta el siguiente comando para iniciar minikube:

   ```bash
   minikube start
   ```
 Para este paso es tan simple como verificar estar conectados a nuestro cluster de kubernetes (poder ejecutar un kubectl get pods -A sin errores) y asi crear nuestros recursos dentro del directorio Kubernetes con el siguiente comando (asegurarse de estar dentro del directorio angular-realworld-example-app):

1. **Crear Recursos en Kubernetes:** Asegúrate de estar dentro del directorio `angular-realworld-example-app` y ejecuta:
    ```bash
    kubectl apply -f Kubernetes/ns.yaml
    kubectl apply -f Kubernetes/deployment.yaml
    ```

2. **Exponer la Aplicación:** Utiliza port-forward para exponer la aplicación:
    ```bash
    kubectl port-forward deployment/app-angular 8080:80 -n prueba-angular
    ```

3. **Verificar su funcionamiento**: utilizando un tunel de vagrant o desde curl localhost:80 (el tunel recordar hacerlo desde otra terminal de vagrant)

   ```bash
   vagrant ssh -- -L 80:localhost:8080
   ```


## Readme de la aplicacion:


[![RealWorld Frontend](https://img.shields.io/badge/realworld-frontend-%23783578.svg)](http://realworld.io)
[![Build Status](https://travis-ci.org/gothinkster/angular-realworld-example-app.svg?branch=master)](https://travis-ci.org/gothinkster/angular-realworld-example-app)

# ![Angular Example App](logo.png)

> ### Angular codebase containing real world examples (CRUD, auth, advanced patterns, etc) that adheres to the [RealWorld](https://github.com/gothinkster/realworld-example-apps) spec and API.

<a href="https://stackblitz.com/edit/angular-realworld" target="_blank"><img width="187" src="https://github.com/gothinkster/realworld/blob/master/media/edit_on_blitz.png?raw=true" /></a>&nbsp;&nbsp;<a href="https://thinkster.io/tutorials/building-real-world-angular-2-apps" target="_blank"><img width="384" src="https://raw.githubusercontent.com/gothinkster/realworld/master/media/learn-btn-hr.png" /></a>

### [Demo](https://angular.realworld.io)&nbsp;&nbsp;&nbsp;&nbsp;[RealWorld](https://github.com/gothinkster/realworld)

This codebase was created to demonstrate a fully fledged application built with Angular that interacts with an actual backend server including CRUD operations, authentication, routing, pagination, and more. We've gone to great lengths to adhere to the [Angular Styleguide](https://angular.io/styleguide) & best practices.

Additionally, there is an Angular 1.5 version of this codebase that you can [fork](https://github.com/gothinkster/angularjs-realworld-example-app) and/or [learn how to recreate](https://thinkster.io/angularjs-es6-tutorial).

# How it works

We're currently working on some docs for the codebase (explaining where functionality is located, how it works, etc) but the codebase should be straightforward to follow as is. We've also released a [step-by-step tutorial w/ screencasts](https://thinkster.io/tutorials/building-real-world-angular-2-apps) that teaches you how to recreate the codebase from scratch.

### Making requests to the backend API

For convenience, we have a live API server running at https://conduit.productionready.io/api for the application to make requests against. You can view [the API spec here](https://github.com/GoThinkster/productionready/blob/master/api) which contains all routes & responses for the server.

The source code for the backend server (available for Node, Rails and Django) can be found in the [main RealWorld repo](https://github.com/gothinkster/realworld).

If you want to change the API URL to a local server, simply edit `src/environments/environment.ts` and change `api_url` to the local server's URL (i.e. `localhost:3000/api`). Please note you will probably need to use a proxy in order to avoid Cross-Origin Resource (CORS) issues. (more info: [Proxying to a backend server](https://angular.io/guide/build#proxying-to-a-backend-server) )

# Getting started

Make sure you have the [Angular CLI](https://github.com/angular/angular-cli#installation) installed globally. We use [Yarn](https://yarnpkg.com) to manage the dependencies, so we strongly recommend you to use it. you can install it from [Here](https://yarnpkg.com/en/docs/install), then run `yarn install` to resolve all dependencies (might take a minute).

Run `ng serve` for a dev server. Navigate to `http://localhost:4200/`. The app will automatically reload if you change any of the source files.

### Building the project

Run `ng build` to build the project. The build artifacts will be stored in the `dist/` directory. Use the `-prod` flag for a production build.

## Functionality overview

The example application is a social blogging site (i.e. a Medium.com clone) called "Conduit". It uses a custom API for all requests, including authentication. You can view a live demo over at https://angular.realworld.io

**General functionality:**

- Authenticate users via JWT (login/signup pages + logout button on settings page)
- CRU\* users (sign up & settings page - no deleting required)
- CRUD Articles
- CR\*D Comments on articles (no updating required)
- GET and display paginated lists of articles
- Favorite articles
- Follow other users

**The general page breakdown looks like this:**

- Home page (URL: /#/ )
  - List of tags
  - List of articles pulled from either Feed, Global, or by Tag
  - Pagination for list of articles
- Sign in/Sign up pages (URL: /#/login, /#/register )
  - Uses JWT (store the token in localStorage)
  - Authentication can be easily switched to session/cookie based
- Settings page (URL: /#/settings )
- Editor page to create/edit articles (URL: /#/editor, /#/editor/article-slug-here )
- Article page (URL: /#/article/article-slug-here )
  - Delete article button (only shown to article's author)
  - Render markdown from server client side
  - Comments section at bottom of page
  - Delete comment button (only shown to comment's author)
- Profile page (URL: /#/profile/:username, /#/profile/:username/favorites )
  - Show basic user info
  - List of articles populated from author's created articles or author's favorited articles

<br />
prueba
[![Brought to you by Thinkster](https://raw.githubusercontent.com/gothinkster/realworld/master/media/end.png)](https://thinkster.io)
