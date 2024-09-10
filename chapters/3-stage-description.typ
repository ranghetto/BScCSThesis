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

#pagebreak(to:"odd")

= Svolgimento del progetto
<cap:stage-description>

#v(1em)
#text(style: "italic", [
  Nel presente capitolo descrivo quali sono state le attività e
  i frutti del lavoro. Nel capitolo mostrerò anche un esempio, di una sezione del progetto,
  di tutte le attività svolte, al fine di dare concretezza al contesto.
])
#v(1em)

== Attività e nuovi approcci

=== Analisi

Ho affrontato l'analisi del problema con un approccio ibrido.
Nella prima fase, nonché quella di maggiore importanza, ho analizzato con cura il codice implementato
dalla casa madre del microcontrollore in _C_. Farlo, mi ha permesso di capirne il funzionamento e, assieme
alla lettura del manuale utente, di comprenderne a fondo le caratteristiche, specialmente quelle
elettroniche del componente _EVADC_.
Particolari dubbi mi sono sorti nel corso dello studio del manuale, legati proprio al lato elettronico,
per il quale avevo una conoscenza basica, legata solamente alla mia esperienza da autodidatta.

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

In questo processo ho iniziato a scrivere i documenti tecnici _Software Requirements Specification_ e
_Low Level Requirements_. Nella specifica dei requisiti, oltre ai requisiti stessi, era presente anche il
corrispondente diagramma dei casi d'uso.
I requisiti raccolti, frutto dei casi d'uso, andavano a coprire un insieme di funzionalità considerato minimo per
l'utente medio di una libreria di questo tipo.
Per trovare l'insieme minimo, ci siamo confrontati con un collega, che aveva avuto diverse esperienze di utilizzo del
modulo _EVADC_ da parte dei clienti, che ci ha dato una visione sulle caratteristiche più usate.
In tutto ho prodotto quindici requisiti funzionali e cinque requisiti di vincolo, per un totale di venti.
Di seguito riporto una sezione della tabella dei requisiti, modificata per includere tutti i dati, che erano divisi nei
vari documenti:

#figure(
  image("../images/req_example.png", width: 100%),
  caption: [
    rappresentazione dei dati raccolti, in forma tabellare, per una parte dei requisiti.
  ],
)

Durante l'analisi ho anche sviluppato il primo #gls("proof")#sub[G], cioè un'implementazione del _software_
basilare, priva di una documentazione dettagliata, atta a fornire riscontri rapidi in merito alle
funzionalità che essa fornisce.
I risultati del _PoC_ sono stati:
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
la costruzione di un secondo _PoC_, che comprendeva solamente la gestione degli stati,
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
descrivere alcune parti dell'architettura, spiegate di seguito, a causa della scelta "obbligata" dell'uso di _Rust_.
Infatti il linguaggio scelto offre un paradigma di programmazione che si discosta dai canoni classici e di
conseguenza risulta più difficile da rappresentare. Dovendo scegliere, ho preferito chiarezza e
comprensibilità piuttosto di correttezza della sintassi _UML_.

Il primo esempio riguarda l'uso delle #gls("tuple")#sub[G]. In _Rust_ una _tuple_ è una collezione di valori,
anche di diverso tipo. Ogni _tuple_ è un valore a se stante e il suo tipo è formato
dall'insieme dei tipi dei suoi membri:
#figure(
```rust
// [...]

// Il tipo è (ModuleParts, ModuleMode).
struct ModuleSections(ModuleParts, ModuleMode);

impl EvadcModule<Initialized> {
    pub fn split(self) -> ModuleSections {
        return ModuleSections(
            ModuleParts::new(),
            ModuleMode::Disabled(EvadcModule {
                _marker: PhantomData,
            }),
        );
    }
}
```, caption: [esempio di rappresentazione e utilizzo di una _tuple_ in _Rust_])
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
pub struct PrimaryClusterParts<G: ConverterGroup> {
    pub ch0: EvadcChannel<Unitialized, G>,
    pub ch1: EvadcChannel<Unitialized, G>,
    pub ch2: EvadcChannel<Unitialized, G>
}

// [...]

// g0_parts è di tipo PrimaryClusterParts, che contiente tre canali
let ch0 = g0_parts.ch0.initialize(&config);

// Un errore di battitura come questo, in cui proviamo a reinizializzare il ch0, ci
// da un errore di compilazione, spiegandoci che il ch0 è già stato "preso" nella
// riga sopra
let ch1 = g0_parts.ch0.initialize(&config); // ERRORE DI COMPILAZIONE
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

