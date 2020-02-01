# :clipboard: AnAvis 

**Progetto realizzato per l'esame di ingegneria del software dell'università di Camerino.**

Componenti gruppo:
- **Luca Cervioni** (100933)
luca.cervioni@studenti.unicam.it
- **Lucia Passeri** (100824) 
lucia.passeri@studenti.unicam.it

## Sviluppato in 
- **Flutter** (per la parte *frontend*, realizzata principalmente da **Luca Cervioni**)
- **Spring Boot** (per la parte *backend*, realizzata principalmente da **Lucia Passeri**)
- **Firebase** (per l'*autenticazione*)

## Descrizione
Il progetto si basa sullo sviluppo di un'**applicazione mobile** che consente ai **donatori Avis** di prenotare le donazioni on-line e di poter controllare lo storico dei risultati delle proprie **analisi**. 

Attualmente per poter **prenotare una donazione Avis**, i donatori devono telefonare o recarsi in una sede la quale riferirà loro quali sono i giorni e gli orari disponibili; ad ogni donazione, prima del prelievo, si deve compilare un **modello cartaceo** in cui si attestano le proprie condizioni di salute. Con quest'**app** si velocizzerebbe la pratica di **prenotazione** e risulterebbe più comodo per i donatori scegliere fra tutte le date e gli orari disponibili nelle varie sedi Avis. Per quanto riguarda il **modello** esso sarà disponibile per la compilazione da parte del donatore prima di poter effettuare la prenotazione.

Questo sistema risulterebbe utile per verificare l’andamento delle proprie **analisi del sangue** che, contrariamente al funzionamento attuale nel quale i risultati vengono inviati per posta cartacea, verrebbero caricate e notificate dall’ospedale alla persona in questione.
I **dottori**, grazie a una dashboard, avranno la possibilità di controllare lo storico delle analisi dei propri pazienti per avere un quadro clinico più completo e in caso poter inserire un commento per evidenziare situazioni da monitorare.

Le **sedi Avis** risparmieranno tempo in quanto interagiranno con il sistema solo per inserire gli orari e le date disponibili per le donazioni, senza più occuparsi direttamente delle prenotazioni che vedranno in un elenco. Infine il sistema permetterà ai dottori di pronto soccorso di inviare una **notifica di “carenza sangue”** ai donatori, i quali potranno contribuire a far rientrare questa emergenza.

## Iterazioni

(Nota: i lavori al codice o piccoli cambiamenti al vpp non sono qui sotto riportati)  

**Prima iterazione (dal 19/11/19 al 05/12/19):**
- Incontro 1 (19/11) -> Identificazione attori e parte dei casi d'uso
- Incontro 2 (20/11) -> Identificazione altri casi d'uso
- Incontro 3 (21/11) -> Flow of events di alcuni casi d'uso
- Incontro 4 (26/11) -> Creazione class diagram e alcuni sequence diagram
- Incontro 5 (28/11) -> Continuo dei lavori sul class diagram e sui sequence diagram
- Incontro 6 (04/12) -> Revisione del diagramma dei casi d'uso
- Incontro 7 (05/12) -> Revisione del class diagram e dei sequence diagram

**Seconda iterazione (dal 10/12/19 al 11/01/20):**
- Incontro 1 (10/12) -> Lavoro ai casi d'uso
- Incontro 2 (03/01) -> Lavoro al class diagram e ai sequence diagram
- Incontro 3 (11/01) -> Revisione di alcuni diagrammi

**Terza iterazione (dal 13/01/20 al 01/02/20):**
- Incontro 1 (13/01) -> Revisione dei sequence diagram
- Incontro 2 (20/01) -> Revisione dei sequence diagram e lavoro ai casi d'uso
- Incontro 3 (22/01) -> Revisione di alcuni diagrammi
- Incontro 4 (29/01) -> Revisione di alcuni diagrammi
- Incontro 5 (01/02) -> Lavoro ai sequence diagram e controllo generale

## Casi d'uso implementati a fine terza iterazione
Per l'**utente non autenticato**:
- Scelta del ruolo
- Effettua l'autenticazione

Per l'**utente autenticato**:
- Si disconnette

Per il **donatore**:
- Prenota donazione
- Visualizza prenotazione effettuata
- Disdici prenotazione

Per le **sede avis**:
- Inserisce prenotazione
- Registra un donatore nel sistema
- Visualizza prenotazioni donazioni
- Elimina prenotazione
