#import "@preview/glossarium:0.4.1": make-glossary, print-glossary
#show: make-glossary

#pagebreak(to: "even")
#set heading(numbering: none)

= Glossario
<cap:glossary>

#print-glossary(
  (
    (key: "foo", short: "Fool"),
  )
)
