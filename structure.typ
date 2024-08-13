// Frontmatter

#include "./preface/firstpage.typ"
#include "./preface/copyright.typ"
#include "./preface/summary.typ"
#include "./preface/acknowledgements.typ"
#include "./preface/table-of-contents.typ"

// Mainmatter

#counter(page).update(1)

#include "./chapters/business-context.typ"
#include "./chapters/stage-purpose.typ"
#include "./chapters/stage-description.typ"
#include "./chapters/conclusions.typ"

// Appendix

#include "./appendix/glossary.typ"
#include("./appendix/bibliography/bibliography.typ")
