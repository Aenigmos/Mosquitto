@echo off
:: Verifica se Docker è in esecuzione
docker version >nul 2>&1
if ERRORLEVEL 1 (
    echo Docker non è in esecuzione. Avvia Docker Desktop prima di eseguire questo script.
    pause
    exit /b
)

:: Ferma il container Mosquitto
echo Fermare Mosquitto...
docker-compose down

if ERRORLEVEL 0 (
    echo Mosquitto fermato correttamente.
) else (
    echo Errore nel fermare Mosquitto.
)

pause