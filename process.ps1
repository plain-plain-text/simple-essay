<#
Based on https://github.com/plain-plain-text/simple-cv/blob/master/process.sh

This PowerShell script processes the files in this repository to generate
a few temporary files and a final pdf and html file for a CV.

If you cannot get this script to run on your local computer, as an initial, security-risky
solution, run this command in Powershell:

Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

At the end of your work, you can set the policy back to the Windows default:

Set-ExecutionPolicy -ExecutionPolicy Restricted -Scope CurrentUser

Alternatively, you can run powershell itself with different execution policy.
To do that, open a command prompt and run:

powershell -ExecutionPolicy Unrestricted

For the duration of that shell, the policy will be unrestricted.
#>

# 1. Reset tmp directory
if(!(Test-Path -Path .\tmp)){
    New-Item -ItemType directory -Path .\tmp
} else {
    Get-ChildItem -Path .\tmp -Include *.* -File -Recurse | foreach { $_.Delete()}
}

# 2. Find metadata file
if(!(Test-Path .\metadata.yml)){
  "Could not find file 'metadata.yml'"
  exit
}

# 3. Make sections list.
if(Test-Path -Path sections.txt -PathType Leaf){
    " " | Out-File .\tmp\main.md -Encoding utf8
    cat .\sections.txt |
    Select-String -Pattern "^[^#]" |
    foreach {
        $md_file = cat "sections\$($_).md" -Encoding utf8
        Add-Content .\tmp\main.md $md_file
        Add-Content .\tmp\main.md " "
    }
} else {
    "Could not find file 'sections.txt'"
    exit
}

# 4. Add preamble to main.md
Get-Content .\bibliography-preamble.tex | Add-Content -Path .\tmp\main.md

# 5. Hack .bib to get it to respect mkbibquote and mkbibemph

#cat .\bibliography.bib | %{$_ -replace "\$\\backslash\$", "\"}
#cat .\bibliography.bib | %{$_ -replace "\\{\\vphantom\\}", "{"}
#cat .\bibliography.bib | %{$_ -replace "\\vphantom\\{\\}", "}"}

# 6. Invoke pandoc
"Generating .doc and .pdf files."
$pandoc_tex_args = @(
    "--standalone",
    "--from=markdown+yaml_metadata_block+raw_tex+citations",
    "--template=template.tex",
    "--filter=pandoc-citeproc",
    "--metadata-file=metadata.yml",
    "--output=tmp\out.tex",
    ".\tmp\main.md"
)
$pandoc_doc_args = @(
    "--standalone",
    "--from=markdown+yaml_metadata_block+citations",
    "--filter=pandoc-citeproc",
    "--metadata-file=metadata.yml",
    "--output=output.docx",
    ".\tmp\main.md"
)
$pandoc_pdf_args = @(
    "--standalone",
    "--from=markdown+yaml_metadata_block+citations",
    "--filter=pandoc-citeproc",
    "--template=template.tex",
    "--pdf-engine=xelatex",
    "--metadata-file=metadata.yml",
    "--output=output.pdf",
    ".\tmp\main.md"
)
pandoc $pandoc_tex_args
pandoc $pandoc_doc_args
pandoc $pandoc_pdf_args
"Files generated."
