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
corrispondente diagramma dei casi d'uso.

#figure(
  image("../images/uc1-5.svg", width: 100%),
  caption: [
    diagramma del caso d'uso numero 1, abbinato all'inclusione del numero 5.
  ],
)<uc1>
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
la costruzione di un secondo _MVP_, che comprendeva solamente la gestione degli stati,
senza alcuna funzionalità pratica. Ciò mi ha permesso di concentrare i miei sforzi
sulla creazione dell'architettura, piuttosto che sui problemi legati al funzionamento del
microcontrollore.

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

// Rappresentazione di una persona tramite due campi: nome ed età.
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

Quindi i valori dei membri si potrebbero definire come dei #gls("singleton")#sub[G] per ogni istanza di classe;
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
  image("../images/class_diagram_ownership.jpg", width: 70%),
  caption: [
    una classe del diagramma omonimo contenente membri che rappresentano il concetto di _ownership_ in _Rust_.
  ],
)

//TODO: ampliare sezione
=== Implementazione

L'implementazione è stata il processo che è durato meno tempo; considerando il lavoro svolto a
priori rientrava nella pianificazione effettuata a inizio tirocinio.

Durante questo processo, mentre sviluppavo, uno dei miei tutor si occupava di provare ad usare la
libreria _software_, per dare un riscontro immediato sull'usabilità della stessa.
Il lavoro congiunto mi ha permesso di migliorarne notevolmente semplicità e comprensibilità da
parte dell'utente finale, oltre che a permettermi di trovare immediatamente errori logici di
programmazione.

Per fare in modo di garantire una buona usabilità, ho creato un digramma di sequenza, che mostrava
la relazione temporale tra l'uso dei diversi componenti _software_ dell'applicazione.
In particolare, si faceva vedere come le chiamate ai metodi e alle funzioni potevano essere usate
in un particolare caso d'uso. Di seguto riporto una sezione di tale diagramma.

#figure(
  image("../images/sequence_diagram_section.jpg", width: 100%),
  caption: [
    sezione iniziale del diagramma di sequenza creato durante il tirocinio.
  ],
)

Durante l'implementazione mi sono anche accorto di come i microcontrollori, facenti parte della stessa famiglia,
avessero caratteristiche, rispetto al modulo _EVADC_, molto simili. L'unica differenza era nel numero di
_ADC_ presenti e nella loro distribuzione.
Così abbiamo aggiunto la possibilità di compilare il codice per due diverse schede, utilizzando un comando specifico
in fase di compilazione.
Il risultato di questo ulteriore vincolo di progettazione, aggiunto in corso d'opera, ci ha garantito che
il _driver_ sviluppato, potrà essere sviluppato in unica soluzione e poi configurato in
base al microcontrollore scelto. Di conseguenza il codice alla base risulta più facilmente manutenibile e
privo di discrepanze tra versioni per diversi microcontrollori.

=== Verifica e validazione

La prima validazione l'abbiamo eseguita facendo corrispondere, nella tabella di tracciamento,
i requisiti, con l'implementazione dell'architettura che li soddisfava.
Successivamente ho compiuto delle prove manuali direttamente sulla scheda elettronica,
andando a verificare che tutti i casi d'uso fossero coperti e che venissero rispettate le
attese in termini di funzionalità.

Non abbiamo implementato alcuna prova automatica del _software_ principalmente a causa del tempo
e della priorità che essa aveva rispetto ad altre attività.
Di fatto, una prova molto interessante è avvenuta nel campo della verifica formale.

Ho provato ad integrare _Prusti_, uno strumento di verifica formale, utile per provare la
correttezza di proprietà logiche a tempo di compilazione, cioè in modo statico, senza eseguire
codice.
In generale questi strumenti trasformano il codice, e le condizioni che
si vogliono verificare, in una forma tale per cui possano essere controllate matematicamente.
Tuttavia, lo scopo del suo utilizzo non era capirne il funzionamento nel dettaglio,
bensì fare uno studio sulla semplicità di utilizzo e implementazione, pur non sapendone i
dettagli implementativi.

#figure(
```rust
// Scriviamo una funzione che ritorna un valore minore o uguale a 10
// La sua precondizione è che può accettare valori da 0 a 5 (compresi)
// Non è necessario indicare che n deve essere >= 0, Prusti è abbastanza intelligente da dedurlo dal tipo
#[requires(n <= 5)]
#[ensures(result <= 10)]
fn numero_minore_di_10(n: u8) -> u8 {
    return 5 + n;
}

fn main() {
    let n: u8 = 3;
    // La prova in questo caso è verificata perché entrambe le condizioni sono vere
    print_u8(numero_minore_di_10(n));

    let n: u8 = 7;
    // In questo caso invece la prova fallirebbe
    print_u8(numero_minore_di_10(n));
}
```,
  caption: [
    esempio di funzione con una pre-condizione e una post-condizione, scritta in _Rust_ attraverso la libreria _Prusti_.
  ],
)

== Risultati ottenuti

==== Qualitativi

I risultati qualitativi più rilevanti sono sicuramente nell'ambito della sicurezza funzionale, infatti moltissimi
degli errori legati alla memoria di _C_ sono stati evitati grazie al semplice uso di _Rust_. Il risultato rafforza
lo studio effettuato da Shea Newton @polysync_misra_rust, riguardo a _MISRA_, uno _standard_ per il linguaggio _C_ che
prevede regole rigide riguardo alla scrittura del codice, dove ha evidenziato come solo trentacinque delle
centoquarantacinque regole _MISRA_ analizzate si applicassero anche a _Rust_. Le conseguenze sono rilevanti:
minor tempo per provare il codice e difficoltà nell'introdurre determinate classi di errori, con conseguente
miglioramento del _software_ in termini di sicurezza e manutenibilità.

Un risultato che ha apportato un milgioramento al processo di analisi è stato in merito alla scrittura dei requisiti.
Partendo da una base comune abbiamo introdotto nuovi punti di vista e diversi approcci per affrontare requisiti di
un prodotto che non verrà mai utilizzato da solo, ma solamente come supporto alle operazioni di sistemi più grandi.

Lo studio che ho condotto ha svelato in oltre come l'ecosistema _Rust_ non sia ancora del tutto pronto ad essere
integrato nei sistemi esistenti in produzione.
Uno dei problemi principali sono le versioni che vengono rilasciate: per accedere alle ultime funzionalità
del linguaggio bisogna usare versioni recenti, ma molti strumenti sono stati costruiti per versioni più vecchie e non
sono più stati aggiornati.
Rilasciando così tante versioni del linugaggio in poco tempo, visto che si tratta di una tecnologia in rapida crescita,
è difficile per gli sviluppatori tenere aggiornate le librerie _software_.
Anche durante il mio tirocinio abbiamo dovuto investire molto tempo nello scovare errori legati a questa problematica,
spesso trovando soluzioni temporanee.

==== Quantitativi

I prodotti creati sono i seguenti:
- una libreria _software_ contenente il codice per l'uso del modulo _EVADC_ per i microcontrollori _Infineon TC37X_ e
  _TC39X_;
- documento di specifica tecnica della libreria;
- documento di specifica dei requisiti della libreria;
- docuemnto di specifica dei requisiti di basso livello della libreria;
- resoconto sull'utilizzo dello strumento _UDE_ con _Rust_;
- resoconto su vantaggi e svantaggi dell'uso del modello architetturale _typestate_;
- resoconto su vantaggi e svantaggi dell'uso dello strumento _Prusti_ per la verifica formale;
- lucidi di presentazione del lavoro svolto per spiegazione ai colleghi.

