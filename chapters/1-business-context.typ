#import "@preview/glossarium:0.4.1": make-glossary, gls
#show: make-glossary

#pagebreak(to: "odd")

= Il contesto aziendale
<cap:business-context>

#v(1em)
#text(style: "italic", [
    Questo capitolo presenta una panoramica generale dell'azienda in cui ho
    svolto il tirocinio e qual è il rapporto tra quest'ultima e le nuove tecnologie.
])
#v(1em)

== _Bluewind_ S.R.L.

L'azienda _Bluewind_, con sede a Castelfranco Veneto (TV), offre servizi di ingegneria
nel mondo dei sistemi _embedded_, principalmente attiva nei settori: automobilistico, medico
e industriale.

Il punto di forza dell'azienda è quello di poter contare su _team_ multi-funzionali,
che permettono di coprire a trecentosessanta gradi l'intero processo di creazione di un prodotto:
- analisi;
- progettazione;
- certificazioni di conformità;
- implementazione.

Essere in grado di operare in tutte le fasi di creazione, è permesso anche grazie alla forte
componente di formazione che viene sempre messa
in primo piano quando necessaria. Durante il tirocinio ho potuto sperimentarlo in prima
persona grazie ai _tutor_ e ai colleghi, che mi hanno affiancato durante tutto il percorso,
offrendomi le loro conoscenze e fornendomi degli interessanti spunti di riflessione.
Oltre a questo ho anche partecipato a due sessioni aziendali, della durata di un giorno, in cui
abbiamo trattato rispettivamente il tema #gls("agile")#sub[G], e come migliorare i processi
interni, e il tema della ristrutturazione e della definizione dei ruoli in azienda.
Questo dimostra come _Bluewind_ investa molto non solo nelle nuove tecnologie,
ma anche nel miglioramento continuo del proprio ambiente di lavoro.

La principale attività dell'azienda, prevede di portare un prodotto _software_, già esistente o
meno, in una condizione tale per cui possa essere certificato secondo uno specifico _standard_.
Altra parte dei ricavi arriva dalla rivendita di prodotti e licenze sempre in ambito _embedded_,
per programmi e librerie _software_ di proprietà delle aziende di cui _Bluewind_ è _partner_.
La clientela risulta di conseguenza molto varia: dai clienti finali che hanno bisogno di una
soluzione _software_ completa, ad altre aziende informatiche che necessitano di attuare sistemi di
sicurezza, spesso all'interno di programmi o sistemi che hanno già sviluppato.

== Organizzazione interna

All'interno dell'azienda vi sono due reparti principali:
- #gls("rnd")#sub[G], ossia il reparto di ricerca e sviluppo, in cui ero inserito;
- _Marketing_ and _Sales_, ossia il reparto che si occupa della vendita di prodotti e della
  parte pubblicitaria;

Il reparto _R_&_D_ è quello in cui si svolgono tutte le attività di produzione,
ed è suddiviso in _team_, ognuno dei quali lavora ad un progetto, con persone
che possono essere presenti in più _team_ diversi.
Questi sono guidati da un #gls("po")#sub[G], persona che si occupa di interfacciarsi con il
cliente e di assicurarsi che il lavoro venga consegnato nei modi e tempi previsti.
Ogni _team_ include persone con diversi ruoli, tra cui:
- analisti _software_;
- analisti della sicurezza;
- progettisti;
- sviluppatori.
A capo di tutto il reparto c'è una persona che ha il ruolo di _Head of R_&_D_, che si occupa
del buon funzionamento del reparto stesso.

#figure(
  image("../images/rnd.jpg", width: 100%),
  caption: [
    rappresentazione grafica di esempio della suddivisione del reparto _R_&_D_ in Bluewind.
  ],
)

== Il metodo #emph[agile]

Tutti i processi trovano fondamento nella metodologia _agile_, una serie di principi elencati
nel _"Manifesto Agile for Software Development"_ #super[@manifesto_agile],
che mirano a garantire la minimizzazione del rischio. Essa utilizza un approccio centrato sulla
consegna iterativa e incrementale di un prodotto funzionante, che si avvicina sempre
di più al prodotto finale.
Oltre a questo, anche la stretta collaborazione con il cliente e una forte componente di
adattamento e apertura al cambiamento, garantiscono questa minimizzazione.

