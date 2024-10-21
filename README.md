
# Mosquitto Project

## Descrizione
Questo progetto permette di eseguire un broker MQTT Mosquitto all'interno di un container Docker, utilizzando un file di configurazione personalizzato e script batch per semplificare l'avvio e la configurazione. Include anche l'apertura automatica delle porte nel firewall di Windows per consentire l'accesso a Mosquitto sulla LAN.

## Struttura del progetto

```
mosquitto-project/
│
├── docker-compose.yml    # File per configurare Docker Compose
├── mosquitto.conf        # File di configurazione per Mosquitto
├── start_mosquitto.bat   # Script per avviare Mosquitto su Windows e aprire le porte nel firewall
├── stop_mosquitto.bat    # Script per fermare Mosquitto su Windows
└── README.md             # Documentazione del progetto
```

## Prerequisiti

- **Docker** e **Docker Compose** devono essere installati e funzionanti sul tuo sistema.
- **Docker Desktop** deve essere avviato prima di eseguire i file `.bat`.
- **Accesso come amministratore** su Windows è richiesto per aprire le porte del firewall tramite script batch.

## Istruzioni per l'uso

### 1. Avviare Mosquitto
Per avviare Mosquitto e aprire automaticamente le porte nel firewall di Windows:

1. Fai doppio clic su `start_mosquitto.bat`.
2. Lo script verificherà se Docker è in esecuzione e aprirà le porte 1883 (MQTT) e 9001 (WebSockets) nel firewall.
3. Una volta avviato, Mosquitto sarà accessibile:
   - **Porta 1883** per connessioni MQTT.
   - **Porta 9001** per connessioni WebSockets (opzionale).

Dopo l'esecuzione dello script, vedrai i messaggi che confermano l'apertura delle porte e l'avvio del container Mosquitto.

### 2. Fermare Mosquitto
Per fermare il container Mosquitto:

1. Fai doppio clic su `stop_mosquitto.bat`.
2. Lo script fermerà Mosquitto e Docker Compose chiuderà correttamente il container.

### 3. Connessione a Mosquitto

#### Connessione tramite MQTT:

Puoi connetterti a Mosquitto usando un client MQTT come `mosquitto_pub` o `mosquitto_sub` o qualsiasi altro software MQTT, specificando l'indirizzo IP del computer che esegue Mosquitto e la porta **1883**.

Esempio di comando per inviare un messaggio MQTT:

```bash
mosquitto_pub -h 192.168.X.X -t "test/topic" -m "Hello Mosquitto"
```

Dove `192.168.X.X` è l'indirizzo IP del tuo computer nella rete locale.

#### Connessione tramite WebSockets:

Se desideri utilizzare WebSockets per connetterti a Mosquitto, puoi usare la porta **9001** per le connessioni.

### 4. Configurazione di Mosquitto

Il file di configurazione di Mosquitto è `mosquitto.conf`. Ecco un esempio di configurazione base:

```conf
listener 1883
allow_anonymous true

listener 9001
protocol websockets
```

Puoi modificare questo file per aggiungere autenticazione, configurazioni SSL, o altre funzionalità avanzate di Mosquitto.

### 5. Modifica delle Porte e Sicurezza

#### Modifica delle porte:
Se desideri utilizzare porte diverse da 1883 e 9001, puoi modificare il file `mosquitto.conf` e aggiornare i comandi `netsh` nei file `.bat` per aprire le nuove porte nel firewall.

#### Aggiunta di sicurezza:
Se il broker Mosquitto è esposto a reti pubbliche o se vuoi migliorare la sicurezza, ti consigliamo di abilitare l'autenticazione tramite username/password o configurare il broker per utilizzare certificati SSL.

### 6. Risoluzione dei problemi

- **Docker non è in esecuzione**: Se Docker non è in esecuzione, lo script ti chiederà di avviare Docker Desktop prima di continuare.
- **Problemi di connessione**: Verifica che le porte 1883 e 9001 siano aperte correttamente nel firewall e che il tuo client MQTT si stia connettendo all'indirizzo IP corretto del computer.

Puoi anche controllare i log del container Mosquitto con il comando:

```bash
docker logs mosquitto-broker
```

## Conclusione

Questo progetto semplifica l'esecuzione di un broker MQTT Mosquitto in Docker e automatizza l'apertura delle porte nel firewall su Windows. Gli script `.bat` ti permettono di avviare e fermare Mosquitto con facilità, rendendolo accessibile ai client MQTT sulla tua rete locale o tramite WebSockets.
