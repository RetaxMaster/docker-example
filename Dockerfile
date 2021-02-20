# Trabaja desde la imagen node:12
FROM node:12

# Copia todos los archivos de este directorio a la ruta /usr/src
COPY [".", "/usr/src/"]

# Especifica el directorio de trabajo donde correremos los demas comandos (es equivalente a cd /usr/src)
WORKDIR /usr/src

# Instalamos las dependencias del proyecto
RUN npm install

# Exponemos el puerto 3000 de Docker para que pueda ser bindeable a algn puerto de la múquina huesped
EXPOSE 3000

# Define cuál es el proceso por defecto que se ejecutará al correr esste contenedor (recordemos que con Docker, mientras el proceso principal está corriendo, la instancia de Docker estaré viva)
CMD ["node", "index.js"]
