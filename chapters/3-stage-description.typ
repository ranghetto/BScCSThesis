#import "@preview/glossarium:0.4.1": make-glossary, gls
#show: make-glossary

#pagebreak(to:"odd")

= Gestione operativa
<cap:stage-description>

#v(1em)
#text(style: "italic", [
  Il presente capitolo descrive quali sono stati i principali problemi affrontati durante il tirocinio e infine quali sono stati i frutti del lavoro svolto.
])
#v(1em)

== Tracciamento del lavoro

Il tracciamento del lavoro svolto, come anticipato, è stato fatto tramite il sistema di versionamento, nonché _ITS_, _Gitlab_.
Dal momento che non era richiesto seguire uno standard specifico, ho adottato un metodo che ritengo tanto efficace quanto semplice: documenti testuali.
Attraverso l'uso del formato #gls("md")#sub[G], ho sviluppato tutti i documenti tecnici che abbiamo ritenuto necessari al fine di supportare l'implementazione e i processi.
La documentazione di progetto che ho scritto, l'ho sviluppata seguendo le linee guida aziendali, per due ragioni principali:
- conformare i miei documenti, almeno nella forma, a quelli della ditta, in modo tale da renderne più semplice la fruizione da parte dei colleghi;
- provare l'efficacia delle linee guida stesse attraverso la loro implementazione.

I documenti di progetto che ho scritto sono:
- _Technical Specification_: la specifica tecnica, documento nel quale ho elencato e spiegato le scelte progettuali e architetturali fatte. Esso contiene anche
  il tracciamento dei requisiti, ossia il loro stato rispetto al progetto.
- _Software Requirement Specification_, la specifica dei requisiti _software_, documento nel quale ho inserito una descrizione delle interfacce _hardware_ e _software_ esterne,
  i vincoli progettuali, le dipendenze e la descrizione dei #gls("hlr")#sub[G], dei quali se ne mostra una parte nella @req.
- _Low Level Requirements_: #gls("llr")#sub[G], documento specifico per i requisiti di basso livello in cui, oltre a descriverli, ho creato una mappatura tra essi e quelli di alto livello.

#block[
  #figure(
    block[
      #set text(size: 10pt, style: "italic");
      #set par(leading: 0.65em);
      #table(
        align: left,
        columns: 4,
        table.header([*ID*], [*Title*], [*Type*], [*Description*]),
        [FUN-01], [Initialization], [Functional], [Drvier shall enable the user to initialize the components with a configuration provided by the user itself.],
        [FUN-02], [Single conversion], [Functional], [Driver shall enable the user to perform a single conversion on a single input source.],
        [FUN-03], [Single continuous conversion], [Functional], [Driver shall enable the user to perform a cyclic serie of conversions on a single input source.],
        [...], [...], [...], [...],
        [FUN-05], [Multiple continuous conversions], [Functional], [Driver shall enable the user to perform a cyclic serie of conversions on multiple input sources, sequentially],
        [FUN-06], [Software conversion trigger], [Functional], [Driver shall enable the user to trigger a conversion, by software],
        [...], [...], [...], [...]
      )
    ],
    caption: [parte della tabella dei requisiti sviluppata all'interno del documento _Software Requirements Specification (SRS)_.]
  ) <req>
]

== Problemi progettuali e tecnologici affrontati

=== Analisi
Ho affrontato l'analisi del problema con un approccio ibrido.
Nella prima fase, nonché quella di maggiore importanza, ho analizzato con cura il codice implementato
dalla casa madre del microcontrollore in _C_. Questo mi ha prermesso di capirne il funzionamento e, assieme
alla lettura del manuale utente, di comprenderne a fondo le caratteristiche, specialmente quelle
elettroniche del componente _EVADC_.
Particolari dubbi mi sono sorti nel corso dello studio del manuale, legati proprio al lato elettronico,
per il quale avevo una conoscenza basica, legata solamente alla mia esperienza da autodidatta.

