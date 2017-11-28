%% csfourzero Class for LaTeX2e.

%% Original version
%% 25th October 2012, Tim Norman <t.j.norman@abdn.ac.uk>
%%

\def \fileversion{1.0}
\def \filedate{2012/10/25}

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{csfourzero}[\filedate\space\fileversion\space CS4040 Report Class]

\RequirePackage{ifthen}
\RequirePackage{ifpdf}

% Graphicsx with support for pdflatex
\ifpdf%
        \RequirePackage[pdftex]{graphicx}
\else%
        \RequirePackage[dvips]{graphicx}
\fi%

\newcommand{\pntsize}{}       % the default font size
\newboolean{coverpage}        % whether to produce a standard cover page

%%
%%  --- Options ---
%%

\newcommand{\optionerror}[1]
   {\typeout{*** Warning: #1 is not a legal class option}}

\DeclareOption{coverpage}{\setboolean{coverpage}{true}}
\DeclareOption{nocoverpage}{\setboolean{coverpage}{false}}

\DeclareOption{12pt}{\renewcommand{\pntsize}{12pt}}
\DeclareOption{11pt}{\renewcommand{\pntsize}{11pt}}
\DeclareOption{10pt}{\renewcommand{\pntsize}{}}

\DeclareOption{twocolumn}{\OptionNotUsed\optionerror{twocolum}}
\DeclareOption{parskip}{\AtEndOfClass{\input{parskip.clo}}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ExecuteOptions{11pt,coverpage,times}   % the default options

% Computer Modern maths font option.
% If you want to use Computer Modern as the maths font, use this option.
\newif\ifcmmathp@
\cmmathp@false
\DeclareOption{cmmath}{\cmmathp@true}

\ProcessOptions

%%
%% --- Class Loading (built on article.cls) ---
%%

\LoadClass[a4paper,\pntsize]{article}

%%
%% --- Package Loading ---
%%

\RequirePackage{a4wide}           % use this for margin settings

% Used to set line spacing given options of single, double or 1.5 (default)
\RequirePackage{setspace}
\newif\ifsinglesp@
\newif\ifdoublesp@
\doublesp@false

%% Set up line spacing
\AtBeginDocument{%
\ifdoublesp@%
  \doublespacing%
\else\ifsinglesp@%
  \singlespacing%
\else%
  \onehalfspacing%
\fi%
\fi
}

%%
%% --- Main Code ---
%%

\renewenvironment{abstract}{}
   {\typeout{Abstract environment not available: use abstract{...} instead}}

%% Redefine \maketitle

\newcommand{\department}{Department of Computing Science}
\newcommand{\university}{University of Aberdeen}

\renewcommand{\author}[2][]{
   \newcommand{\@author}{#2}
   \ifthenelse{\equal{#1}{}}
   {\newcommand{\@coverauthor}{#2}}
   {\newcommand{\@coverauthor}{#1}}
}
\let\@author\relax
\let\@coverauthor\relax

\renewcommand{\title}[2][]{
   \newcommand{\@title}{#2}
   \ifthenelse{\equal{#1}{}}
   {\newcommand{\@covertitle}{#2}}
   {\newcommand{\@covertitle}{#1}}
}
\let\@title\relax
\let\@covertitle\relax

\def\abstract#1{\gdef\@abstract{#1}} 
\let\@abstract\relax
\def\abstractname{Abstract}

\def\@mymaketitle{
  \begin{center}
    {\LARGE\bfseries\@title\par}\vskip 1.5em
    {\large\lineskip .5em
      \begin{tabular}[t]{c}
        \@author \vspace{6pt}\\
        \department\\ \university
      \end{tabular}\par}%
    \vskip 1em%
    {\large \@date}%
  \end{center}%
  \par\vskip 1.5em

  \ifx\@abstract\relax\else
    {\small\quotation\noindent{\bf\abstractname:} \@abstract}\endquotation
  \fi
  \null\par
}

\def\cleartitlevars{
  \global\let\thanks\relax
  \global\let\maketitle\relax
  \global\let\title\relax
  \global\let\author\relax
  \global\let\date\relax
  \global\let\and\relax
}

\renewcommand{\maketitle}{
    \frontcoverpage
    \par
    \begingroup
    \renewcommand{\thefootnote}{\@fnsymbol\c@footnote}%
    \newpage
    \global\@topnum\z@   % Prevents figures from going at top of page.
    \let\footnote\thanks
    \@mymaketitle
    \thispagestyle{plain}\@thanks
    \endgroup
    \setcounter{footnote}{0}
    \cleartitlevars
}

%%
%% Check for a cover page request
%%

\newcommand{\frontcoverpage}{\ifthenelse{\boolean{coverpage}}{\cscoverpage}}

%%
%% Cover page
%%

%\sfdefault

\DeclareFixedFont{\cp@BigDeptNameFont}%
  {\encodingdefault}{ptm}{b}{n}{22pt}

\DeclareFixedFont{\cp@DeptNameFont}%
  {\encodingdefault}{ptm}{b}{n}{12pt}

\DeclareFixedFont{\cp@DeptAddressFont}%
  {\encodingdefault}{ptm}{m}{n}{11pt}

\DeclareFixedFont{\cp@DeptHeadingFont}%
  {\encodingdefault}{ptm}{m}{n}{10pt}

\DeclareFixedFont{\cp@NumberFont}%
  {\encodingdefault}{ptm}{b}{n}{12pt}

\DeclareFixedFont{\cp@TitleFont}%
  {\encodingdefault}{ptm}{b}{n}{14pt}

\DeclareFixedFont{\cp@AuthorFont}%
  {\encodingdefault}{ptm}{m}{n}{14pt}

%%
%% A couple of useful little commands that we are going to use
%%

\providecommand{\cprule}{\vspace*{-3pt}\\\rule{\linewidth}{1mm}\vspace*{-3pt}}

\providecommand{\cp@monthyear}{%
  \ifcase\month\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December%
  \fi
  \space
  \number\year}

%% Declare shortyear as the number of years from the start of this
%% century.

\newcounter{shortyear}
\setcounter{shortyear}{\year}\addtocounter{shortyear}{-2000}

\newcommand{\cscoverpage}{%
 \begin{titlepage}%
   \baselineskip 12pt%
   \vspace*{-50pt}
   \begin{minipage}[b]{4.31in}%
   \cp@BigDeptNameFont\noindent\cp@deptname\hfill%
   \vspace*{0.4ex}\cprule\vspace*{1.5ex}
   \end{minipage}\hfill
   \begin{minipage}[b]{1in}
   %[width=0.8\textwidth,natwidth=610,natheight=642]
   \includegraphics{abdnshield.pdf}
   \end{minipage}
   \begin{flushright}\end{flushright}
   \vspace*{\stretch{1}}
   \begin{centering}
     \begin{minipage}{0.8\textwidth}
       \begin{centering}
       \cp@TitleFont\@covertitle\\[6ex]
       \cp@AuthorFont
       \begin{tabular}[t]{c}%
         \ignorespaces\@coverauthor
       \end{tabular}\\
       \end{centering}
     \end{minipage}\\
   \end{centering}\vspace*{1.0in}
   \begin{minipage}{\textwidth}
     \cp@DeptAddressFont No portion of the work contained in this
     document has been submitted in support of an application for a
     degree or qualification of this or any other university or
     other institution of learning.  All verbatim extracts have been
     distinguished by quotation marks, and all sources of
     information have been specifically acknowledged.\\[5ex]
     Signed:\hspace*{\fill}\\[3ex]
     Date: \@date \hspace*{\fill}
   \end{minipage}%
   \vspace*{\stretch{1}}
   \cp@DeptNameFont CS4040 Report\\
   \cprule\vspace*{0.4ex}\\
   \cp@DeptNameFont Department of \cp@deptname\ \hfill 
      \cp@NumberFont\cp@monthyear\\
   \ignorespaces\cp@DeptAddressFont\cp@deptaddress%
 \end{titlepage}
}

\providecommand{\cp@deptname}
  {Computing Science}

\providecommand{\cp@deptaddress}
  {University of Aberdeen\\%
   King's College\\%
   Aberdeen\hspace{1em} AB24 3UE}

% Some other fixes to lengths 
\setlength \parindent{2em}
\setlength \parskip  {\z@ \@plus 1\p@}
\setlength \headsep  {16\p@}
\ifcase \@ptsize
    \setlength \footskip{28\p@}
\or
    \setlength \footskip{29\p@}
\or
    \setlength \footskip{30\p@}
\fi
\setlength \partopsep {\z@}
\tolerance 1200
\vfuzz 2pt
\hfuzz 2pt
\flushbottom
\renewcommand \footnoterule {%
    \kern -3\p@%
    \hrule%
    \kern 2.6\p@%
}

\ifcmmathp@% 
% Only switch text to Times and keep Computer Modern for all math
        \renewcommand\rmdefault{ptm}
\else%
% Switch to Times font for text AND math, but keep Computer Modern for mathcal,
% as Times mathcal is UGLY
        \RequirePackage{mathptmx}
        \SetMathAlphabet{\mathcal}{normal}{OMS}{cmsy}{m}{n}
        \SetMathAlphabet{\mathcal}{bold}{OMS}{cmsy}{b}{n}
\fi%

%% Fancy headers
\RequirePackage{fancyhdr}
\setlength{\headheight}{14pt}
\pagestyle{fancy}
\fancyhf{}
\renewcommand{\sectionmark}[1]{\markright{\thesection.\ #1}}
\lhead{\textsc{\rightmark}}
\rhead{\thepage}

% Pretty captions (affects captions in subfig package as well, unless
% new options are specified for subfig)
\RequirePackage[font=small,bf, justification=centerlast, margin=\parindent]{caption}

% Standard math packages
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}

\renewcommand \tableofcontents{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \contentsname%
        \@mkboth{\contentsname}{\contentsname}%
    }%
    \@starttoc{toc}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewcommand \listoffigures{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \listfigurename%
        \@mkboth{\listfigurename}{\listfigurename}%
    }%
    \@starttoc{lof}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewcommand \listoftables{%
    \if@twocolumn%
        \@restonecoltrue \onecolumn%
    \else%
        \@restonecolfalse%
    \fi%
    \chapter*{%
        \listtablename%
        \@mkboth{\listtablename}{\listtablename}%
    }%
    \@starttoc{lot}%
    \if@restonecol%
        \twocolumn%
    \fi%
}
\renewenvironment{thebibliography}[1]{%
    \chapter*{%
        \bibname%
        \@mkboth{\bibname}{\bibname}%
    }%
    \list{\@biblabel{\arabic{enumiv}}}%
         {\settowidth \labelwidth{\@biblabel{#1}}%
          \leftmargin \labelwidth%
          \advance \leftmargin \labelsep%
          \if@openbib%
              \advance \leftmargin \bibindent%
              \itemindent -\bibindent%
              \listparindent \itemindent%
              \parsep \z@%
          \fi%
          \usecounter{enumiv}%
          \let \p@enumiv \@empty%
          \renewcommand \theenumiv{\arabic{enumiv}}%
         }%
    \if@openbib%
        \renewcommand \newblock{\par}%
    \else%
        \renewcommand \newblock{\hskip .11em \@plus.33em \@minus.07em}%
    \fi%
    \sloppy%
    \clubpenalty 4000%
    \widowpenalty 4000%
    \sfcode`\.=\@m%
}{%
    \def \@noitemerr{\@latex@warning{Empty `thebibliography' environment}}%
    \endlist%
}
\renewenvironment{theindex}{%
    \if@twocolumn%
        \@restonecolfalse%
    \else%
        \@restonecoltrue%
    \fi%
    \columnseprule \z@%
    \columnsep 35\p@%
    \twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\indexname}{\indexname}%
    \thispagestyle{plain}%
    \small%
    \parindent \z@%
    \parskip \z@ \@plus .3\p@%
    \relax%
%%%
%%%  It appears that there is an error in the definition of \@idxitem
%%%  which causes horrid looking indexes.  Redefine the miscreant
%%%  so as to insert the missing \par.  NB.  Cannot use
%%%  |\renewcommand| since this appears not to work on outer block,
%%%  even if |\global| is used.
%%%
    \gdef \@idxitem{\par \hangindent 40\p@}
    \let \item \@idxitem%
}{%
    \if@restonecol%
        \onecolumn%
    \else%
        \clearpage%
    \fi%
}

% Modify the section heading styles
\renewcommand \section{\@startsection {section}{1}{\z@}%
                                      {-1ex \@plus -.4ex \@minus -.2ex}%
                                      {.6ex \@plus .1ex}%
                                      {\reset@font \Large \bfseries}}

\renewcommand \subsection{\@startsection{subsection}{2}{\z@}%
                                        {-.7ex\@plus -.3ex \@minus -.2ex}%
                                        {.4ex \@plus .1ex}%
                                        {\reset@font \large \bfseries}}

\renewcommand \subsubsection{\@startsection{subsubsection}{3}{\z@}%
                                        {-.5ex\@plus -.2ex \@minus -.2ex}%
                                        {.3ex \@plus .1ex}%
                                        {\reset@font \large}}

\renewcommand \paragraph{\@startsection{paragraph}{4}{\z@}%
                                       {.5ex \@plus .1ex \@minus .2ex}%
                                       {-.2em}%
                                       {\reset@font \normalsize \bfseries}}

\renewcommand \subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                          {-.3ex \@plus .1ex \@minus .2ex}%
                                          {-.2em}%
                                          {\reset@font \normalsize \bfseries}}

\setcounter{secnumdepth}{2}

\endinput

