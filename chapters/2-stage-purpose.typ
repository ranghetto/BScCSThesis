#import "@preview/glossarium:0.4.1": make-glossary, gls
#show: make-glossary
#show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
 }
#set math.equation(numbering: num =>
    "(" + (str(counter(heading).get().at(0)) + "." + str(num)) + ")"
)
#set figure(numbering: num =>
    str(counter(heading).get().at(0)) + "." + str(num)
)

#pagebreak(to: "odd")

= Scopo del tirocinio
<cap:stage-purpose>

#v(1em)
#text(style: "italic", [
  In questo capitolo espongo le idee che hanno messo le basi per la
  formalizzazione della proposta di stage, assieme alla risposta al fine di
  realizzarle.
])
#v(1em)

== Rapporto azienda - _stage_

_Bluewind_ sfrutta a pieno i tirocini universitari, soprattutto quelli che prevedono un
piano di lavoro definito e che portano alla creazione di un progetto o allo studio mirato e
consapevole di una nuova tecnologia.

Il triplice scopo dell'azienda, ha alla base mettere in discussione i processi aziendali di
sviluppo di un progetto. I colleghi sono i primi con cui è possibile confrontarsi e discutere
su quali possano essere le metodologie più adatte per lo specifico tirocinio.
La discussione ha la finalità di trovare una strada da poter replicare in futuro, avendo già fatto
un'analisi sul perché essa sia la più indicata.
Oltre a ciò, il confronto con i colleghi migliora entrambe le parti in gioco, creando una visione più ampia,
che spesso porta a conclusioni diverse da quelle pensate inizialmente.

Il secondo scopo è legato al progetto stesso, che sia sviluppo o ricerca.
Infatti l'azienda è molto attiva quando si parla di studio e implementazione di nuove
tecnologie, mettendosi in prima linea per conoscerle e provarle.
Tutto ciò che può portare all'azienda un vantaggio competitivo vale la pena di essere, come
minimo, conosciuto.
Se si tratta di progetti di sviluppo di un prodotto, il vantaggio è ovviamente quello di poterlo
utilizzare, così come viene fornito, o usandolo come base di partenza per ulteriori sviluppi.
Lo stesso ha valore anche per i progetti di ricerca.

Il terzo scopo, ma non per importanza, è sicuramente legato al fattore assunzioni.
L'azienda ha la possibilità, per qualche mese, di vedere e studiare le capacità dei tirocinanti,
decidendo poi se vale la pena fare loro una proposta di assunzione.
Oltre a questo, gli studenti avranno già fatto, al termine del loro _stage_, un po' di formazione
riguardo gli strumenti adottati da _Bluewind_ e quindi l'integrazione potrà essere più veloce.

== Panoramica del progetto

=== Scopo

Il codice attualmente presente nei sistemi in produzione è ancora prevalentemente scritto in _C_. Nonostante
le aziende che operano nel settore automobilistico, attingano ai più moderni _standard_ per la creazione di
_software_, a volte non è sufficiente a garantire che esso sia sicuro e affidabile.
Inoltre, vista la natura stessa del linguaggio _C_, il codice che ne deriva può risultare difficile da leggere
e _mantenere_.
Lo scopo del mio tirocinio era l’implementazione di un _driver_ in _Rust_, in @rust-eco chiamato
_Rust Peripheral Driver_, per la gestione della
periferica _EVADC_ su microcontrollori per applicazioni #gls("autom")#sub[G], in particolare l'_Infineon
Aurix TC375_.

A seguito o in parallelo alla parte implementativa avevamo pensato ad una fase di analisi
su due temi rilevanti per il dominio della #gls("sfun")#sub[G] #super[@iecch], ossia l'insieme di
tutte le misure automatiche che si adottano al fine di aumentare l'affidabilità e la sicurezza
del sistema:
- un’indagine generale sui vantaggi e/o svantaggi di utilizzo di _Rust_ per librerie di basso
  livello, tenendo conto anche della sua ripida curva di apprendimento;
- un’indagine sulla possibilità, ed eventuali modalità preferibili di progettazione, del _driver_ per evitare
  errori di configurazione della periferica in modo statico, cioè a tempo di compilazione,
  con la possibilità di tracciamento delle regole di configurazione rispetto ai manuali tecnici
  del microcontrollore.

  #figure(
    image("../images/rust_ecosystem.png", width: 100%),
    caption: [
      rappresentazione dello stato attuale dell'ecosistema di sviluppo _Rust_ nel mondo _Aurix_,
      bordo arancione, paragonato al corrispondente ecosistema _C_, bordo grigio. #super[@hightec_rdp]
    ],
  ) <rust-eco>

#pagebreak()

=== Obiettivi e attese

Gli obiettivi principali erano tre:

