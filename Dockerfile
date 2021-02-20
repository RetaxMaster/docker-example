# Trabaja desde la imagen node:12
FROM node:14

# Copia todos los archivos de este directorio a la ruta /usr/src
COPY ["package.json", "package-lock.json", "/usr/src/"]

# Especifica el directorio de trabajo donde correremos los demas comandos (es equivalente a cd /usr/src)
WORKDIR /usr/src

# Instalamos las dependencias del proyecto
RUN npm install

# Para aprovechar la caché de Docker, este puede saber cuándo algo ya fue ejecutado y omitirlo, pero ante cualquier pequeño cambio volverá a ejecutar todo, al copiar unicamente package.json y package-lock.json, hago que cada vez que reconstruya mi imagen para meter cambios a mi cádigo, Docker ya no vuelva a instalar las dependencias porque estos archivos no fueron modificados (a no ser que se haya agregado una nueva dependencia, ahó si hay que reinstalar), pero en el caso de solo modificar código, Docker usará su caché y ya no reinstalará lo demás. Docker también se dará cuenta que ya se copiaron los archivos de package y se ahorrará copiarlos acá
COPY [".", "/usr/src/"]

# Exponemos el puerto 3000 de Docker para que pueda ser bindeable a algn puerto de la múquina huesped
EXPOSE 3000

# Define cuál es el proceso por defecto que se ejecutará al correr esste contenedor (recordemos que con Docker, mientras el proceso principal está corriendo, la instancia de Docker estaré viva)
# Al usar nodemon, podemos bindear un archivo de nuestro proyecto en la máquina real a un archivo dentro de Docker, así cuando cambie en la máquina real, también cambiará dentro de Docker y nodemon lo detectará y correrá los cambios
# docker run --rm -p 3000:3000 -v $(pwd)/index.js:/usr/src/index.js dockerapp
CMD ["npx", "nodemon", "index.js"]
