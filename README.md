# simple-essay

This repository provides a bare minimum of files to generate a tidy academic
paper with markdown that, nevertheless, is published as both a Microsoft Word
`.docx` and as a `.pdf`. The conversion is done by the universal document
converter, [Pandoc](http://pandoc.org), and the typesetting for the `.pdf` is
done with TeX.

## Prerequisites

Please have installed, for maximal compatibility with this README:

* [Git](http://git-scm.com), for getting these files and putting your own essay under version control.
* [Atom](http://atom.io), for editing your plain text files.
* [Pandoc](http://pandoc.org), for converting Markdown to Word and TeX.
* A TeX distribution, such as [MiKTeX](http://miktex.org) for Windows or [MacTeX](https://www.tug.org/mactex/) for MacOS, for typesetting your document.
* [Zotero](http://zotero.org), for managing citations.

## Getting Started

1. [Fork](https://help.github.com/articles/fork-a-repo/) this “repo”
1. Clone your forked copy of the repo (use the “GitHub: Clone” command in
   Atom, accessed via the [Command
   Palette](https://atom.io/packages/command-palette)).

## Understand the Repo

* 📁 `sections`: a folder containing a bunch of Markdown files that make up
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
the sources you will be citing. See below.
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

The footnote syntax is made up of two parts: the footnote marker and the
footnote content. The footnote marker is of the format `[^key]`, where `key`
is the unique id associated with the footnote. `key` can be a descriptive
term, like `[^footnote-about-cats]` or just a number, like `[^1]`. Regardless
of the key, the footnote will be numbered in the order in which is appears in
the document. Citations may even intercede between your footnotes.

The footnote content appears somewhere else in the document, either at the
bottom of the paragraph, at the bottom of the document, in a separate document
in `sections/`… wherever. But it has to take the format of:

```markdown
[^key]: This is the foonote content. I can talk about my favorite things here.
```

In other words, it’s the footnote marker, on a new line, followed
*immediately* by a `:`, then by a space, and then by the content.

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
As blah remarks in blah [@barnes_nightwood_1995]
```

Long citation keys can be cumbersome and can be difficult to remember. The
[autocomplete-bibtex](https://atom.io/packages/autocomplete-bibtex) plugin for
Atom will suggest citations for you. Similarly, installing the [Better
BibTeX](https://retorque.re/zotero-better-bibtex/) plugin for Zotero will let
you define citation keys from within Zotero itself by adding a line `bibtex:
citation-key` in the “Extras” field in Zotero. That is how, in the default
`bibliography.bib`, the standard edition of _Nightwood_ has a citation key of
simply `nightwood`, not `barnes_nightwood_1936`.

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

* [turabian-fullnote-bibliography.csl](https://github.com/citation-style-language/styles/blob/master/turabian-fullnote-bibliography.csl)


