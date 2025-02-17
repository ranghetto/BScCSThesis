#import "../config/constants.typ": figuresList, tablesList
#set page(numbering: "i")
#counter(page).update(3)

#pagebreak(to: "odd");

#[
  #show outline.entry.where(level: 1): it => {
    linebreak()
    link(it.element.location(), strong(it.body))
    h(1fr)
    link(it.element.location(), strong(it.page))
  }
  #outline(
    indent: auto,
    depth: 3
  )
]

#v(8em)

#outline(
  title: figuresList,
  target: figure.where(kind: image)
)

#v(8em)

#outline(
    title: tablesList,
    target: figure.where(kind: table),
    indent: auto
)