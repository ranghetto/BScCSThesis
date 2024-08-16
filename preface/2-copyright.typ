#import "../config/variables.typ" : myName, myTitle, myDegree, myTime

#set page(numbering: none)
#set par(leading: 0.55em, justify: true)
#set text(font: "New Computer Modern", size: 10pt)
#show par: set block(spacing: 0.55em)
#show heading: set block(above: 1.4em, below: 1em)

#align(left + bottom, [
    #text(myName): #text(style: "italic", myTitle), #text(myDegree), #sym.copyright #text(myTime)
])
