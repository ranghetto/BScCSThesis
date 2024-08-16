// Frontmatter

#include "./preface/1-firstpage.typ"
#include "./preface/2-copyright.typ"
#include "./preface/3-summary.typ"
#include "./preface/4-acknowledgements.typ"
#include "./preface/5-table-of-contents.typ"

// Mainmatter

#counter(page).update(1)

#include "./chapters/1-business-context.typ"
#include "./chapters/2-stage-purpose.typ"
#include "./chapters/3-stage-description.typ"
#include "./chapters/4-conclusions.typ"

// Appendix

#include "./appendix/1-glossary.typ"
#include("./appendix/2-bibliography.typ")