=== Implementazione

L'implementazione è stata l'attività che è durata meno tempo; considerando il lavoro svolto a
priori, rientrava nella pianificazione effettuata a inizio tirocinio.

Durante questa attività, mentre sviluppavo, uno dei miei tutor si occupava di provare ad usare la
libreria _software_, per dare un riscontro immediato sull'usabilità della stessa.
Il lavoro congiunto mi ha permesso di migliorarne notevolmente semplicità e comprensibilità da
parte dell'utente finale, oltre che a permettermi di trovare immediatamente errori logici di
programmazione.

Per fare in modo di garantire una buona usabilità, ho creato un diagramma di sequenza, che mostrava
la relazione temporale tra l'uso dei diversi componenti _software_ dell'applicazione.
In particolare, si faceva vedere come le chiamate ai metodi e alle funzioni potevano essere usate
in un particolare caso d'uso. Di seguto riporto una sezione di tale diagramma.

#figure(
  image("../images/sequence_diagram_section.jpg", width: 100%),
  caption: [
    sezione iniziale del diagramma di sequenza creato durante il tirocinio.
  ],
)

Nonostante la creazione dei due _PoC_, durante la fase di implementazione, le sfide non sono mancate.
In particolar modo voglio descrivere la più significativa, ossia quella legata al modello di progettazione chiamato
#gls("ts")#sub[G].
Il _typestate pattern_ si può collocare nei modelli progettuali comportamentali e
serve a codificare le informazioni di stato, a tempo di esecuzione, di un oggetto,
nel suo tipo a tempo di compilazione; proprio per questo è preferibile al
_builder pattern_, dove i controlli sullo stato di avanzamento di costruzione di un
oggetto sono fatti durante l'esecuzione.
Questo è utile soprattutto nel momento in cui si vogliono far rispettare determinati
contratti, come nel nostro caso la configurazione, che doveva avvenire in un ordine
specifico, assicurandosi di non saltare nessun passaggio.
Questo è il caso per quasi tutti gli oggetti configurabili del _driver_ che ho
sviluppato.

Ci tengo a sottolineare che per noi era fondamentale riuscire a gestire la configurazione a tempo di compilazione.
Infatti il rischio, se non si adotta questa pratica, è quello di introdurre errori difficilissimi da trovare e
risolvere; senza considerare il rischio, nel peggiore dei casi, di rompere la scheda.
Il precedente _driver_, sviluppato in _C_, implementava alcune funzionalità lasciando all'utente la piena responsabilità
delle sue azioni, permettendogli quindi di creare configurazioni sbagliate.
La difficoltà è stata, di conseguenza, quella di creare un'interfaccia che rimuovesse questa classe di errori, senza
inficiare sul numero di funionalità offerte, obiettivo che è stato raggiunto con successo.

Durante l'implementazione mi sono anche accorto di come i microcontrollori, facenti parte della stessa famiglia,
avessero caratteristiche, rispetto al modulo _EVADC_, molto simili. L'unica differenza era nel numero di
_ADC_ presenti e nella loro distribuzione.
Così abbiamo aggiunto la possibilità di compilare il codice per due diverse schede, utilizzando un comando specifico
in fase di compilazione.
Il risultato di questo ulteriore vincolo di progettazione, aggiunto in corso d'opera, ci ha garantito che
il _driver_, potrà essere sviluppato in unica soluzione e poi configurato in
base al microcontrollore scelto. Di conseguenza il codice alla base risulta più facilmente manutenibile e
privo di discrepanze tra versioni per diversi microcontrollori.

#figure(
```rust
// Definisco gli stati che il modulo può assumere
pub trait ModuleState {}
pub struct Unitialized {}
pub struct Initialized {}

// [...]

// L'unica azione permessa quando, si ha un modulo non inizializzato, è inizializzarlo con una configurazione
impl EvadcModule<Unitialized> {
    pub fn initialize(self, config: &EvadcModuleConfig) -> EvadcModule<Initialized> {
        // [...]
    }
}

impl EvadcModule<Initialized> {
    pub fn split(self) -> ModuleSections {
        // [...]
    }
}

let unitialized_module: EvadcModule<Unitialized> = EvadcModule::new();

// chiamare il metodo split non è consentito su un modulo non inizializzato
let sections = unitialized_module.split(); // ERRORE DI COMPILAZIONE

// [...]

let init_module = unitialized_module.initialize(&config);
let sections = init_module.split(); // Queste operazioni rispettano il contratto
```,
  caption: [esempio parziale di definizione e utilizzo di un contratto con il modello _typestate_ in _Rust_.]
)

