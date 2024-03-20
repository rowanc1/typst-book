
#let leftCaption(it) = {
  set text(size: 8pt)
  set align(left)
  set par(justify: true)
  text(weight: "bold")[#it.supplement #it.counter.display(it.numbering)]
  "."
  h(4pt)
  set text(fill: black.lighten(20%), style: "italic")
  it.body
}

#let template(
  // The book's title.
  title: "Book Title",
  subtitle: none,
  // A color for the theme of the document
  theme: blue.darken(30%),
  // The book's content.
  body
) = {

  set heading(numbering: (..args) => {
    let nums = args.pos()
    let level = nums.len()
    if level == 1 {
      // Reset the numbering on figures
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
      [#numbering("1.", ..nums)]
    } else {
      [#numbering("1.1.1", ..nums)]
    }
  })

  set figure(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [#chapter.#numbering("1", ..args.pos())]
  })

  // Configure equation numbering and spacing.
  set math.equation(numbering: (..args) => {
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [(#chapter.#numbering("1)", ..args.pos())]
  })
  show math.equation: set block(spacing: 1em)
  show figure.caption: leftCaption
  set figure(placement: auto)

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)


  // Title and subtitle
  box(inset: (bottom: 2pt), text(17pt, weight: "bold", fill: theme, title))
  if subtitle != none {
    parbreak()
    box(text(14pt, fill: gray.darken(30%), subtitle))
  }

  // Outline of book
  pagebreak()
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  outline(indent: auto)

  show heading.where(level: 1): (it) => {
    pagebreak()
    let chapter = counter(heading).display((..nums) => nums.pos().at(0))
    [Chapter #chapter]
    it
  }

  // Display the book's contents.
  body
}
