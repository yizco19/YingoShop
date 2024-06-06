@echo off


rem Iniciar Redis en una nueva ventana
start "" /min ".\Redis-x64-3.2.100\redis-server.exe" ".\Redis-x64-3.2.100\redis.windows.conf"


rem Iniciar ngrok en una nueva ventana
start "" /min ngrok.exe http --domain=bonefish-unbiased-quickly.ngrok-free.app 8080


rem Iniciar el backend
java -jar servidor_shop-1.0-SNAPSHOT.jar
