#import "@preview/glossarium:0.4.1": make-glossary, print-glossary
#show: make-glossary

#pagebreak(to: "odd")
#set heading(numbering: none)

= Glossario
<cap:glossary>

#print-glossary(
  (
    (
      key: "partner",
      short: "partner",
      desc: [azienda collaboratrice con la quale si instaura un rapporto commerciale di aiuto reciproco.]
    ),
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
      short: "agile",
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
      desc: [strumento di gestione di progetto che permette tracciare il lavoro svolto]
    ),
  )
)