=== Verifica e validazione

La prima validazione l'abbiamo eseguita facendo corrispondere, nella tabella di tracciamento,
i requisiti, con l'implementazione dell'architettura che li soddisfava.
Successivamente ho compiuto una prova manuale per ogni requisito, direttamente sulla scheda elettronica,
andando a verificare che tutti i casi d'uso fossero coperti e che venissero rispettate le
attese in termini di funzionalità.

Non abbiamo implementato alcuna prova automatica del _software_, principalmente a causa del tempo
e della priorità che esse avevano rispetto ad altre attività.
Di fatto, una prova molto interessante è avvenuta nel campo della verifica formale.

Ho provato ad integrare _Prusti_, uno strumento di verifica formale, utile per provare la
correttezza di proprietà logiche a tempo di compilazione, cioè in modo statico, senza eseguire
codice.
In generale questi strumenti trasformano il codice, e le condizioni che
si vogliono verificare, in una forma tale per cui possano essere controllate matematicamente.
Tuttavia, lo scopo del suo utilizzo non era capirne il funzionamento nel dettaglio,
bensì fare uno studio sulla semplicità di utilizzo, pur non sapendone i
dettagli implementativi.

#figure(
```rust
// Prusti cerca di assicurarsi che la configurazione passata in questo
// metodo abiliti il componente in questione
#[requires(config.queues[self.id].enabled)]
pub fn configure(&self, config: Configuration) {
    // [...]
}
```,
  caption: [
    esempio di funzione con una pre-condizione, scritta in _Rust_ attraverso la libreria _Prusti_.
  ],
)

== Esempio di creazione dell'architettura

Di seguito voglio fornire un esempio, completo di tutte le attività di analisi e progettazione, di una sezione
dell'intero progetto. La sezione in esame è l'inizializzazione del modulo _EVADC_.

Durante la fase preliminare dell'analisi, ho affrontato i programmi esistenti, cioè gli esempi di utilizzo scritti in _C_,
proposti dalla casa madre del microcontrollore.
Oltre a provare il loro funzionamento direttamente sull'_hardware_, ho stilato una lista di vincoli e operazioni
necessarie, al fine di inizalizzare, in modo basico, la periferica.
Questa lista è stata il punto di inizio per la scrittura dei casi d'uso e dei requisiti, ma è stata fondamentale
anche al fine di imparare come il microcontrollore gestisce le periferiche tramite la memoria.

#figure(
  image("../images/illd_evadc_example.png", width: 100%),
  caption: [
    funzione all'interno di uno degli esempi in _C_ di _Infineon_ dalla quale ho studiato come funziona il modulo _EVADC_.
  ],
)

#figure(
  image("../images/reg_val_example.png", width: 100%),
  caption: [
    sezione del documento di analisi preliminare dove andavo a descrivere il significato dei singoli registri utili.
  ],
)

#figure(
  image("../images/basic_init_doc.png", width: 50%),
  caption: [
    sezione del documento di analisi preliminare che descrivi i passaggi minimi per l'inizializzazione del modulo.
  ],
)

Arrivati a questo punto ho scritto i casi d'uso ed i relativi requisiti. Queste attività hanno richiesto attenzione
particolare, in quanto non era mai stato fatto un lavoro di questo tipo in azienda, ossia con questa granularità,
per quanto riguarda progetti legati a dei _driver_.
Oltre alla produzione di documenti per il progetto di tirocinio stesso, abbiamo anche aggiornato la documentazione
aziendale di conseguenza.
Al fine di validare la mia comprensione di funzionamento della periferica, ho creato un _PoC_ in _Rust_ che andava ad
inizializzare il modulo, verificando, grazie al _software UDE_, che lo stato dei registri, dopo l'inizializzazione,
fosse lo stesso, sia con gli esempi in _C_, sia con l'_PoC_ in _Rust_.

#figure(
  image("../images/usecase_mod_init.png", width: 100%),
  caption: [
    diagramma dei casi d'uso specifico riguardo l'inizializzazione del modulo _EVADC_.
  ],
)

#figure(
  image("../images/req_func_mod_init.png", width: 100%),
  caption: [
    requisito funzionale specifico riguardo l'inizializzazione del modulo _EVADC_.
  ],
)

#figure(
  image("../images/req_constraint_mod_init.png", width: 100%),
  caption: [
    requisito di vincolo specifico riguardo l'inizializzazione del modulo _EVADC_.
  ],
)

