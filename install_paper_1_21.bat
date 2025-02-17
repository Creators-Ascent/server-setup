@echo off

:: Creazione della cartella Server sul Desktop
set "SERVER_FOLDER=%USERPROFILE%\Desktop\Server_Minecraft"
if not exist "%SERVER_FOLDER%" (
    mkdir "%SERVER_FOLDER%"
    echo Cartella "Server_Minecraft" creata sul Desktop.
) else (
    echo La cartella "Server_Minecraft" esiste già.
)

:: Download e installazione di Java 21
echo Controllo della presenza di Java 21...
for /f "tokens=2 delims==" %%i in ('java -version 2^>^&1 ^| findstr "version"') do set JAVA_VERSION=%%i
if not defined JAVA_VERSION (
    echo Java non trovato. Scaricamento e installazione di Java 21...
    powershell -Command "& {Start-BitsTransfer -Source 'https://download.oracle.com/java/21/latest/jdk-21_windows-x64_bin.exe' -Destination '%TEMP%\jdk-21_windows-x64_bin.exe'}"
    start /wait "" "%TEMP%\jdk-21_windows-x64_bin.exe" /s
    del "%TEMP%\jdk-21_windows-x64_bin.exe"
    echo Java 21 installato con successo.
) else (
    echo Java è già installato.
)

:: Download di PaperMC
echo Scaricamento di PaperMC...
powershell -Command "& {Start-BitsTransfer -Source 'https://papermc.io/api/v2/projects/paper/versions/1.21/builds/latest/downloads/paper-1.21-latest.jar' -Destination '%SERVER_FOLDER%\paper.jar'}"

:: Creazione del file start.bat
echo Creazione del file start.bat...
(
echo java -Xmx2G -Xms2G -jar paper.jar nogui
) > "%SERVER_FOLDER%\start.bat"

:: Primo avvio del server per generare i file necessari
echo Avvio iniziale del server per generare i file...
cd /d "%SERVER_FOLDER%"
start.bat
timeout /t 10 >nul

:: Modifica del file eula.txt
echo Accettazione dell'EULA...
if exist eula.txt (
    powershell -Command "(gc eula.txt) -replace 'eula=false', 'eula=true' | sc eula.txt"
) else (
    echo Il file eula.txt non è stato trovato. Verifica che il server sia stato avviato correttamente.
)

:: Avvio finale del server
echo Avvio finale del server...
start start.bat

echo Configurazione completata! Puoi ora accedere al server Minecraft tramite l'indirizzo IP localhost.
pause
