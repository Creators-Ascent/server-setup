# Setup per testare i nostri plugin

Se avete dubbi o qualcosa non funziona, scrivetemi pure su discord (@letalexalex)

(potete seguire [questa guida in italiano](https://www.youtube.com/watch?v=Lhf9gBOoJrI) fino a 2:25)

1. Scarica Paper da https://papermc.io/downloads/paper/
2. Metti Paper in una cartella vuota a tua scelta (**IMPORTANTE**: NON USATE CARTELLE COME *Desktop* o *Documenti*, create una catella nuova in esse se proprio dovete.)
3. Nella cartella con Paper:
4. Crea un nuovo file di testo (.txt)
5. Nel file, inserite `java -Xmx2G -Xms2G -jar nome_file_di_paper.jar nogui` (rimpiazzare "nome_file_di_paper.jar" con il nome del .jar di paper)
6. File > Salva con nome -> Chiamatelo `start.bat` o come volete basta che finisce con .bat (se non capite bene guardate il video sopra)
7. eseguite il file .bat e dopo che finisce (si chiuderà) avrete nei diversi file un file chiamato `eula.txt`, entrate nel file e modificate `eula=false` in `eula=true`
8. Scarica il nostro plugin (.jar) dalla sezione Releases della repository del plugin che vuoi testare.
9. Metti il plugin nella cartella "plugins"
10. esegui il .bat di nuovo. dovrà avviarsi.
11. quando vedete un output simile:
```
Done preparing level "world" (1.953s)
Running delayed init tasks
Done (13.064s)! For help, type "help"
```
Vuol dire che potete entrare. avviate Minecraft in versione 1.21.4 e entrate in un server con indirizzo IP `localhost`

---

TUTTO QUA. Se avete dubbi o qualcosa non funziona, scrivetemi pure su discord (@letalexalex)
