#import "@preview/glossarium:0.4.1": make-glossary, print-glossary
#show: make-glossary

#pagebreak(to: "odd")
#set heading(numbering: none)

= Glossario
<cap:glossary>

#print-glossary(
  (
    (
      key: "rnd",
      short: "R&D",
      long: "Research and Development",
      desc: [ricerca e sviluppo.]
    ),
    (
      key: "po",
      short: "PO",
      long: "product owner",
      desc: [persona a capo di un progetto che si occupa di assicurarsi che esso venga svolto nei modi e nei tempi previsti. Si occupa anche di interfacciarsi con il cliente.]
    ),
    (
      key: "agile",
      short: "Agile",
      desc: [insieme di metodi e principi che promuovono lo sviluppo di prodotti attraverso: piccoli gruppi di lavoro autogestiti, un approccio iterativo e incrementale, il coinvolgimento diretto del cliente finale ed una propensione al cambiamento.]
    ),
    (
      key: "scrum",
      short: "Scrum",
      desc: [particolare sistema di supporto per gestione di progetti complessi, fondato sui principi _agile_.]
    ),
    (
      key: "its",
      short: "ITS",
      long: "issue tracking system",
      desc: [strumento di gestione di progetto che permette tracciare il lavoro svolto.]
    ),
    (
      key: "adc",
      short: "ADC",
      long: "analog-to-digital converter",
      desc: [componente elettronico in grado di effettuare conversioni da segnali analogici a digitali.]
    ),
    (
      key: "evadc",
      short: "EVADC",
      long: "Enhanced Versatile Analog-to-Digital Converter",
      desc: [modulo presente all'interno di alcuni microcontrollori _Infineon_ che controlla diversi _ADC_ di tipo _SAR_, offrendo capacità di sincronizzazione e parallelismo.]
    ),
    (
      key: "sar",
      short: "SAR",
      long: "successive approximation register",
      desc: [tipologia di _ADC_ che funziona attraverso l'approsimazione iterativa del valore analogico attraverso una ricerca binaria attraverso tutti i livelli
      di precisione che il componente stesso offre.]
    ),
    (
      key: "driver",
      short: "driver",
      desc: [
        componente _software_ che astrae l'_hardware_ sottostante,
        fornendo un'interfaccia più semplice da usare.
      ]
    ),
    (
      key: "verfor",
      short: "verifica formale",
      desc: [
        una prova del _software_ che si basa su principi formali matematici di correttezza.
      ]
    ),
    (
      key: "crate",
      short: "crate",
      desc: [
        nel gergo _Rust_ si tratta di una libreria _software_ che racchiude delle funzionalità specifiche.
      ]
    ),
    (
      key: "autom",
      short: "automotive",
      desc: [
        settore automobilistico.
      ]
    ),
    (
      key: "sfun",
      short: "sicurezza funzionale",
      desc: [
        sicurezza che in un sistema, solitamente elettronico, viene attuata in modo
        automatico, riducendo quindi il livello di rischio.
      ]
    ),
    (
      key: "26262",
      short: "ISO 26262",
      desc: [
        _standard_ internazionale per la sicurezza funzionale dei sistemi elettronici installati nei veicoli da strada.
      ]
    ),
    (
      key: "asild",
      short: "ASIL D",
      long: "Automotive Safety Integrity Level D",
      desc: [
        schema di classificazione del rischio più alto nella scala definita dallo standard _ISO 26262_.
      ]
    ),
    (
      key: "framework",
      short: "framework",
      desc: [termine generico che indica una struttura di supporto o una serie di metodologie che hanno un determinato scopo comune]
    ),
  )
)