In questo processo ho iniziato a scrivere i documenti tecnici _Software Requirements Specification_ e
_Low Level Requirements_. Nella specifica dei requisiti, oltre ai requisiti stessi, era presente anche il
corrispondente diagramma dei casi d'uso, riportati singolarmente di seguito, da @uc1 a @uc6.

#figure(
  image("../images/uc1-5.svg", width: 100%),
  caption: [
    diagramma del caso d'uso numero 1, abbinato all'inclusione del numero 5.
  ],
)<uc1>
#figure(
  image("../images/uc2-5.svg", width: 100%),
  caption: [
    diagramma del caso d'uso numero 2, abbinato all'inclusione del numero 5.
  ],
)
#figure(
  image("../images/uc3-5.svg", width: 100%),
  caption: [
    diagramma del caso d'uso numero 3, abbinato all'inclusione del numero 5.
  ],
)
#figure(
  image("../images/uc4-5.svg", width: 100%),
  caption: [
    diagramma del caso d'uso numero 4, abbinato all'inclusione del numero 5.
  ],
)
#figure(
  image("../images/uc6.svg", width: 50%),
  caption: [
    diagramma del caso d'uso numero 6.
  ],
)<uc6>

Durante l'analisi ho anche sviluppato il primo #gls("mvp")#sub[G], cioè un'implementazione del _software_
basilare, priva di una documentazione dettagliata, atta a fornire riscontri rapidi in merito alle
funzionalità che essa fornisce.
I risultati dell'_MVP_ sono stati:
- la conferma delle ultime nozioni acquisite, in merito all'implementazione originale del _software_ di
  controllo della periferica _EVADC_;
- l'ottenimento di importanti informazioni tecniche di funzionamento del microcontrollore che altrimenti
  non avrei scoperto fino alla fase di implementazione, cioè dopo la fase progettuale.
  Per fare un esempio, alcune di queste informazioni erano legate alla relazione tra registri di configurazione e di
  sicurezza. Bisognava infatti modificare opportunamente il valore di questi ultimi per poter configurare
  la periferica con successo.

=== Progettazione

La progettazione mi ha portato alla creazione di diversi diagrammi, tutti originariamente scritti
in notazione _UML 2.0_ e riportati di seguito sotto forma di immagini, con le opportune considerazioni e
tradotti in italiano.
Essi sono stati poi inseriti all'interno del documento _Technical Specification_.

==== Macchina a stati finiti

Il primo tra tutti è stato il diagramma a stati finiti.
Gli stati rappresentano delle situazioni in cui il sistema si può trovare, ognuna con il proprio contesto,
collegate le une con le altre attraverso delle regole, in forma di passaggi da uno stato all'altro.
Inizialmente, pensavo di riuscire a garantire la correttezza di tutti i passaggi tra gli stati
a tempo di compilazione ma, come si può vedere anche dalla @fsmd, questo non è stato possibile, e sono dovuto
ricorrere ad una duplice gestione: sia a tempo di compilazione, sia a tempo di esecuzione.

Per capirlo non sono state sufficienti le fasi di analisi e progettazione. A loro ho dovuto affiancare anche
la costruzione di un secondo _MVP_, che comprendeva solamente la gestione degli stati, senza alcuna
funzionalità pratica, il che ha permesso di concentrarmi sulla creazione dell'architettura, piuttosto che
sui problemi legati al funzionamento del microcontrollore.

//TODO: approfondimento gestione stati typestate, tipo non puo' cambiare a run time

#figure(
  image("../images/fsmd.jpg", width: 93%),
  caption: [
    diagramma a stati finiti che rappresenta gli stati e le loro relazioni per ogni componente del sistema,
    in grassetto.
  ],
) <fsmd>

==== Diagramma delle classi

=== Implementazione
Problemi affrontati durante l'implmentazione.

=== Verifica e validazione
Problemi affrontati durante la verifica.

== Risultati ottenuti

=== Qualitativi
Descrizione della visione d'insieme del prodotto visto dal lato dell'utente.

=== Quantitativi
Descrizione della copertura dei requisiti soddisfatti e non, e quantità di prodotti.
