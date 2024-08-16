#import "../config/constants.typ": abstract
#set page(numbering: "i")
#counter(page).update(1)
#set par(first-line-indent: 0pt)
//#set par(leading: 0.65em)
#set text(size: 10pt)

#text(24pt, weight: "semibold", abstract)

#v(3em)

Allo stato, il software dei sistemi di controllo è ancora prevalentemente sviluppato in
linguaggio _C_.
Tuttavia, il codice che ne deriva è spesso difficile da leggere e quindi anche da mantenere.
Vista anche la sua natura estremamente versatile, facilita l’introduzione di errori di sicurezza.
Il caso che abbiamo preso in esame è stato il _driver_ per il modulo del microcontrollore _Infineon
Aurix TC375_, dedicato alle conversioni da segnali analogici a digitali ad approssimazioni
successive (_SAR_), che è stato scritto interamente in _Rust_.

In questo documento espongo il lavoro che ho svolto durante lo _stage_ con una suddivisione nei seguenti capitoli:
- #link(<cap:business-context>)[Il primo capitolo] descrive l'azienda all'interno della quale sono stato inserito, fornendo una panoramica degli strumenti e dei processi adottati.
- #link(<cap:stage-purpose>)[Il secondo capitolo] descrive lo scopo del tirocinio, soffermandosi su quali siano le motivazioni che hanno spinto l'azienda ad approfondire i temi che verranno trattati, sugli obiettivi e sui prodotti attesi.
- #link(<cap:stage-description>)[Il terzo capitolo] descrive nel dettaglio il metodo di lavoro utilizzato e quali sono stati i problemi affrontati durante il corso del tirocinio. Alla fine del capitolo vengono presentati i risultati ottenuti e le conclusioni tratte.
- #link(<cap:conclusions>)[Il quarto capitolo] porta una retrospettiva finale in termini di conoscenze acquisite e di soddifacimento delle parti coinvolte.

Oltre alla struttura appena descritta, ho adottato le seguenti convenzioni tipografiche:
- gli acronimi, le abbreviazioni e i termini ambigui o di uso non comune menzionati vengono definiti nel #link(<cap:glossary>)[Glossario], situato alla fine del presente documento;
- per la prima occorrenza dei termini riportati nel glossario viene utilizzata la seguente nomenclatura: #text(blue.darken(60%))[parola#sub[G]], si tratterà di ancore navigabili, che rimandano alla definizione nel glossario;
- i termini in lingua straniera o facenti parti del gergo tecnico sono evidenziati con il carattere _corsivo_.

#v(1fr)

#pagebreak()
#set page(numbering: none)
