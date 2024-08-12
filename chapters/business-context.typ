#import "@preview/glossarium:0.4.1": make-glossary, gls
#show: make-glossary

= Il contesto aziendale
<cap:business-context>

#v(1em)
#text(style: "italic", [
    Nel presente capitolo intendo fornire una panoramica generale dell'azienda in cui ho
    svolto il tirocinio e qual è il rapporto tra quest'ultima e il rinnovamento tecnologico.
])
#v(1em)

== _Bluewind_ S.R.L.

\ _Bluewind_ è un'azienda con sede a Castelfranco Veneto (TV) che offre servizi di ingegneria
nel mondo dei sistemi _embedded_, principalmente attiva nei settori: automobilistico, medico
e industriale.

\ Il punto di forza dell'azienda è quello di poter contare su _team_ multi-funzionali,
che permettono di coprire a trecentosessanta gradi l'intero processo di creazione di un prodotto:
- analisi;
- progettazione;
- certificazioni di conformità;
- implementazione.
Questo è permesso anche grazie alla forte componente di formazione che viene sempre messa
in primo piano quando necessaria. Durante il tirocinio ho potuto sperimentarlo in prima
persona grazie ai tutor e ai colleghi, che mi hanno affiancato durante tutto il percorso,
offrendomi le loro conoscenze e fornendomi degli interessanti spunti di riflessione.
Oltre a questo ho anche partecipato a due sessioni aziendali della durata di un giorno in cui
abbiamo trattato rispettivamente il tema #gls("agile")#sub[G], e come migliorare i processi
interni, e il tema della ristrutturazione e della definizione dei ruoli in azienda.
Questo dimostra come _Bluewind_ investa molto non solo nelle nuove tecnologie,
ma anche nel miglioramento continuo del proprio ambiente di lavoro.

\ Per quanto descritto prima, la clientela risulta quindi molto varia ma, la principale attività,
prevede di portare un prodotto software, già esistente o meno, in una condizione tale per cui
possa essere certificato, attraverso una complesso insieme di strumenti e _standard_ da seguire.
Altra parte dei ricavi arriva dalla rivendita di prodotti e licenze sempre in ambito _embedded_,
per programmi e librerie software delle aziende di cui _Bluewind_ è #gls("partner")#sub[G].

== Organizzazione interna

All'interno vi sono due reparti principali:
- #gls("rnd")#sub[G], ossia il reparto di ricerca e sviluppo, in cui ero presente anche io;
- _Marketing_ and _Sales_, ossia il reparto che si occupa della vendita di prodotti e della
  parte pubblicitaria;

\ Il reparto _R_&_D_ è quello in cui si svolgono tutte le attività di produzione,
ed è suddiviso in _team_, ognuno dei quali lavora ad un progetto, con persone
che possono essere presenti in più _team_ diversi.
Questi sono guidati da un #gls("po")#sub[G], persona che si occupa di interfacciarsi con il
cliente e di assicurarsi che il lavoro venga consegnato nei modi e tempi previsti.
Ogni _team_ poi include persone con diversi ruoli, tra cui:
- analisti software;
- analisti della sicurezza;
- progettisti;
- sviluppatori.
A capo di tutto il reparto c'è una persona che ha il ruolo di _Head of R_&_D_, che si occupa
del buon funzionamento del reparto stesso.

#figure(
  image("../images/rnd.jpg", width: 80%),
  caption: [
    Rappresentazione grafica di esempio della suddivisione del reparto _R_&_D_ in Bluewind.
  ],
)

== Il metodo #emph[agile]
\ Tutti i processi trovano fondamento nella metodologia _agile_, una serie di principi elencati
nel _"Manifesto Agile for Software Development#super[@manifesto_agile]"_,
che mirano a garantire la minimizzazione del rischio, utilizzando un approccio centrato sulla
consegna iterativa e incrementale di un prodotto funzionante che si avvicina sempre
di più al prodotto finale.
Oltre a questo, anche la stretta collaborazione con il cliente e una forte componente di
adattamento e apertura al cambiamento, garantiscono questa minimizzazione.

La metodologia _agile_, benché nasca all'interno del mondo dello sviluppo software, si può
adattare bene a qualsiasi tipo di ruolo ed è proprio quello che accade in _Bluewind_.
Per quello che ho potuto osservare, non tutti all'interno dell'azienda utilizzano questa
metodologia, ma sicuramente ne sono influenzati.

\ Quello che ho potuto osservare più da vicino è come questi principi prendano vita all'interno
del _framework_ #gls("scrum")#sub[G], utilizzato per lo sviluppo software e
che verrà descritto in dettaglio nella sezione #link(<cap:working-method>)["Metodo di lavoro"].

== Tecnologie e strumenti
La quantità di strumenti, tecnologie e servizi utlizzati all'interno dell'azienda mi
impedisce di elencarli tutti, per questo ne farò una panoramica più ad alto livello di quelli
legati in qualche forma al mio progetto.
=== Hardware
==== _STMicroelectronics_
==== _Infineon Technologies_
Lo sviluppo avviene principalemente su microcontrollori di due diverse ditte:
_STMicroelectronics_ e _Infineon Technologies_.

=== Software
==== Compilatori _HighTec_
==== _PLS UDE_
In particolare per lo sviluppo in _Rust_ nei microcontrollori _Infineon Aurix_ è necessario
usare delle librerie che permettano di compilare il codice per queste piattaforme,
come quelle dell'azienda _HighTec_, oltre alla necessità di utilizzare strumenti di _debug_
specifici, come il programma _UDE_, della ditta _PLS_.
==== Sistemi operativi
Siccome il sistema operativo utilizzato nei computer aziendali è _Ubuntu_, e la maggior parte
degli strumenti di sviluppo funziona solo su _Windows_, utilizzavo una macchina virtuale,
creata con _VirtualBox_, al fine di provare il codice direttamente sulla scheda di test.
==== Diagrammi
Per la scrittura dei requisiti invece non ho utilizzato uno strumento specifico, ma ho usato
_StarUML_ per fare delle rappresentazioni grafiche legate alla progettazione del software:
- diagramma dei casi d'uso;
- diagramma delle classi;
- diagramma per la macchina a stati finiti;
- digramma di sequenza.
==== Strumenti di sviluppo
\ Nell'uso quotidiano, come #gls("its")#sub[G], utilizzavamo _Gitlab_, unito al suo sistema di
==== Strumenti di comunicazione
controllo di versione, e _Telegram_ e _Zoom_ come canali di comunicazione.

== Rapporto con l'innovazione
\ _Bluewind_ ha un rapporto speciale con l'innovazione, facendo di essa il proprio cavallo di
battaglia.

L'azienda impiega risorse ed energie nello studio volto all'integrazione di nuove tecnologie, al
servizio dei processi interni e dei prodotti sviluppati, per soddisfare al meglio le proprie
esigenze e quelle dei clienti.
Proprio a questi è spesso difficile spiegare l'importanza di mantenersi aggiornati rispetto
all'evoluzione tecnologica, che mai come in questi anni avanza velocemente.
Affinché tutto questo sia possibile, l'azienda si avvale sia di risorse interne, come i
dipendenti, sia di risorse esterne, come consulenti e tirocinanti universitari.

\ In particolar modo, i tirocini universitari che si svolgono, hanno anche come scopo quello
di condurre ricerche su temi in voga oppure sviluppare progetti utlizzando nuovi strumenti e
tecnologie, per i quali, ad esempio, non si conosce l'impatto futuro perché troppo giovani.
