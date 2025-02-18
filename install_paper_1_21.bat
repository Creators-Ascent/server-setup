@echo off
:: Richiede i permessi di amministratore
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Lo script deve essere eseguito come amministratore!
    pause
    exit
)

:: Imposta le cartelle e i file
set "SERVER_FOLDER=%USERPROFILE%\Desktop\Server_Minecraft"
set "START_SCRIPT=%SERVER_FOLDER%\start.bat"
set "EULA_FILE=%SERVER_FOLDER%\eula.txt"
set "PAPER_JAR=%SERVER_FOLDER%\paper.jar"
set "TEMURIN_INSTALLER=%TEMP%\temurin21.msi"

:: Se il server è già configurato, avviarlo direttamente
if exist "%EULA_FILE%" (
    echo Server già configurato. Avvio in corso...
    cd /d "%SERVER_FOLDER%"
    start "" "%START_SCRIPT%"
    exit
)

:: Creazione della cartella del server
if not exist "%SERVER_FOLDER%" (
    mkdir "%SERVER_FOLDER%"
    echo Cartella "Server_Minecraft" creata sul Desktop.
) else (
    echo La cartella "Server_Minecraft" esiste già.
)

:: Controllo della presenza di Temurin JDK 21
echo Controllo della presenza di Temurin JDK 21...
reg query "HKLM\SOFTWARE\Adoptium\JDK\21" >nul 2>&1 && set JAVA_FOUND=1

if defined JAVA_FOUND (
    echo Temurin JDK 21 è già installato.
) else (
    echo Java non trovato. Scaricamento e installazione di Temurin JDK 21...

    :: Scarica Temurin JDK 21 MSI
    curl -L -o "%TEMURIN_INSTALLER%" "https://api.adoptium.net/v3/installer/latest/21/ga/windows/x64/jdk/hotspot/normal/eclipse"

    if not exist "%TEMURIN_INSTALLER%" (
        echo Errore: impossibile scaricare Temurin JDK 21.
        pause
        exit
    )

    :: Installa Temurin JDK 21
    echo Installazione di Temurin JDK 21 in corso...
    start /wait msiexec /i "%TEMURIN_INSTALLER%" /quiet /norestart

    echo Temurin JDK 21 installato con successo.
)

:: Ottenere l'ultima build di PaperMC
echo Ottenendo l'ultima build di PaperMC...
for /f %%i in ('powershell -Command "(Invoke-RestMethod -Uri 'https://api.papermc.io/v2/projects/paper/versions/1.21').builds[-1]"') do set "LATEST_BUILD=%%i"

if not defined LATEST_BUILD (
    echo Errore: impossibile ottenere l'ultima build di PaperMC. Verifica la connessione a Internet.
    pause
    exit
)

set "PAPER_DOWNLOAD=https://api.papermc.io/v2/projects/paper/versions/1.21/builds/%LATEST_BUILD%/downloads/paper-1.21-%LATEST_BUILD%.jar"

:: Scaricamento di PaperMC
echo Scaricamento di PaperMC Build %LATEST_BUILD%...
curl -L -o "%PAPER_JAR%" "%PAPER_DOWNLOAD%"

if not exist "%PAPER_JAR%" (
    echo Errore: impossibile scaricare PaperMC.
    pause
    exit
)

:: Creazione del file start.bat
if not exist "%START_SCRIPT%" (
    echo Creazione del file start.bat...
    (
        echo @echo off
        echo java -Xmx2G -Xms2G -jar paper.jar nogui
    ) > "%START_SCRIPT%"
)

:: Primo avvio del server per generare i file necessari
echo Avvio iniziale del server per generare i file...
cd /d "%SERVER_FOLDER%"
start /wait "" "%START_SCRIPT%"
timeout /t 10 >nul

:: Accettazione dell'EULA
echo Accettazione dell'EULA...
if exist "%EULA_FILE%" (
    powershell -Command "(gc '%EULA_FILE%') -replace 'eula=false', 'eula=true' | sc '%EULA_FILE%'"
) else (
    echo Il file eula.txt non è stato trovato. Verifica che il server sia stato avviato correttamente.
)

:: Avvio finale del server
echo Avvio finale del server...
start "" "%START_SCRIPT%"

echo Configurazione completata! Puoi ora accedere al server Minecraft tramite l'indirizzo IP localhost.
pause
