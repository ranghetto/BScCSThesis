#import "../config/constants.typ": abstract
#set page(numbering: "i")
#counter(page).update(1)
#set par(first-line-indent: 0pt)
//#set par(leading: 0.65em)
#set text(size: 10pt)

#text(24pt, weight: "semibold", abstract)

#v(1em)

Attualmente, il _software_ dei sistemi di controllo è ancora prevalentemente sviluppato in
linguaggio _C_.
Tuttavia, il codice che ne deriva è spesso difficile da leggere e quindi anche da _mantenere_.
Vista anche la sua natura estremamente versatile, facilita l’introduzione di errori di sicurezza.
Durante il tirocinio, ho riprogettato e sviluppato, in _Rust_, un _driver_ per il modulo dedicato
alle conversioni da segnali analogici a digitali, ad approssimazioni successive (_SAR_), del
microcontrollore _Infineon Aurix TC375_.
Il lavoro ha evidenziato come è possibile, grazie a _Rust_, rimuovere un'intera classe di errori e
garantire sicurezza e stabilità al sistema.

In questo documento, espongo il lavoro che ho svolto con la seguente suddivisione: nel
#link(<cap:business-context>)[primo capitolo] descrivo l'azienda
all'interno della quale sono stato inserito, fornendo una panoramica degli strumenti e dei processi adottati.
Nel #link(<cap:stage-purpose>)[secondo capitolo] espongo lo
scopo del tirocinio, i prodotti attesi, il metodo di lavoro e gli obiettivi personali.
Nel #link(<cap:stage-description>)[terzo capitolo] descrivo nel dettaglio le attività svolte e metodi di approccio a
problemi per me nuovi, facendo anche un esempio completo; alla fine del capitolo presento i risultati ottenuti e le
conclusioni tratte.
Per finire, nel #link(<cap:conclusions>)[quarto capitolo],
espongo una retrospettiva finale in termini di conoscenze acquisite e di soddifacimento delle parti coinvolte.

Oltre alla struttura appena descritta, ho adottato le seguenti convenzioni tipografiche:
- gli acronimi, le abbreviazioni e i termini di uso non comune menzionati, vengono definiti nel #link(<cap:glossary>)[Glossario], situato alla fine del presente documento;
- per la prima occorrenza dei termini riportati nel glossario viene utilizzata la seguente nomenclatura: #text(blue.darken(60%))[parola#sub[G]]\;
- i termini in lingua straniera o facenti parte del gergo tecnico sono evidenziati con il carattere _corsivo_;
- dove non diversamente specificato, l'uso del "noi" si riferisce a me e ai miei tutor aziendali.

#v(1fr)

#pagebreak()
#set page(numbering: none)
