# Guida per l'installazione e configurazione del Server Minecraft

Questo script batch automatizza il processo di configurazione e avvio di un server Minecraft su Windows. Segui le istruzioni di seguito per eseguire correttamente lo script e configurare il tuo server.

## Requisiti

- Sistema operativo: **Windows**
- Connessione a Internet (per il download di Temurin JDK 21 e PaperMC)
- Permessi di amministratore per installare Java (se non è già installato)

## Funzionamento dello Script

### 1. **Creazione della cartella del server**
   Lo script crea una cartella chiamata `Server_Minecraft` sul tuo desktop (se non esiste già).

### 2. **Controllo di Temurin JDK 21**
   Lo script verifica se Temurin JDK 21 è già installato sul tuo sistema. Se non lo è, lo scarica e lo installa automaticamente.

### 3. **Scaricamento e installazione di PaperMC**
   Lo script scarica l'ultima versione di PaperMC (versione 1.21) dal sito ufficiale di PaperMC.

### 4. **Creazione del file di avvio**
   Un file `start.bat` viene creato nella cartella del server. Questo file ti permette di avviare il server Minecraft con la giusta configurazione di memoria.

### 5. **Primo avvio del server**
   Lo script esegue un avvio iniziale del server per generare i file necessari, come il file `eula.txt`. Si aprira un nuovo terminale aspettate che finisce e poi chiudetelo e digitate `n` ed invio per continuare.

### 6. **Accettazione dell'EULA**
   Dopo il primo avvio, lo script modifica automaticamente il file `eula.txt` per accettare l'EULA di Minecraft (impostando `eula=true`).

### 7. **Avvio finale**
   Lo script ti avvisa che il server è pronto per essere avviato manualmente. Non sono necessari permessi di amministratore per il successivo avvio.

## Come eseguire lo script

1. Scarica il file `setup_server.bat` sul tuo computer.
2. Fai doppio clic sul file per eseguire lo script. Segui le istruzioni che vengono visualizzate nella finestra del terminale.
3. Una volta che il server è configurato, puoi avviarlo manualmente con il file `start.bat` che si trova nella cartella `Server_Minecraft`.

## Messaggi di Log

Lo script crea un file di log (`setup_log.txt`) sul desktop. Ogni passo del processo di configurazione viene registrato con un timestamp. Questo ti aiuterà a diagnosticare eventuali problemi durante la configurazione.

## Problemi comuni

- **Errore durante il download di Temurin JDK 21**: Verifica la tua connessione a Internet.
- **Impossibile scaricare PaperMC**: Controlla la connessione Internet o la disponibilità del servizio PaperMC.
- **File eula.txt non trovato**: Assicurati che il server venga avviato correttamente per generare il file `eula.txt`.

## Conclusione

Una volta completata la configurazione, il server Minecraft è pronto per essere avviato. Puoi accedere al server tramite l'indirizzo `localhost` dal tuo client Minecraft. Buon divertimento!

---

**Nota**: Lo script è progettato per l'uso su un sistema Windows. Alcuni passaggi potrebbero richiedere permessi di amministratore per l'installazione di software (come Temurin JDK).
