@echo off
:: Verifica se Docker è in esecuzione
docker version >nul 2>&1
if ERRORLEVEL 1 (
    echo Docker non e' in esecuzione. Avvia Docker Desktop prima di eseguire questo script.
    pause
    exit /b
)

:: Apri la porta 1883 (MQTT) nel firewall di Windows
echo Apertura della porta 1883 nel firewall di Windows per connessioni MQTT...
netsh advfirewall firewall add rule name="Mosquitto MQTT 1883" dir=in action=allow protocol=TCP localport=1883

:: Apri la porta 9001 (WebSockets) nel firewall di Windows, se necessario
echo Apertura della porta 9001 nel firewall di Windows per connessioni WebSockets...
netsh advfirewall firewall add rule name="Mosquitto WebSockets 9001" dir=in action=allow protocol=TCP localport=9001

:: Avvia il container Mosquitto
echo Avvio di Mosquitto tramite Docker Compose...
docker-compose up -d

if ERRORLEVEL 0 (
    echo Mosquitto avviato correttamente.
    echo Accessibile sulla porta 1883 per MQTT e 9001 per WebSockets.
) else (
    echo Errore nell'avvio di Mosquitto.
)

pause