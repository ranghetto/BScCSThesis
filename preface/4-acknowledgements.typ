#import "../config/variables.typ" : profTitle, myProf, myLocation, myTime, myName
#import "../config/constants.typ" : acknlowledgements

#set par(first-line-indent: 0pt)
#set page(numbering: "i")
#counter(page).update(2)

#align(right, [
    Non c'è limite al peggio, negli algoritmi come nella vita.
    #v(6pt)
    #sym.dash#sym.dash#sym.dash Paolo Baldan
])

#v(10em)

#text(24pt, weight: "semibold", acknlowledgements)

#v(3em)

#text(style: "italic", "Innanzitutto, vorrei esprimere la mia più profonda gratitudine al " + profTitle + myProf + ", relatore della mia tesi, per il supporto fornitomi durante la stesura e per la pazienza di rispondere ad ogni mio pensiero inquieto.")

#linebreak()

#text(style: "italic", "Desidero ringraziare con affetto i miei genitori, per il sostegno durante tutti gli anni di studio.")
#text(style: "italic", "Mamma, alla fine, tutti i capelli bianchi che ti ho fatto venire, hanno dato i loro frutti.")

#linebreak()

#text(style: "italic", "Un grazie, dal profondo del cuore, a Sofia, per i momenti condivisi assieme. Con te affianco, posso raggiungere qualsiasi vetta.")

#v(2em)

#text(style: "italic", myLocation + ", " + myTime + h(1fr) + myName)

#v(1fr)

#pagebreak()
#set page(numbering: none)
