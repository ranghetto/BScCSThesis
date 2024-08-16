#import "../config/constants.typ": abstract
#set page(numbering: "i")
#counter(page).update(1)
#set par(first-line-indent: 0pt)
//#set par(leading: 0.65em)
#set text(size: 10pt)

#text(24pt, weight: "semibold", abstract)

#v(1em)

Allo stato, il software dei sistemi di controllo è ancora prevalentemente sviluppato in
linguaggio _C_.
Tuttavia, il codice che ne deriva è spesso difficile da leggere e quindi anche da mantenere.
Vista anche la sua natura estremamente versatile, facilita l’introduzione di errori di sicurezza.
Il caso che abbiamo preso in esame è stato il _driver_ per il modulo del microcontrollore _Infineon
Aurix TC375_, dedicato alle conversioni da segnali analogici a digitali ad approssimazioni
successive (_SAR_), che è stato scritto interamente in _Rust_.

In questo documento espongo il lavoro che ho svolto durante lo _stage_ con la seguente suddivisione: il #link(<cap:business-context>)[primo capitolo] descrive l'azienda
all'interno della quale sono stato inserito, fornendo una panoramica degli strumenti e dei processi adottati; il #link(<cap:stage-purpose>)[secondo capitolo] descrive lo
scopo del tirocinio, i prodotti attesi, il metodo di lavoro e gli obiettivi personali; il #link(<cap:stage-description>)[terzo capitolo] descrive nel dettaglio il metodo di
tracciamento del lavoro e quali sono stati i problemi affrontati durante il
corso del tirocinio. Alla fine del capitolo vengono presentati i risultati ottenuti e le conclusioni tratte; per finire il #link(<cap:conclusions>)[quarto capitolo]
espone una retrospettiva finale in termini di conoscenze acquisite e di soddifacimento delle parti coinvolte.
Oltre alla struttura appena descritta, ho adottato le seguenti convenzioni tipografiche:
- gli acronimi, le abbreviazioni e i termini di uso non comune menzionati, vengono definiti nel #link(<cap:glossary>)[Glossario], situato alla fine del presente documento;
- per la prima occorrenza dei termini riportati nel glossario viene utilizzata la seguente nomenclatura: #text(blue.darken(60%))[parola#sub[G]]\;
- i termini in lingua straniera o facenti parti del gergo tecnico sono evidenziati con il carattere _corsivo_;
- dove non diversamente specificato, l'uso del "noi" si riferisce a me e ai miei tutor aziendali.

#v(1fr)

#pagebreak()
#set page(numbering: none)