#figure(
  image("../images/llfr_mod_init.png", width: 100%),
  caption: [
    requisito funzionale di basso livello riguardo l'inizializzazione del modulo _EVADC_.
  ],
)

La progettazione, come ho già detto sopra, è stata l'attività più difficile in termini di ragionamento.
Partendo dai requisiti mi sono cimentato nella creazione di un'architettura adatta.
La prima attività, e probabilmente la più utile, è stata definire gli stati e le transizioni tra di essi, nei quali
il _software_ sarebbe potuto essere.
Per fare ciò ho sviluppato un secondo _PoC_, senza funzionalità, con il solo scopo di provare un modello di
progettazione che secondo me era il più adatto per questo caso, il _typestate_.

#figure(
  image("../images/mvp2_evadc_init.png", width: 100%),
  caption: [
    sezione di codice del secondo _PoC_ per provare il funzionamento degli stati.
  ],
)

#figure(
  image("../images/statechart_mod_init.png", width: 100%),
  caption: [
    diagramma degli stati per il modulo _EVADC_, diviso per stati a tempo di compilazione e tempo di esecuzione.
  ],
)

Dopo questo passaggio ho iniziato, grazie a tutte le informazioni ottenute, a scrivere i documenti di specifica tecnica,
nei quali erano presenti anche due diagrammi, che hanno aggiunto valore alla progettazione stessa.
Essi sono stati in ordine, il diagramma delle classi e quello di sequenza.
Il primo è servito per costruire l'architettura del sistema, in questo caso quella del modulo _EVADC_ stesso.
Secondo i casi d'uso ed i requisiti, il compito di questa sezione del sistema era quello di fornire un'interfaccia per:
+ avere la possibilità di creare una configurazione per la periferica;
+ avere la possibilità di applicare la configurazione creata;
+ avere la possibilità di ottenere i sotto-componenti collegati alla periferica, in modo controllato;
+ abilitare o disabilitare la periferica.

Il primo ed il secondo punto li ho risolti creando un oggetto di configurazione da passare al metodo omonimo.
Da notare è il fatto che per fare questo è stato usato il _typestate pattern_, quindi già a tempo di compilazione ci si
può assicurare che, se si vuole usare il modulo, bisogna per forza aver creato e applicato una configurazione corretta.
Per l'abilitazione della perifierica ho usato invece un normale _state pattern_, allo scopo di gestire in modo controllato
le transizioni.
Infine, per rispndere al requisito di vincolo, che chiedeva l'inizializzazione del modulo generico prima di ogni altro,
ho fatto in modo che si potessero ottenere i sotto-componenti collegati solo dopo, aver applicato la configurazione e
lanciato il metodo per bloccarla definitivamente.
Inoltre, grazie al concetto di _ownership_ di _Rust_, ho fatto in modo che i sotto-componenti potessero essere presenti, all'
interno del sistema, una volta sola, così da rispettare le proprietà fisiche dell'_hardware_.

Per concludere, voglio citare anche un altro modello di progettazione utilizzato, non solo in questa parte, ma in
tutto il _driver_, che è l'_adapter_. Si tratta di un modello che aveva come scopo quello di inserirsi tra il mio sistema
e una libreria esterna, dove erano definiti tutti i registri della scheda elettronica.
Essendo questa libreria in rapida evoluzione, ho preferito inserire un "cuscinetto" che la andasse ad astrarre, così
da rendere il codice più mantenibile.

#figure(
  image("../images/cd_evadc_mod_init.png", width: 80%),
  caption: [
    sezione del diagramma delle classi che rappresenta il modo di applicare una configurazione al modulo _EVADC_.
  ],
)

#figure(
  image("../images/cd_evadc_mod_split.png", width: 100%),
  caption: [
    sezione del diagramma delle classi che rappresenta il modo bloccare la configurazione del modulo _EVADC_ e la classe
    che fornisce i sotto-componenti.
  ],
)

#figure(
  image("../images/cd_evadc_mod_enable.png", width: 50%),
  caption: [
    sezione del diagramma delle classi che rappresenta i metodi per il cambio di stati dinamico del modulo _EVADC_.
  ],
)

Finita una prima versione dell'architettura, ho creato un diagramma di sequenza, volto a capire quali fossero
effettivamente i metodi da eseguire al fine di inizializzare il modulo. Il diagramma in questione si è poi
rivelato fondamentale anche come guida per capire il funzionamento di tutto il sistema da parte di un potenziale
utilizzatore.