La metodologia _agile_, benché nasca all'interno del mondo dello sviluppo _software_, si può
adattare bene a qualsiasi tipo di ruolo ed è proprio quello che accade in _Bluewind_.
Per quello che ho potuto osservare, non tutti all'interno dell'azienda utilizzano questa
metodologia, ma sicuramente ne sono influenzati.

Quello che ho potuto osservare più da vicino è come questi principi prendano vita all'interno
di un #gls("framework")#sub[G], cioè una serie di metodologie di supporto, utilizzate per lo
sviluppo _software_, che descriverò in dettaglio nella sezione
#link(<sec:working-method>)["Metodo di lavoro"].

== Tecnologie e strumenti

=== _Infineon Technologies Aurix TC375_

I microcontrollori della ditta _Infineon Technologies_ sono dei prodotti ad altissime prestazioni e
altamente affidabili. Infatti sono diventati lo _standard_ in diversi settori tra cui quello
automobilistico, quello spaziale, quello industriale e quello della sicurezza.

#figure(
  image("../images/aurix_tc375_litekit.jpg", width: 80%),
  caption: [
    foto della scheda sulla quale ho sviluppato il progetto di tirocinio presa dal sito web #super[@infineon_tc375] ufficiale.
  ],
)

La scheda di sviluppo che ho utilizzato era una _Aurix TC375 Lite Kit_, prodotta dalla stessa azienda,
che offre un ambiente di sviluppo _hardware_ pre-configurato, pensato per dimostrare tutte le
funzionalità del microcontrollore saldato sulla scheda, che è proprio l'omonimo _Aurix TC375_.

Di quest'ultimo, ho studiato in particolare il modulo #gls("evadc")#sub[G], ossia un orchestratore di
diversi #gls("adc")#sub[G], componenti elettronici che sono in grado di convertire dei segnali analogici
in segnali digitali, attraverso un sistema chiamato #gls("sar")#sub[G].
Ciò significa che prendono un segnale in _Volt_ e lo trasformano in un numero che può essere utilizzato dal microcontrollore.
Le caratteristiche principali sono:
- la gamma, in inglese _range_, voltaggio, minimo e massimo, che possono accettare come valore in ingresso da convertire;
- la risoluzione, il numero di _bit_ del valore numerico convertito, questo determina anche il più piccolo incremento che può venire riconosciuto.

#figure(
  image("../images/sar_example.jpg", width: 100%),
  placement: bottom,
  caption: [
    esempio di come avviene l'approssimazione digitale del valore analogico in ingresso di 5.5V, immaginando un ADC con range da 0V a 7V
    ed una risoluzione di 3 bit.
  ],
) <sar_example>

Il funzionamento di un _ADC_ di tipo _SAR_ è molto semplice: il circuito parte con l'acquisizione del segnale da convertire e lo memorizza, grazie ad un circuito chiamato
_sample and hold_; successivamente genera un segnale analogico a partire da un numero, il cui valore è noto (nella prima iterazione
corrisponde alla metà del _range_, il che equivale ad impostare ad uno il bit più significativo e tenere a zero tutti gli altri).
I due segnali vengono comparati, controllando se il valore in ingresso è maggiore o uguale all'approssimazione fatta fino a
quel momento, il risultato è inserito in un registro che farà da base per l'iterazione successiva.
@sar_example mostra il funzionamento logico del componente, in particolare l'albero binario che porta alla soluzione finale di approssimazione.

=== Linguaggio _Rust_

_Rust_ è un linguaggio di programmazione che gode di un sistema di tipi molto ricco, è estremamente perfomante e ha una gestione della
memoria che elimina un'intera classe di errori legati a quest'ultima, che si riflettono anche sulla sicurezza.
Uno degli obiettivi del progetto, era proprio quello di utilizzare _Rust_ come linguaggio principale, non solo per i vantaggi che offre
in termini di affidabilità, ma soprattutto per studiare i suoi limiti.
Quando parlo di limiti non intendo quelli prestazionali ma, piuttosto, quelli relativi alla facilità di adozione e integrazione nei sistemi
esistenti.

=== Compilatori _HighTec_

