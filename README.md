# simple-essay

![Screenshot of title of pdf](https://i.imgur.com/2KtAfeq.png)

This repository provides a bare minimum of files to generate a tidy academic
paper with markdown that, nevertheless, is published as both a Microsoft Word
`.docx` and as a `.pdf` (see
[output.docx](https://github.com/plain-plain-text/simple-essay/blob/master/output.docx)
and
[output.pdf](https://github.com/plain-plain-text/simple-essay/blob/master/output.pdf)
respectively). The conversion is done by the universal document
converter, [Pandoc](http://pandoc.org), and the typesetting for the `.pdf` is
done with TeX.

## Prerequisites

Please have installed, for maximal compatibility with this README:

* [Git](http://git-scm.com), for getting these files and putting your own essay under version control.
* [Atom](http://atom.io), for editing your plain text files.
* [Pandoc](http://pandoc.org), for converting Markdown to Word and TeX.
* A TeX distribution, such as [MiKTeX](http://miktex.org) for Windows or [MacTeX](https://www.tug.org/mactex/) for MacOS, for typesetting your document.
* [Zotero](http://zotero.org), for managing citations.
* [Better BibTeX](https://retorque.re/zotero-better-bibtex/), a plugin that improves Zotero .

## Getting Started

1. [Fork](https://help.github.com/articles/fork-a-repo/) this “repo”
1. Clone your forked copy of the repo (use the “GitHub: Clone” command in
   Atom, accessed via the [Command
   Palette](https://atom.io/packages/command-palette)).

## Understand the Repo

* 📁 `sections/`: a folder containing a bunch of Markdown files that make up
the content of your essay.
    * `a-long-story.md`: a Markdown file
    * `intro.md`: a Markdown file
    * `section-one.md`: a Markdown file
* `.gitignore`: a list of files for Git to ignore. You can also ignore this
file.
* `bibliography-preamble.tex`: a short TeX file that sets the formatting for
your bibliography.
* `bibliography.bib`: a
[BibLaTeX](https://ctan.org/pkg/biblatex?lang=en)-formatted database of all of
the sources you will be citing. It is an exported version of [this Zotero
collection](https://www.zotero.org/moacir/items/collectionKey/7G84VPGE). For
more, see below.
* `metadata.yml`: a [YAML](https://learnxinyminutes.com/docs/yaml/) file
containing the metadata (author, title, margins) regarding the essay. See
below.
* `process.ps1` and `process.sh`: PowerShell and shell scripts that convert
your Markdown content into `.docx` and `.pdf` files.
* `README.md`: this file.
* `sections.txt`: a file containing a list of files from inside the `sections` folder above, in the order in which they should appear in the final document.
* `template.tex`: the underlying TeX template for generating the pdf.

## Generating Output

* On MacOS and Linux, execute `sh process.sh` from within the repo root
directory, which you can do in Atom by launching a terminal from within the
editor.
* On Windows, execute `.\process.ps1` from within the repo root directory,
which you can do in Atom by launching a terminal from within the editor.

These commands will create two “finished” files: `output.docx` and
`output.pdf`. Additionally, for reference purposes, it will put a TeX file,
`output.tex` in the `tmp` directory, which is created on the fly.

## Writing Scholarly Markdown

The two main differences between writing regular Markdown and scholarly
Markdown are the introduction of footnotes and citations.

### Footnotes

Footnotes are written inline with the text itself. This is similar to the way
applications like Scrivener treat footnotes. In other words, you write them
like this:

```markdown
It was important to remember that, during this battle, the sides were hardly
evenly matched.^[In fact, contemporary sources posit that one side had nearly
ten times as many soldiers.] Nevertheless, the battle started precisely at
noon.
```

Note the syntax: a `^`, followed by the contents of the footnote enclosed in
`[]`.

If your footnotes need to grow to multiple paragraphs, please see the Pandoc
documentation for “[regular
footnotes](https://pandoc.org/MANUAL.html#footnotes)” (those described above
are “inline footnotes”).

### Citations

The `.bib` database, `bibliography.bib`, is written in the
[BibLaTeX](https://ctan.org/pkg/biblatex?lang=en). Every entry to the database
begins with its type (`@book`, for example), followed by its *citation key*.
In the case of the `bibliography.bib` included in this repo, the very first
citation key is `barnes_nightwood_1995`.

When exporting a collection from Zotero as BibLaTeX (by right- or
control-clicking on the collection and choosing “Export Collection…”), Zotero
will auto-create citation keys of the format `author_title_year`.

Citing a work in the `.bib` file is done using the citation key. In Markdown,
the typical format to do so is:

```markdown
The narrator refers to Guideo Volkbein as “both a gourmet and a dandy, never
appearing in public without the ribbon of some quite unknown distinction
tinging his buttonhole with a faint thread”[@barnes_nightwood_1995 3].
```

The citation syntax is rather flexible and forgiving. The Pandoc documentation
provides [a few other examples](https://pandoc.org/MANUAL.html#citations):

```markdown
Blah blah [see @doe99, pp. 33–35; also @smith04, chap. 1].

Blah blah [@doe99, pp. 33-35, 38-39 and *passim*].

Blah blah [@smith04; @doe99].
```

Long citation keys can be cumbersome and can be difficult to remember.
Installing the [Better BibTeX](https://retorque.re/zotero-better-bibtex/)
plugin for Zotero will let you define citation keys from within Zotero itself
by adding a line `bibtex: citation-key` in the “Extras” field in Zotero. That
is how, in the default `bibliography.bib`, the standard edition of _Nightwood_
has a citation key of simply `nightwood`, not `barnes_nightwood_1936`.

Finally, often users will have one, giant .bib file that represents every
citation they have saved. If this is the case for you, then, obviously, the
`bibliography` key needs to be changed in `metadata.yml` to point to that
file. However, in that case, you can also benefit from using the
[autocomplete-bibtex](https://atom.io/packages/autocomplete-bibtex) plugin for
Atom that will auto-suggest citations for you.

## Metadata.yml

The `metadata.yml` file contains information that is passed both to Pandoc
itself and to LaTeX via the settings in `template.tex`. 

* `title`: This is the title of the essay or chapter.
* `author`: This is an array of potential authors, with one listed. Each
author can have three keys, of which the latter two can be blank:
    * `name`: The author’s name
    * `affiliation`: The author’s academic affiliation
    * `email`: The author’s email
* `bibliography`: This indicates to Pandoc where the BibLaTeX `.bib` database
is.
* `notes-after-punctuation`, `csl`, `link-citations`: These are specific
values that Pandoc-citeproc handles. Please see the [Pandoc-citeproc
documentation](https://github.com/jgm/pandoc-citeproc/blob/master/man/pandoc-citeproc.1.md)
for more information on these keys. The `csl` refers to a [Citation Style
Language](https://citationstyles.org/) file. By default, Pandoc-citeproc uses
the [`chicago-author-date`
style](https://github.com/citation-style-language/styles/blob/master/chicago-author-date.csl).
See below for more information on CSL.
* `nocite`: If set to `"@*"`, the entire contents of `bibliography.bib` will
be printed in the bibliography, even if works remain uncited.
* `epigraph`: This is an array of potential epigraphs, with two listed. Each
epigraph should have two keys:
    * `text`: The text of the epigraph
    * `source`: The source of the epigraph
`pdf-options`: This is a list of options for generating the pdf. They should
be somewhat self-explanatory.
    * `font`: This key, however, is a bit tricky, and it is commented out by
    default, because it is hard to predict what fonts are on someone’s
    computer. If you download and install [EB
    Garamond](http://www.georgduffner.at/ebgaramond/index.html), then you can
    uncomment the line as it is and have the pdf output typeset in EB
    Garamond.
    * `font-settings`: This is a subgroup of font settings that may not apply
    to all fonts.

## Citation Style Language Files

A brief list of [CSL](http://citationstyles.org) files to download. Once you
download the file, you should drop it into the same folder as this repository
and then set the `csl` key in `metadata.yml` to point to the file.

[APA 6th ed](http://www.apa.org):

* [`apa.csl`](https://github.com/citation-style-language/styles/blob/master/apa.csl)

[Chicago 17th ed](http://chicagomanualofstyle.org):

* [`chicago-annotated-bibliography.csl`](https://github.com/citation-style-language/styles/blob/master/chicago-annotated-bibliography.csl)
* [`chicago-fullnote-bibliography.csl`](https://github.com/citation-style-language/styles/blob/master/chicago-fullnote-bibliography.csl)
* [`chicago-fullnote-bibliography.csl`](https://github.com/citation-style-language/styles/blob/master/chicago-fullnote-bibliography.csl)

[MLA 8th ed](http://www.mla.org):

* [`modern-language-association.csl`](https://github.com/citation-style-language/styles/blob/master/modern-language-association.csl)

[Turabian
8th](https://en.wikipedia.org/wiki/A_Manual_for_Writers_of_Research_Papers,_Theses,_and_Dissertations):

* [`turabian-fullnote-bibliography.csl`](https://github.com/citation-style-language/styles/blob/master/turabian-fullnote-bibliography.csl)


