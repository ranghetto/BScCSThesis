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
dalla casa madre del microcontrollore in _C_. Farlo, mi ha permesso di capirne il funzionamento e, assieme
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
in notazione #gls("uml")#sub[G], lo standard per la creazione di diagrammi tecnici, e riportati di seguito sotto forma di immagini, con le opportune considerazioni.
Essi sono stati poi inseriti all'interno del documento _Technical Specification_.

==== Macchina a stati finiti

Il primo tra tutti è stato il diagramma a stati finiti.
Gli stati rappresentano delle situazioni in cui il sistema si può trovare, ognuna con il proprio contesto,
collegate le une con le altre attraverso delle regole, in forma di passaggi da uno stato all'altro.
Inizialmente, pensavo di riuscire a garantire la correttezza di tutti i passaggi tra gli stati
a tempo di compilazione ma, come si può vedere anche dalla @fsmd, questo non è stato possibile, e sono dovuto
ricorrere ad una duplice gestione: sia a tempo di compilazione, sia a tempo di esecuzione.
La principale differenza tra le due è che la correttezza della prima viene direttamente garantita
dal compilatore, ancor prima di eseguire il programma, il che porta numerosi vantaggi in termini
di affidabilità e di sicurezza. La seconda invece viene garantita solo tramite il codice, che andrà
opportunamente verificato, ma per il quale non avremo mai la certezza matematica della mancanza di errori.

Per capire di avere la necessità di una gestione divisa tra compilazione e esecuzione, non mi sono state
sufficienti le fasi di analisi e progettazione. A loro ho dovuto affiancare anche
la costruzione di un secondo _MVP_, che comprendeva solamente la gestione degli stati, senza alcuna
funzionalità pratica, il che ha permesso di concentrarmi sulla creazione dell'architettura, piuttosto che
sui problemi legati al funzionamento del microcontrollore.

#figure(
  image("../images/fsmd.jpg", width: 93%),
  caption: [
    diagramma a stati finiti che rappresenta gli stati e le loro relazioni per ogni componente del sistema,
    in grassetto.
  ],
) <fsmd>

==== Diagramma delle classi

Il diagramma delle classi rappresenta la struttura architetturale e come gli elementi in essa siano legati
tra di loro.
Il suo scopo è anche quello di descrivere, ad alto livello, quali modelli progettuali si vogliono adottare,
senza specificarne in dettaglio l'implementazione, che potrebbe cambiare da linguaggio a linguaggio.

Utilizzando la notazione _UML_ più recente, e le mie conoscenze pregresse, è stato comunque difficile
descrivere alcune parti dell'architettura, a causa della scelta "obbligata" dell'uso di _Rust_.
Infatti il linguaggio scelto offre un paradigma di programmazione che si discosta dai canoni classici e di
conseguenza risulta più difficile da rappresentare. Dovendo scegliere, ho preferito chiarezza e
comprensibilità piuttosto di correttezza della sintassi _UML_.

Il primo esempio riguarda l'uso delle #gls("tuple")#sub[G]. In _Rust_ una _tuple_ è una collezione di valori di
diversi tipi (o anche di tipi uguali). Ogni _tuple_ è un valore a se stante e il suo tipo è formato
dall'insieme dei tipi dei suoi membri:
#figure(
```rust
// Esempio di una tuple che rappresenta un punto in uno spazio bi-dimensionale.
// Il tipo è (i32, i32).
struct Punto(i32, i32);

// Rappresentazione di un punto tramite valori a virgola mobile.
// Il tipo è (f32, f32);
struct PuntoPreciso(f32, f32);

// Rappresentazione di una persona tramite due campi: nome e età.
// Il tipo è (String, u8).
struct Persona(String, u8);
```, caption: [esempio di rappresentazione di diverse _tuple_ in _Rust_.])
I tipi composti, come in questo caso, non sono facilmente rappresentabili in notazione _UML_ e quindi
sono ricorso alla creazione di una classe apposita, avente membri chiamati con i numeri.
Per definire poi _tuple_ di diverso tipo, ho usato la notazione tra parentesi angolate, utilizzando lettere
diverse per singolo tipo.

#figure(
  image("../images/class_diagram_tuples.jpg", width: 100%),
  caption: [
    quattro classi nel diagramma omonimo che mostrano la convenzione adottata per le _tuple_.
  ],
)

Altro esempio in cui ho preferito rendere esplicito un concetto di _Rust_ è stato per l'#gls("ownership")#sub[G].
Questa caratteristica impone una serie di regole su come sono gestiti i valori:
+ ogni valore deve avere un proprietario;
+ ci può essere un solo proprietario per volta;
+ quando il proprietario esce dal contesto, il valore viene liberato.
Per fare un esempio pratico:
#figure(
```rust
struct Quartiere {
  villa_16b: Edificio,
  bifamiliare_21a: Edificio,
  bifamiliare_21b: Edificio,
}

// agenzia diventa il proprietario di un quartiere con tre edifici
let agenzia = Quartiere::new();

// alice diventa proprietario della villa, dopo averla comprata dall'agenzia
let casa_di_alice = agenzia.villa16b;

// bob vorrebbe acquistare la stessa villa dall'agenzia
// ma questo non è possibile perché la villa adesso è di proprietà di alice
let casa_di_bob = agenzia.villa16b; // ERRORE DI COMPILAZIONE
```,
  caption: [esempio del concetto di _ownership_ in _Rust_.]
)

//TODO: gls("singleton")
Quindi i valori dei membri si potrebbero definire come dei _singleton_ per ogni istanza di classe;
volevo far trasparire anche dal diagramma che i membri di alcune particolari classi potessero essere
unici in tutto il programma. Per esempio, ho usato la proprietà per garantire che un componente
elettronico non potesse essere utilizzato due volte per fare la stessa operazione, il che avrebbe
portato a errori logici difficili da scovare.
Di conseguenza anche nella rappresentazione in _UML_ ho dovuto creare un tipo specifico per rappresentare
questa caratteristica e l'ho chiamato `InsanceSingleton<T>` dove `T` è il tipo del membro effettivo.

Ci tengo a sottolineare come questa scelta sia stata presa in favore di uno degli scopi principali del
progetto: garantire a tempo di compilazione una correttezza dal punto di vista logico, rispetto al
funzionamento del microcontrollore.
Non sarebbe stato possibile avere la stessa garanzia utilizzando un modello _singleton_ oppure lasciando
il controllo a metodi e funzioni.

#figure(
  image("../images/class_diagram_ownership.jpg", width: 100%),
  caption: [
    una classe del diagramma omonimo contenente membri che rappresentano il concetto di _ownership_ in _Rust_.
  ],
)

//TODO: sezione esempio tipo di ritorno dinamico

// ==== Diagramma di sequenza

=== Implementazione
Problemi affrontati durante l'implmentazione.

=== Verifica e validazione
Problemi affrontati durante la verifica.

== Risultati ottenuti

=== Qualitativi
Descrizione della visione d'insieme del prodotto visto dal lato dell'utente.

=== Quantitativi
Descrizione della copertura dei requisiti soddisfatti e non, e quantità di prodotti.