_HighTec_ vende sotto licenza un compilatore per _Rust_ certificato #gls("26262")#sub[G] #gls("asild")#sub[G] #super[@iso26262], il che vuol dire che può essere usato
per compilare codice di sistemi di controllo per il settore automobilistico.
Il compilatore in questione compila il codice anche per la piattaforma _Aurix_ e, visti gli interessi di _Bluewind_ sia per il settore,
sia per il microcontrollore, lo abbiamo scelto come strumento, in modo da studiarne ed analizzarne l'utilizzo.

=== _PLS UDE_

Per scrivere il codice all'interno dell'_hardware_, e farne il _debug_, abbiamo scelto uno strumento già utilizzato in azienda anche per il
linguaggio _C_, l'_Universal Debug Engine_, comunemente chiamato _UDE_.
Di questo strumento, vista la possibilità di fare il _debug_ nei microcontrollori _Aurix_, ne erano conosciute a fondo caratteristiche e
funzionalità ma, era stato provato poco per lo sviluppo _Rust_. Questo lo ha reso un interessante caso di studio per vedere come,
passando da un linguaggio all'altro, si sarebbe comportato, rispetto anche alle promesse fatte dalla ditta che lo produce.

=== Sistemi operativi

Siccome il sistema operativo utilizzato nei computer aziendali è _Ubuntu_, e la maggior parte
degli strumenti di sviluppo funziona solo su _Windows_, utilizzavo una macchina virtuale.
Essa funzionava grazie al programma _VirtualBox_, che attraverso alcune estensioni,
mi permetteva di provare il codice direttamente sulla scheda di prova collegata al sistema.

=== Analisi e progettazione

Per la scrittura dei requisiti invece non ho utilizzato uno strumento specifico, ma ho usato
_StarUML_ per fare delle rappresentazioni grafiche legate alla progettazione del _software_:
- diagramma dei casi d'uso;
- diagramma delle classi;
- diagramma per la macchina a stati finiti;
- digramma di sequenza.

=== Altri strumenti

Nella _routine_ quotidiana, come #gls("its")#sub[G], utilizzavamo _Gitlab_, unito al suo sistema di
controllo di versione per il _software_.
Infine abbiamo usato _Telegram_ e _Zoom_ come canali di comunicazione, rispettivamente per messaggi
rapidi e video-conferenze.

#figure(
  image("../images/its_screenshot.png", width: 100%),
  caption: [
    cattura a schermo di una porzione delle attività svolte, tracciate nell'_ITS_.
  ],
)

== Rapporto con l'innovazione

_Bluewind_ ha un rapporto speciale con l'innovazione, facendo di essa il proprio cavallo di
battaglia.

L'azienda impiega risorse ed energie nello studio volto all'integrazione di nuove tecnologie, al
servizio dei processi interni e dei prodotti sviluppati, per soddisfare al meglio le proprie
esigenze e quelle dei clienti.
Proprio a questi è spesso difficile spiegare l'importanza di mantenersi aggiornati rispetto
all'evoluzione tecnologica, che mai come in questi anni avanza velocemente.
Affinché tutto questo sia possibile, l'azienda si avvale sia di risorse interne, come i
dipendenti, sia di risorse esterne, come consulenti e tirocinanti universitari.

In particolar modo, i tirocini universitari che si svolgono, hanno anche come scopo quello
di condurre ricerche su temi in voga, oppure sviluppare progetti utlizzando nuovi strumenti e
tecnologie, per le quali, ad esempio, non si conosce l'impatto futuro perché troppo giovani.

Questo non è solo un modo di procedere che l'azienda applica, ma una vera e propria cultura
aziendale, orientata alla sperimentazione e, quando possibile, all'adozione, di nuove tecnologie.

La collaborazione con partner esterni tra cui, esperti del settore, aziende leader e università
permette l'integrazione di diverse prospetive e competenze tecniche all'avanguardia, creando un
continuo ciclo di rinnovamento.
Basti pensare alle diverse figure che collaborano con Bluewind: dalle persone che aiutano a migliorare
i processi aziendali di produzione, ai consulenti per il miglioramento dell'ambiente di lavoro,
o ancora alle aziende partner, con le quali avvengono innumerevoli scambi di informazioni e conoscenze.
Inoltre, anche le università giocano un ruolo fondamentale, grazie ai confronti con professori universitari
nei temi più svariati.