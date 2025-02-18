# README - Script di Configurazione per Server Minecraft

Questo script automatizza il processo di configurazione di un server Minecraft basato su PaperMC. Include il download e l'installazione di Temurin JDK 21, la preparazione della cartella del server, la gestione del file `paper.jar` e la generazione dei file necessari per l'avvio del server.

---

## **1. Requisiti**

- **Sistema Operativo**: Windows.
- **Connessione a Internet**: Necessaria per scaricare Temurin JDK 21 e il file `paper.jar`.
- **File `paper.jar`**: Deve essere presente nella stessa directory dello script prima dell'esecuzione.

---

## **2. Funzionalità dello Script**

1. Verifica se il server è già configurato.
2. Crea la cartella del server sul Desktop (`Server_Minecraft`).
3. Controlla e installa automaticamente Temurin JDK 21 se non è già presente.
4. Copia il file `paper.jar` nella cartella del server.
5. Genera un file `start.bat` per avviare il server con le impostazioni predefinite.
6. Esegue un primo avvio del server per generare i file necessari (incluso `eula.txt`).
7. Accetta automaticamente l'EULA modificando il file `eula.txt`.
8. Fornisce istruzioni per avviare manualmente il server.

---

## **5. Primo Avvio del Server**

Lo script eseguirà un avvio iniziale del server per generare i file necessari, come il file `eula.txt`. Durante questo processo:

1. Si aprirà una nuova finestra del terminale.
2. Aspettate che il processo termini (potrebbe richiedere qualche minuto).
3. Chiudete la finestra del terminale una volta completato.
4. Tornate al terminale dello script e digitate `n`, quindi premete **Invio** per continuare.

---

## **5. Avvio Manuale del Server**

Dopo aver completato la configurazione, puoi avviare manualmente il server eseguendo il file `start.bat` nella cartella `Server_Minecraft`. Non utilizzare permessi di amministratore per eseguire questo file.

---

## **6. Note Importanti**

- L'indirizzo IP predefinito per accedere al server è `localhost`.
- Per consentire ad altri giocatori di connettersi al tuo server, dovrai configurare il port forwarding sul tuo router (porta predefinita: 25565).
- Assicurati di avere almeno 2 GB di RAM disponibili sul tuo sistema per eseguire il server senza problemi.

---

## **7. Log della Configurazione**

Tutte le operazioni eseguite dallo script vengono registrate in un file di log chiamato `setup_log.txt`, situato nella cartella `Server_Minecraft`. Puoi consultarlo in caso di errori o problemi durante la configurazione.
