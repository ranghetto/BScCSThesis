#import "@preview/glossarium:0.4.1": make-glossary, gls
#show: make-glossary

#pagebreak(to: "odd")

= Scopo del tirocinio
<cap:stage-purpose>

#v(1em)
#text(style: "italic", [
  In questo capitolo si andranno ad analizzare le problematiche che hanno messo le basi per la
  realizzazione della proposta di #emph[stage], assieme alla risposta formalizzata al fine di
  risolverle.
])
#v(1em)

== Rapporto azienda - _stage_
_Bluewind_ sfrutta a pieno i tirocini universitari, soprattutto quelli che prevedono un
piano di lavoro definito e che portano alla creazione di un progetto o allo studio mirato e
consapevole di una nuova tecnologia.

\ Il triplice scopo ha, come base, quello di mettere in discussione i processi aziendali di
sviluppo di un progetto.In prima persona, ho avuto modo di confrontarmi con i colleghi, e discutere con loro, quali
fossero le metodologie più adatte per lo specifico caso d'uso del mio progetto. Questo al fine
di trovare una strada da poter replicare in futuro, avendo già fatto un'analisi sul perché essa
sia la più indicata.
\ Per fare un esempio, il modo di scrivere requisiti per un #gls("driver")#sub[G], un componente
software che facilita l'utilizzo dell'hardware sottostante, è totalmente diverso dal modo di
scrivere requisiti per un'applicazione software che usa quei _driver_, cosa che ci
ha portato alla scoperta di un nuovo approccio.

\ Il secondo scopo è quello legato al progetto stesso, che sia sviluppo o ricerca.
Infatti l'azienda è molto attiva quando si parla di studio e implementazione di nuove
tecnologie, mettendosi in prima linea per conoscerle e provarle.
Tutto ciò che può portare all'azienda un vantaggio competitivo vale la pena di essere, come
minimo, conosciuto.
\ Ed è per questo che con il mio progetto sono andato ad esplorare la programmazione in _Rust_, su
un microcontrollore che ha ad oggi pochissimo supporto per il linguaggio.
I vantaggi di _Rust_ sono ormai noti nel panorama _embedded_, ma dal conoscerli a
riuscire a costruire un driver a basso livello sfruttandoli, c'è una grande differenza.

\ Il terzo scopo, ma non per importanza, è sicuramente legato al fattore assunzioni.
L'azienda ha la possibilità, per qualche mese, di vedere e studiare le capacità dei tirocinanti,
decidendo poi se vale la pena fare loro una proposta di assunzione.
Oltre a questo, gli studenti avranno già fatto, al termine del loro _stage_, un po' di formazione
riguardo gli strumenti adottati da _Bluewind_ e quindi l'integrazione potrà essere più veloce.

== Panoramica del progetto

=== Scopo
Lo scopo del tirocinio era l’implementazione di un _driver_ in _Rust_ per la gestione della
periferica _EVADC_ su microcontrollori per applicazioni #gls("autom")#sub[G], in particolare l'_Infineon
Aurix TC375_.
A seguito o in parallelo alla parte implmentativa avevamo pensato ad una fase di analisi
su due temi rilevanti per il dominio della #gls("sfun")#sub[G]:
- un’indagine generale sui vantaggi e/o svantaggi di utilizzo di _Rust_ per librerie di basso livello;
- un’indagine sulla possibilità ed eventuali modalità preferibili di progettazione dei driver per evitare
  errori di configurazione della periferica in modo statico, cioè a tempo di compilazione,
  con la possibilità di tracciamento delle regole di configurazione rispetto ai manuali tecnici
  del microcontrollore.

=== Obiettivi

Gli obiettivi principali erano tre:

+ L’implementazione di _driver_ in _Rust_ per la gestione della periferica _EVADC_ su
  microcontrollori della famiglia _Infineon Aurix TC3xx_ per applicazioni _automotive_.
+ indagine sulla possibilità ed eventuali modalità preferibili di progettazione dei _driver_
  per evitare errori di configurazione della periferica in modo statico, cioè a tempo di
  compilazione, con la possibilità di tracciamento delle regole di configurazione rispetto
  ai manuali tecnici del microcontrollore;
+ esperimento di integrazione di uno strumento di #gls("verfor")#sub[G] tramite il quale è possibile
  dichiarare e verificare proprietà logiche direttamente sul codice sorgente _Rust_, come
  raccomandato dallo standard _ISO 26262_ per alti livelli di integrità della
  _sicurezza funzionale_ @iecch.

A questi, durante il corso del progetto, ne sono stati aggiunti altri, che all'inizio non erano
stati pensati, ma che sono risultati interessanti al fine di approfondire meglio i temi trattati:

- indagine sull'utilizzo di strumenti per la programmazione ed il _debug_ del codice,
  pensati per il linguaggio _C_, usando _Rust_
- indagine e confronto su strumenti che facilitano lo sviluppo in _Rust_ rispetto a quelli già
  conosciuti per _C_.

=== Prodotti attesi
I principali prodotti attesi, derivanti dagli obiettivi erano:
- una #gls("crate")#sub[G] con l'implementazione del _driver_;
- documentazione architetturale e di dettaglio sul _driver_ sviluppato;
- un report sulle indagini e gli esperimenti citati sopra.

== Obiettivi personali
Descrizione degli obiettivi personali da raggiungere per trarre vantaggio.
