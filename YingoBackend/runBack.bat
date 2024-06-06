@echo off

rem Verificar si el archivo de configuración de ngrok ya existe
if not exist %USERPROFILE%\.ngrok2\ngrok.yml (
    rem Configurar el token de autenticación de ngrok solo si el archivo de configuración no existe
    ngrok authtoken <TU_TOKEN_DE_AUTENTICACIÓN>
)

rem Iniciar Redis
start "Redis Server" ".\Redis-x64-3.2.100\redis-server.exe" ".\Redis-x64-3.2.100\redis.windows.conf"

rem Esperar unos segundos para que Redis se inicie completamente
timeout /t 5 /nobreak >nul

rem Ejecutar ngrok para exponer el servidor local en el dominio de ngrok
start "ngrok" ngrok http --domain=bonefish-unbiased-quickly.ngrok-free.app 8080

rem Esperar unos segundos para que ngrok se inicie completamente
timeout /t 5 /nobreak >nul

rem Iniciar el backend
java -jar servidor_shop-1.0-SNAPSHOT.jar