+ L’implementazione di un _driver_ in _Rust_ per la gestione della periferica _EVADC_ su
  microcontrollori della famiglia _Infineon Aurix TC3xx_ per applicazioni _automotive_.
  Lo scopo di tale obiettivo era ovviamente avere un prodotto funzionante da poter utilizzare alla necessità.
  Implementare il _driver_ ci avrebbe permesso anche di incrementare la bontà dell'architettura e la sua usabilità.
+ Indagine sulla possibilità, ed eventuali modalità preferibili di progettazione, del _driver_
  per evitare errori di configurazione della periferica in modo statico, cioè a tempo di
  compilazione, con la possibilità di tracciamento delle regole di configurazione rispetto
  ai manuali tecnici del microcontrollore.
  L'idea di questo obiettivo, nasce dalle precedenti esperienze nella programmazione a basso livello, dove errori
  di configurazione erano semplici di inserire. Volevamo creare un'interfaccia sicura dal punto di vista funzionale,
  pur garantendo un'architettura ricca di funzionalità.
+ Esperimento di integrazione di uno strumento di #gls("verfor")#sub[G] tramite il quale è possibile
  dichiarare e verificare proprietà logiche direttamente sul codice sorgente _Rust_, come
  raccomandato dallo standard _ISO 26262_ per alti livelli di integrità della
  _sicurezza funzionale_.
  La verifica formale ci avrebbe permesso di controllare, a tempo di compilazione, tutte quelle proprietà _hardware_ che
  il compilatore, attraverso l'architettura, non sarebbe stato in grado di verificare.

#figure(
  image("../images/esempio_manuale_tc37x.png", width: 100%),
  caption: [
    tabella 260 del manuale utente #super[@tc37x_user_manual] della famiglia di microcontrollori _Infineon Aurix TC37X_
    che rappresenta la configurazione del modulo _EVADC_.
  ],
)

A questi, durante il corso del progetto e in accordo con i miei tutor, ne ho aggiunti altri;
all'inizio non erano stati pensati, ma sono risultati interessanti al fine di approfondire
meglio i temi trattati:

- indagine sull'utilizzo di strumenti per la programmazione ed il _debug_ del codice,
  pensati per il linguaggio _C_, usando _Rust_
- indagine e confronto su strumenti che facilitano lo sviluppo in _Rust_ rispetto a quelli già
  conosciuti per _C_.

Nell'insieme, gli obiettivi portano alla luce come _Bluewind_ stia puntando, così come molti altri, ad
implementare questa tecnologia, _Rust_, all'interno dei suoi progetti. Infatti, crede che essa possa
radicalmente cambiare il settore e ammodernarlo, portando vantaggi ai clienti finali, così come ai team
di sviluppo.

I principali prodotti attesi, derivanti dagli obiettivi erano:
- una #gls("crate")#sub[G], in pratica una libreria _software_ _Rust_, con l'implementazione del _driver_;
- documentazione architetturale e di dettaglio sul _driver_ sviluppato;
- un _report_ sulle indagini e gli esperimenti citati sopra.

=== Metodo di lavoro
<sec:working-method>
Al fine di avere un quadro chiaro degli obiettivi, dei prodotti attesi e delle tempistiche entro
le quali avrei svolto il lavoro, ho stilato assieme ai miei tutor un piano di lavoro che poi
abbiamo sottoposto, per approvazione, al professore responsabile dei tirocini.
Il documento specificava con particolare attenzione una scaletta di attività,
divise su base settimanale, che si può riassumere nella seguente tabella:

#figure(
  table(
    align: left,
    columns: 2,
    table.header(
      table.cell(align: center)[*Nr. Settimana*],
      table.cell(align: center)[*Descrizione Attività*]
    ),
    table.cell(align: right)[1], [Introduzione al microcontrollore. \ Selezione delle funzionalità da implementare.],
    table.cell(align: right)[2], table.cell(rowspan: 2, breakable: false)[Modellazione transizione tra stati. \ Proposta di progettazione.],
    table.cell(align: right)[3],
    table.cell(align: right)[4], table.cell(rowspan: 2, breakable: false, align: horizon)[Implementazione del _driver_],
    table.cell(align: right)[5],
    table.cell(align: right)[6], [Test e confronto con librerie in _C_ esistenti],
    table.cell(align: right)[7], [Esperimento di integrazione di uno strumento di verifica formale],
    table.cell(align: right)[8], [Collaudo finale e retrospettiva del progetto],
  ), caption: [rappresentazione del lavoro organizzato in settimane all'interno del piano di lavoro.]
)
Oltre al collaudo finale, ogni settimana prevedeva una giornata di analisi e
retrospettiva legata al singolo periodo, per valutare il raggiungimento degli obiettivi prefissati.

