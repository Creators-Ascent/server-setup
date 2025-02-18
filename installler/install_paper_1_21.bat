@echo off
:: Disabilita temporaneamente il controllo di CTRL+C
setlocal enabledelayedexpansion

:: Definisce la posizione del log
set LOG_FILE=%USERPROFILE%\Desktop\Server_Minecraft\setup_log.txt

:: Funzione di log con orario
call :Log "Inizio configurazione..."

:: Imposta le cartelle e i file
set "SERVER_FOLDER=%USERPROFILE%\Desktop\Server_Minecraft"
set "START_SCRIPT=%SERVER_FOLDER%\start.bat"
set "EULA_FILE=%SERVER_FOLDER%\eula.txt"
set "PAPER_JAR=%~dp0paper.jar" :: Usa il file paper.jar nella directory corrente
set "TEMURIN_INSTALLER=%TEMP%\temurin21.msi"

:: Se il server è già configurato, avviarlo direttamente
if exist "%EULA_FILE%" (
    call :Log "Server già configurato. Avvio in corso..."
    echo Server già configurato. Avvio in corso...
    cd /d "%SERVER_FOLDER%"
    echo Avviare il server con il comando: "%START_SCRIPT%" senza permessi di amministratore.
    pause
    exit
)

:: Creazione della cartella del server
if not exist "%SERVER_FOLDER%" (
    mkdir "%SERVER_FOLDER%"
    call :Log "Cartella 'Server_Minecraft' creata sul Desktop."
    echo Cartella 'Server_Minecraft' creata sul Desktop.
) else (
    call :Log "La cartella 'Server_Minecraft' esiste già."
    echo La cartella 'Server_Minecraft' esiste già.
)

:: Controllo della presenza di Temurin JDK 21
call :Log "Controllo della presenza di Temurin JDK 21..."
echo Controllo della presenza di Temurin JDK 21...
reg query "HKLM\SOFTWARE\Adoptium\JDK\21" >nul 2>&1 && set JAVA_FOUND=1

if defined JAVA_FOUND (
    call :Log "Temurin JDK 21 è già installato."
    echo Temurin JDK 21 è già installato.
) else (
    call :Log "Java non trovato. Scaricamento e installazione di Temurin JDK 21..."
    echo Java non trovato. Scaricamento e installazione di Temurin JDK 21...

    :: Scarica Temurin JDK 21 MSI
    curl -L -o "%TEMURIN_INSTALLER%" "https://api.adoptium.net/v3/installer/latest/21/ga/windows/x64/jdk/hotspot/normal/eclipse"

    if not exist "%TEMURIN_INSTALLER%" (
        call :Log "Errore: impossibile scaricare Temurin JDK 21."
        echo Errore: impossibile scaricare Temurin JDK 21.
        pause
        exit
    )

    :: Installa Temurin JDK 21
    call :Log "Installazione di Temurin JDK 21 in corso..."
    echo Installazione di Temurin JDK 21 in corso...
    start /wait msiexec /i "%TEMURIN_INSTALLER%" /quiet /norestart

    call :Log "Temurin JDK 21 installato con successo."
    echo Temurin JDK 21 installato con successo.
)

:: Verifica la presenza del file paper.jar nella directory corrente
if not exist "%PAPER_JAR%" (
    call :Log "Errore: il file 'paper.jar' non è stato trovato nella directory corrente."
    echo Errore: il file 'paper.jar' non è stato trovato nella directory corrente.
    pause
    exit
)

:: Copia paper.jar nella cartella del server
copy "%PAPER_JAR%" "%SERVER_FOLDER%\paper.jar" >nul

if not exist "%SERVER_FOLDER%\paper.jar" (
    call :Log "Errore: impossibile copiare 'paper.jar' nella cartella del server."
    echo Errore: impossibile copiare 'paper.jar' nella cartella del server.
    pause
    exit
)

:: Creazione del file start.bat
if not exist "%START_SCRIPT%" (
    call :Log "Creazione del file start.bat..."
    echo Creazione del file start.bat...
    (
        echo @echo off
        echo java -Xmx2G -Xms2G -jar paper.jar nogui
    ) > "%START_SCRIPT%"
)

:: Primo avvio del server per generare i file necessari
call :Log "Avvio iniziale del server per generare i file..."
echo Avvio iniziale del server per generare i file...
cd /d "%SERVER_FOLDER%"
start /wait "" "%START_SCRIPT%"
timeout /t 10 >nul

:: Accettazione dell'EULA
call :Log "Accettazione dell'EULA..."
echo Accettazione dell'EULA...
if exist "%EULA_FILE%" (
    powershell -Command "(gc '%EULA_FILE%') -replace 'eula=false', 'eula=true' | sc '%EULA_FILE%'"
) else (
    call :Log "Il file eula.txt non è stato trovato. Verifica che il server sia stato avviato correttamente."
    echo Il file eula.txt non è stato trovato. Verifica che il server sia stato avviato correttamente.
)

:: Avvio finale del server (senza permessi di amministratore)
call :Log "Avviare manualmente il server con il comando: \"%START_SCRIPT%\" senza permessi di amministratore."
echo Avviare manualmente il server con il comando: "%START_SCRIPT%" senza permessi di amministratore.

:: Attendere l'utente per continuare
echo Premi un tasto per continuare quando hai avviato il server...
pause >nul

call :Log "Configurazione completata! Puoi ora accedere al server Minecraft tramite l'indirizzo IP localhost."
echo Configurazione completata! Puoi ora accedere al server Minecraft tramite l'indirizzo IP localhost.

exit

:: Funzione di log con orario
:Log
set "TIMESTAMP=%DATE% %TIME%"
echo [%TIMESTAMP%] %1
echo [%TIMESTAMP%] %1 >> "%LOG_FILE%"
goto :eof
