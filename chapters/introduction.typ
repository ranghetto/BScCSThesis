// Non su primo capitolo
//#pagebreak(to:"odd")

= Introduzione

#v(1em)
#text(style: "italic", [
    Breve introduzione al capitolo
])

#v(1em)

aggiungere riferimenti a:
- Termine nel glossario
- Citazione in linea
- Citazione nel pie' di pagina

== Organizzazione del testo

#set par(first-line-indent: 0pt)

/ #link(<cap:business-context>)[Il secondo capitolo]: descrive.
/ #link(<cap:stage-purpose>)[Il terzo capitolo]: descrive.
/ #link(<cap:stage-description>)[Il quarto capitolo]: descrive.
/ #link(<cap:conclusions>)[Il quinto capitolo]: descrive.

Riguardo la stesura del testo, relativamente al documento sono state adottate le seguenti convenzioni tipografiche:

- gli acronimi, le abbreviazioni e i termini ambigui o di uso non comune menzionati vengono definiti nel glossario, situato alla fine del presente documento;
- per la prima occorrenza dei termini riportati nel glossario viene utilizzata la seguente nomenclatura: _parola_ (glsfirstoccur);
- i termini in lingua straniera o facenti parti del gergo tecnico sono evidenziati con il carattere _corsivo_.

La bibliografia è gestita nel file `bibliography.typ` con il nuovo formato Hayagriva, ma si può utilizzare il formato Bibtex. Per citare un elemento in bibliografia basta usare una semplice citazione `@citazione`, ad esempio per citare *il miglior libro di sempre* @p1 basta usare `@p1`.
