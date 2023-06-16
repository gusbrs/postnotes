-- Build script for "postnotes" package

-- Identify the bundle and module
bundle = ""
module = "postnotes"

-- Typeset only the .tex files
typesetfiles = {"*.tex"}

-- We need at least 2 runs for the labels.
checkruns = 2
-- But, depending on the case (multipass check, biblatex, etc.), 3.
checkconfigs = {"build","build-3runs"}

-- Don't wrap/truncate lines in test logs
-- See https://tex.stackexchange.com/q/674844#comment1676566_674846
maxprintline = 1000

-- Use dev formats for regression tests
-- See https://tex.stackexchange.com/q/611424
-- But only for pdftexdev and luatexdev, because it is possible to ensure
-- equal .tlgs for luatex and pdftex by using the same font for all engines,
-- but any xetex test with a hyperlink will result in different logs.  So, we
-- can have most tests with two .tlgs and, besides, five engines is probably
-- already overkill.
checkengines = {"pdftex","luatex","xetex","pdftexdev","luatexdev"}
specialformats = specialformats or {}
specialformats.latex = specialformats.latex or { }
specialformats.latex.pdftexdev = { binary = "pdflatex-dev" , format = "" }
specialformats.latex.luatexdev = { binary = "lualatex-dev" , format = "" }
specialformats.latex.xetexdev  = { binary = "xelatex-dev"  , format = "" }

-- Run biber for biblatex related tests
-- See https://github.com/moewew/biblatex-ext/blob/dev/build.lua
function runtest_tasks(name, run)
  if run == 1 and string.match(name, "^pn%-biblatex") then
    return "biber -q " .. name
  else
    return ""
  end
end

-- Disable biblatex related tests which use 'refsection', 'refsegment' or
-- 'refcontext' until proper support for these features can be made available.
excludetests = {
  "pn-biblatex-10-references-per-section" ,
  "pn-biblatex-12-references-by-segment" ,
  "pn-biblatex-16-numeric-prefixed-1" ,
  "pn-biblatex-17-numeric-prefixed-2" ,
  "pn-biblatex-19-alphabetic-prefixed" ,
  "pn-biblatex-94-labelprefix" ,
}

-- Use UTF-8 logs for all engines
asciiengines = {}

-- CTAN upload settings
uploadconfig = {
  version = "0.2.5", -- first line for tagging
  pkg = "postnotes",
  author = "Gustavo Barros",
  uploader = "Gustavo Barros",
  summary = "Endnotes for LaTeX",
  license = "lppl1.3c",
  ctanPath = "/macros/latex/contrib/postnotes",
  repository = "https://github.com/gusbrs/postnotes",
  bugtracker = "https://github.com/gusbrs/postnotes/issues",
  update = true,
  announcement_file = "ctan-announcement.text",
  note_file = "ctan-note.text",
}

-- Use a dedicated readme for CTAN to meet upload requirements
ctanreadme = "readme-ctan.md"

-- Set version, release date and copyright automatically
tagfiles = {
  "postnotes.dtx",
  "CHANGELOG.md",
  "build.lua",
  "postnotes.ins",
  "postnotes.tex",
  "postnotes-code.tex"
}

function update_tag(file, content, tagname, tagdate)
  -- Handle release version tag and date.
  local tagname_safe = string.gsub(tagname, "^v", "")
  if string.match(file, "^postnotes%.dtx$") then
    content = string.gsub(
      content,
      "\n\\ProvidesExplPackage %{postnotes%} %{[^}]+%} %{[^}]+%}\n",
      "\n\\ProvidesExplPackage {postnotes} {"
      .. tagdate .. "} {" .. tagname_safe .. "}\n"
    )
  elseif string.match(file, "^CHANGELOG%.md$") then
    local url = "https://github.com/gusbrs/postnotes/compare/"
    content = string.gsub(
      content,
      "(## %[Unreleased%]%(.-)%.%.%.HEAD%)",
      "%1...v" .. tagname_safe .. ") (" .. tagdate .. ")"
    )
    content = string.gsub(
      content,
      "## %[Unreleased%]",
      "## [Unreleased](" .. url .. "v" .. tagname_safe .. "...HEAD)\n\n"
      .. "## [v" .. tagname_safe .. "]"
    )
    -- Handle CTAN release announcement.
    -- The `or ""` is meant to cover the case of the *first* release, for
    -- which there will be no match for that pattern.  It must be done
    -- manually.
    local tagname_safe_escaped = string.gsub(tagname_safe, "%p", "%%%1")
    local announcement = string.match(
      content, "\n(## %[v" .. tagname_safe_escaped .. "%].-\n)## %[v"
    ) or ""
    announcement = string.gsub(
      announcement,
      "## %[v" .. tagname_safe_escaped .. "%]%(https.-%)",
      "## v" .. tagname_safe
    )
    -- File operations based on 'update_file_tag' function of
    -- 'l3build-tagging.lua'.
    local annfile = uploadconfig.announcement_file
    local annfilename = basename(annfile)
    local annpath = dirname(annfile)
    ren(annpath,annfilename,annfilename .. ".bak")
    local af = assert(io.open(annfile,"w"))
    af:write((string.gsub(announcement,"\n",os_newline)))
    af:close()
    rm(annpath,annfilename .. ".bak")
  elseif string.match(file, "^build%.lua$") then
    content = string.gsub(
      content,
      "(\nuploadconfig%s*=%s*%{%s*version%s*=%s*\")[^\"]*(\")",
      "%1" .. tagname_safe .. "%2"
    )
  end
  -- Handle copyright notice.
  if string.match(file, "^postnotes%.dtx$") or
     string.match(file, "^postnotes%.ins$") or
     string.match(file, "^postnotes%.tex$") or
     string.match(file, "^postnotes%-code%.tex$") then
    local tagyear = string.match(tagdate, "%d%d%d%d")
    if string.match(content, "Copyright%D-%d%d%d%d%-%d%d%d%d") then
      if not string.find(content, "Copyright%D-%d%d%d%d*%-" .. tagyear) then
        content = string.gsub(
          content,
          "Copyright(%D-)(%d%d%d%d%-)%d%d%d%d",
          "Copyright%1%2" .. tagyear
        )
      end
    else
      if not string.find(content, "Copyright%D-" .. tagyear) then
        content = string.gsub(
          content,
          "Copyright(%D-)(%d%d%d%d)",
          "Copyright%1%2-" .. tagyear
        )
      end
    end
  end
  return content
end

function tag_hook(tagname)
  local tagname_safe = string.gsub(tagname, "^v", "")
  os.execute('git commit -a -m "Step release tag"')
  os.execute('git tag -a -m "" v' .. tagname_safe)
end
