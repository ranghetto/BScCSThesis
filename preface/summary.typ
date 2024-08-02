#import "../config/constants.typ": abstract
#set page(numbering: "i")
#counter(page).update(1)

#v(10em)

#text(24pt, weight: "semibold", abstract)

#v(2em)
#set par(first-line-indent: 0pt)
Il presente documento descrive il lavoro svolto durante il periodo di stage, della durata di trecentoventi ore, dal laureando Matteo Rango presso l'azienda Bluewind S.R.L.

Allo stato, il software dei sistemi di controllo è ancora prevalentemente sviluppato in linguaggio C.
Tuttavia, il codice che ne deriva è spesso difficile da leggere e quindi anche da mantenere.
Vista anche la sua natura estremamente versatile, facilita l’introduzione di errori di sicurezza.

Questa tesi si propone di illustrare metodi e tecniche per l’uso di Rust per lo sviluppo di quei sistemi, nell’intento di minimizzare gli errori o meglio, identificarli, prima ancora della
compilazione.

Il caso preso in esame è stato il driver per il modulo del microcontrollore Infineon Aurix TC375, dedicato alle conversioni da segnali analogici a digitali ad approssimazioni successive (SAR).
Lo sviluppo è partito dallo studio di implementazioni esistenti, scritte in C, in modo da identificarne i principali problemi, e poi dall’uso di design pattern utili a rispondere alle esigenze di
sistemi che hanno pochissimo margine di fallimento.

L'implementazione ha evidenziato come l'adozione di determinate tecniche e pattern di progettazione, riescono a rendere il sistema sicuro e semplice da usare, rimuovendo quasi completamente la
necessità di conoscere ogni dettaglio del microcontrollore.
Anche laddove certi stati di esecuzione debbano necessariamente essere gestiti a tempo d’esecuzione, questo nuovo modello di sviluppo offre molte più garanzie riguardo all’affidabilità e
conformità del sistema. ​
#v(1fr)
