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
      desc: [insieme di metodi e principi che promuove lo sviluppo di prodotti attraverso piccoli gruppi di lavoro autogestiti, un approccio iterativo e incrementale, il coinvolgimento diretto del cliente finale ed una propensione al cambiamento.]
    ),
    (
      key: "scrum",
      short: "Scrum",
      desc: [sistema di supporto alla gestione di progetti complessi, adattabile alle proprie esigenze, fondato sul metodo _agile_.]
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
      desc: [Componente elettronico in grado di effettuare conversioni da segnali analogici a digitali.]
    ),
    (
      key: "evadc",
      short: "EVADC",
      long: "Enhanced Versatile Analog-to-Digital Converter",
      desc: [Modulo presente all'interno di alcuni microcontrollori _Infineon_ che controlla diversi _ADC_ di tipo _SAR_, offrendo capacità di sincronizzazione, parallelismo, etc.]
    ),
    (
      key: "sar",
      short: "SAR",
      long: "successive approximation register",
      desc: [Tipologia di _ADC_ che funziona attraverso l'approsimazione iterativa del valore analogico attraverso una ricerca binaria attraverso tutti i livelli
      di precisione che il componente stesso offre.]
    ),
  )
)