L'ultima attività è stata l'implementazione, dato che, come descritto sopra, le prove di funzionamento le avevo fatte
attraverso un _PoC_ apposito.
Ci tengo a sottolienare che tutte le attività sono state svolte in modo incrementale e non a cascata.
La conseguenza è che, queste ultime, sono state portate a termine in parallelo, con continue modifiche e miglioramenti,
pur avendole descritte in maniera sequenziale.

#figure(
  image("../images/evadc_ll_code.png", width: 100%),
  caption: [
    sezione di codice del _driver_ che scrive sui registri del microcontrollore una configurazione del modulo _EVADC_.
  ],
)

#figure(
  image("../images/evadc_hl_code.png", width: 70%),
  caption: [
    sezione di codice del _driver_ che, in ordine, genera una configurazione di _default_ per modulo _EVADC_, la applica,
    la rende permanente e accende la periferica.
  ],
)

== Risultati ottenuti

==== Qualitativi

I risultati qualitativi più rilevanti sono sicuramente nell'ambito della sicurezza funzionale, infatti moltissimi
degli errori legati alla memoria di _C_, sono stati evitati grazie al semplice uso di _Rust_. Il risultato rafforza
lo studio effettuato da Shea Newton @polysync_misra_rust, riguardo a _MISRA_, uno _standard_ per il linguaggio _C_ che
prevede regole rigide riguardo alla scrittura del codice, dove ha evidenziato come solo trentacinque delle
centoquarantacinque regole _MISRA_ analizzate si applicassero anche a _Rust_. La conseguenza rilevante
è la maggior difficoltà nell'introdurre determinate classi di errori,
provato dal fatto che, durante i _test_ manuali, non siamo riusciti a mettere la scheda in uno stato di fallimento, attraverso
il _driver_ creato.

Un risultato che ha apportato un miglioramento al processo di analisi è stato in merito alla scrittura dei requisiti.
Partendo da una base comune abbiamo introdotto, nella documentazione esistente, nuovi punti di vista e diversi approcci
per affrontare requisiti di un prodotto che non verrà mai utilizzato da solo, ma solamente come supporto alle operazioni
di sistemi più grandi.

Lo studio che ho condotto ha svelato, inoltre, come l'ecosistema _Rust_ non sia ancora del tutto pronto ad essere
integrato nei sistemi esistenti in produzione.
Uno dei problemi principali sono le versioni che vengono rilasciate: per accedere alle ultime funzionalità
del linguaggio bisogna usare versioni recenti, ma molti strumenti sono stati costruiti per versioni più vecchie e non
sono più stati aggiornati.
Rilasciando così tante versioni del linugaggio in PoCo tempo, visto che si tratta di una tecnologia in rapida crescita,
è difficile per gli sviluppatori tenere aggiornate le librerie _software_.
Anche durante il mio tirocinio abbiamo dovuto investire molto tempo nello scovare errori legati a questa problematica,
spesso trovando soluzioni temporanee.

Altro risultato qualitativo riguarda tutti i documenti prodotti, che potranno essere visionati dai colleghi, come fonte
di informazioni, sui temi trattati.

==== Quantitativi

I prodotti creati sono i seguenti:
- una libreria _software_ contenente il codice per l'uso del modulo _EVADC_ per i microcontrollori _Infineon TC37X_ e
  _TC39X_ per un totale di millesettecentoventisette (1727) righe di codice;
- analisi preliminare sulla configurazione minima necessaria per il funzionamento del modulo _EVADC_, a supporto dell'implementazione;
- diagramma delle classi, di sequenza e degli stati, utili alla descrizione dell'architettura;
- diagramma dei casi d'uso, utile alla derivazione dei requisiti;
- documento per i requisiti di basso livello, utili all'implementazione del _software_;
- un report sul caso specifico del _pattern_ che usa i tipi per creare una macchina a stati finiti;
- un report sull'uso dell'_UDE_ con il linguaggio _Rust_;
- un report sull'uso di _Prusti_ come strumento di verifica formale;
- un documento di specifica dei requisiti, a supporto dell'implementazione;
- un documento di specifica tecnica, dove spiegare le scelte progettuali fatte;
- lucidi di presentazione del lavoro svolto per spiegazione ai colleghi.

Il totale ammonta a millecinquecento (1500) righe di documentazione divise in dieci documenti differenti.
Altro risultato quantitativo degno di nota è il tempo per portare a compimento il progetto,
che nel complesso ha richiesto otto settimane, perfettamente in linea con quanto programmato e disponibile.

