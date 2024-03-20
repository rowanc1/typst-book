#import "book.typ": *
#show: template.with(
  title: "[-doc.title-]",
[# if doc.subtitle #]
  subtitle: "[-doc.subtitle-]",
[# endif #]
)

[-IMPORTS-]

[-CONTENT-]

[# if doc.bibtex #]
#{
  show bibliography: set text(8pt)
  bibliography("[-doc.bibtex-]", title: text(10pt, "References"), style: "apa")
}
[# endif #]