Per la natura stessa del progetto e, per mettere alla prova le metodoglogie aziendali, abbiamo
adottato un metodo di lavoro, costruito sulla base del _framework_ #gls("scrum")#sub[G].
Esso prevede che il lavoro sia suddiviso in iterazioni chiamate _sprint_, piccole sezioni di tempo,
solitamente della durata di una o due settimane, che prevedono:
- all'inizio dello _sprint_, una pianificazione del lavoro da svolgere, in un evento chiamato
  _Sprint Planning_;
- durante lo _sprint_, lo svolgimento dei compiti assegnati
- giornalmente, un aggiornamento del lavoro svolto, durante i cosiddetti _Sprint Daily_;
- al termine dello _sprint_, un aggiornamento, solitamente al cliente, del lavoro svolto,
  al fine di raccogliere riscontri e/o consigli, durante la _Sprint Review_
- infine, durante la _Sprint Retrospective_, una discussione su quali sono stati
  i problemi affrontati e quali potrebbero essere le migliorie che si possono adottare per
  incrementare l'efficienza ed efficacia.

Durante il corso del progetto, le iterazioni da noi stabilite erano della durata di una settimana,
durante la quale svolgevamo solamente un sottoinsieme degli eventi dettati dal _framework_:
- la pianificazione è stata fatta all'inizio del percorso e ritoccata solamente a causa di alcune
  incogruenze tra gli impegni personali. Infatti l'idea di cosa andava fatto, e con quale priorità,
  era chiara fin dall'inizio, rendendo superflua la necessità di una pianificazione settimanale.
- gli aggiornamenti giornalieri invece, si sono svolti regolarmente;
- anche le revisioni di avanzamento a fine _sprint_ le abbiamo svolte con regolarità, spesso
  unendole ad un breve confronto sul lavoro da svolgere per l'iterazione successiva.

In particolar modo gli eventi giornalieri, ci hanno permesso di rimanere sempre allineati sul
lavoro in corso d'opera. Di conseguenza è stato impossibile uscire dai tempi previsti, merito
anche della corretta stima temporale iniziale.
Il tirocinio ha confermato come, l'uso di un _framework_ specializzato, possa fare la differenza,
non solo quando viene utilizzato da _team_ con un discreto numero di membri,
ma anche quando i _team_ sono molto ridotti, come nel nostro caso.

=== Vincoli documentali

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

== Obiettivi personali

L'obiettivo primario che mi ero fissato era uscire dalla
mia zona di _comfort_, andando ad esplorare un mondo che fino a quel
momento avevo visto solamente a livello amatoriale.
Questo avrebbe permesso di provare a me stesso che sono in grado di adattarmi
velocemente a situazioni nuove, pur trovandomi, inizialmente, spaesato.
Praticamente:
- imparare a leggere e capire il manuale utente di un microcontrollore, comprendendo il funzionamento
    dei diversi componenti e la funzione dei registri delle periferiche;
- imparare a leggere uno schema elettrico, capendo le connessioni tra i componenti esterni e quelli interni;
- imparare a scrivere _software_ di basso livello, lavorando senza un sistema operativo e con strutture
    vicine al linguaggio macchina;
erano parte del bagaglio di conoscenze che volevo guadagnare in questa esperienza.

Il secondo obiettivo era legato all'apprendimento vero e proprio.
Volevo conoscere e toccare con mano cosa significa scrivere _software_ a basso livello,
quali sono le sfide e i problemi che si affrontano ogni giorno.
Oltre al fatto che le mie nozioni di elettronica erano molto limitate, e questa esperienza
mi avrebbe permesso di ampliarle notevolmente.
Anche il fatto che _Bluewind_ lavori principalmente nel settore della _sicurezza funzionale_,
mi ha garantito l'apprendimento di metodi e tecnologie atte allo sviluppo di _software_
certificabile.
Nello specifico, volevo compiere i seguenti punti:
- imparare quali strumenti e metodi si usano per scrivere codice conforme a determinati _standard_;
- ampliare le mie conoscenze di programmazione in _Rust_, in particolare capire quali fossero le strutture dati
    più adatte per scrivere codice di basso livello;
- arricchire il bagaglio di conoscenze legato ai metodi per lo sviluppo _software_, in ambiente professionale,
    principalmente per quanto concerne il metodo _agile_ e il _framework Scrum_.

Terza e ultima considerazione riguarda la carriera lavorativa. Volevo raggiungere gli obiettivi
citati sopra per aprirmi, nel caso mi fosse interessato, una strada verso questo settore.
Perciò l'obiettivo era trovare lavoro, nell'azienda stessa o in altre, che si occupassero di
sistemi di controllo e sicurezza funzionale, in settori dove i margini di fallimento sono minimi.