%% -*- latex -*-
%% 
%% PhD Thesis class
%%
%% Time-stamp: "04 Nov 1999 17:26 Martin Berger"
%% 
%% started:     07 Feb 1996       Martin Berger
%% 
\def\filename{diss}
\def\fileversion{v1.0}
\def\filedate{1999/10/30}
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{diss}
  [\filedate\space \fileversion\space PhD thesis class (mb)]

%% define several if's
\newif\if@modern \@modernfalse
\newif\if@header@rule \@header@ruletrue
\newif\if@mathbold \@mathboldfalse
\newif\if@bibstyle \@bibstyletrue
\newif\if@timestamp \@timestampfalse
\newif\if@Afive \@Afivefalse

%% define default string for title of abbreviation list
\newcommand\listabbrevname{List of Abbreviations}
\newcommand\listsymbolname{List of Symbols}
\newcommand\acknowledgename{Acknowledgments}
\newcommand\curriculumvitaename{Curriculum Vitae}

%% define default size (changed to 10pt if a5paper)
\def\biwitr@ptsize{12pt}

\DeclareOption{modern}{\@moderntrue}
\DeclareOption{norule}{\@header@rulefalse}
\DeclareOption{mathnormal}{\@mathboldfalse}
\DeclareOption{mathbold}{\@mathboldtrue}
\DeclareOption{nobibstyle}{\@bibstylefalse}
\DeclareOption{german}{%
  \def\listabbrevname{Abk\"urzungsverzeichnis}
  \def\listsymbolname{Symbolverzeichnis}
  %%\def\acknowledgename{Danksagung}
  \def\curriculumvitaename{Lebenslauf}
  \PassOptionsToClass{\CurrentOption}{report}}
\DeclareOption{timestamp}{%
  \@timestamptrue
  \date{\number\day\space\ifcase\month\or
    Jan\or Feb\or Mar\or Apr\or May\or Jun\or
    Jul\or Aug\or Sep\or Oct\or Nov\or Dec\fi
    \space\number\year}}

\DeclareOption{a5paper}{%
  \@Afivetrue
  \def\biwitr@ptsize{10pt}% set default size to 10pt
  \PassOptionsToClass{\CurrentOption}{report}}

%% declare generic options (just pass on)
\DeclareOption{10pt}{\def\biwitr@ptsize{10pt}}
\DeclareOption{11pt}{\def\biwitr@ptsize{11pt}}
\DeclareOption{12pt}{\def\biwitr@ptsize{12pt}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}

%% process options in the order specified here and load base class
\ProcessOptions\relax
\LoadClass[\biwitr@ptsize]{report}

\RequirePackage{soul} % for letterspacing 
    \sodef\allcapsspacing{\upshape}{0.15em}{0.65em}{0.6em}
	%\sodef\lowsmallcapsspacing{\scshape}{0.075em}{0.5em}{0.6em}     
	\sodef\lowsmallcapsspacing{\scshape}{0.045em}{0.4em}{0.5em}    
	%\DeclareRobustCommand{\spacedallcaps}[1]{%
	%	\protected@edef\@myXtemp{\MakeTextUppercase{\allcapsspacing{#1}}}\@myXtemp}
    \DeclareRobustCommand{\spacedallcaps}[1]{\MakeTextUppercase{\allcapsspacing{#1}}}     
	%\DeclareRobustCommand{\spacedlowsmallcaps}[1]{%
	%	%\protected@edef\@myYtemp{\textsc{\lowsmallcapsspacing{\MakeTextLowercase{#1}}}}\@myYtemp}
	%	\protected@edef\@myYtemp{\MakeTextLowercase{\textsc{\lowsmallcapsspacing{#1}}}}\@myYtemp}
	\DeclareRobustCommand{\spacedlowsmallcaps}[1]{\MakeTextLowercase{\textsc{\lowsmallcapsspacing{#1}}}}   

\if@bibstyle
  %\RequirePackage{named-nocomma}
  %\bibliographystyle{agsm} %%{abbrvnat}
  \bibliographystyle{alpha} %% abbrvnat
\fi

\if@modern
  \RequirePackage{avant}
\fi

\if@Afive
  %% page layout for A5 paper
  \setlength{\topmargin}{-14.4mm}%      top:     11mm
  \setlength{\headheight}{4mm}
  \setlength{\headsep}{8mm}
  \setlength{\textheight}{169mm}%       bottom:  18mm
  \setlength{\textwidth}{110mm}
  \setlength{\oddsidemargin}{-4.4mm}%   inside:  21mm
  \setlength{\evensidemargin}{-7.9mm}%  outside: 17.5mm
  \setlength{\footskip}{8mm}
\else
  %% page layout for A4 paper
  %%
  %% LaTeX default values for A4 paper:
  %%  \topmargin ........  7.0mm   ( 20pt)
  %%  \headheight .......  4.3mm   ( 12pt)
  %%  \headsep ..........  8.7mm   ( 25pt)
  %%  \textheight .......          (592pt)
  %%  \textwidth ........          (390pt)
  %%  \oddsidemargin ....          ( 10pt)
  %%  \evensidemargin ...          ( 52pt)
  %%  \footskip .........          ( 30pt)
  %%
  %% new margins:
  %% - top .......... 25mm
  %% - bottom ....... 32mm
  %% - left/right ... 30mm
  \setlength{\topmargin}{-0.4mm}
  \setlength{\headheight}{5mm}
  \setlength{\headsep}{10mm}
  \setlength{\textheight}{225mm}
  \setlength{\textwidth}{150mm}
  \setlength{\oddsidemargin}{4.6mm}
  \setlength{\evensidemargin}{4.6mm}
  %\setlength{\parskip}{0pt}
\fi

%%\renewcommand{\familydefault}{cmss}
%%\renewcommand{\familydefault}{times}

\def\centermark{}
\newcommand{\headCenter}[1]{\def\centermark{#1}}
\headCenter{}

\setcounter{secnumdepth}{3}

\if@twoside
  \def\ps@headings{%
    \if@timestamp
      \def\@oddfoot{{\tiny\strut\hfill\@date}}
      \def\@evenfoot{{\tiny\@date\hfill\strut}}
    \else
      \let\@oddfoot\@empty\let\@evenfoot\@empty
    \fi
    \def\@evenhead{%
      \if@header@rule\hbox to0pt{\rule[-4pt]{\textwidth}{0.25pt}\hss}\fi
      \makebox[0.33\textwidth][l]{\thepage}\hfill
      \makebox[0.34\textwidth]{\centermark}\hfill
      \makebox[0.33\textwidth][r]{\slshape\leftmark}}%
    \def\@oddhead{%\underline{\makebox[\textwidth][l]{%
      \if@header@rule\hbox to0pt{\rule[-4pt]{\textwidth}{0.25pt}\hss}\fi
      \makebox[0.33\textwidth][l]{\slshape\rightmark}\hfill
      \makebox[0.34\textwidth]{\centermark}\hfill
      \makebox[0.33\textwidth][r]{\thepage}}%
    \let\@mkboth\markboth
    \def\chaptermark##1{\markboth {% deleted: \MakeUppercase{%
          \ifnum \c@secnumdepth >\m@ne \@chapapp\ \thechapter. \ 
          \fi ##1}{}}%
    \def\sectionmark##1{\markright {% deleted: \MakeUppercase{%
          \ifnum \c@secnumdepth >\z@ \thesection. \ 
          \fi ##1}}}
\else
  \def\ps@headings{%
    \if@timestamp
      \def\@oddfoot{{\tiny\strut\hfill\@date}}
    \else
      \let\@oddfoot\@empty
    \fi
    \def\@oddhead{%\underline{\makebox[\textwidth][l]{%
      \if@header@rule\hbox to0pt{\rule[-4pt]{\textwidth}{0.25pt}\hss}\fi
      \makebox[0.33\textwidth][l]{\slshape\rightmark}\hfill
      \makebox[0.34\textwidth]{\centermark}\hfill
      \makebox[0.33\textwidth][r]{\thepage}}%
    \let\@mkboth\markboth
    \def\chaptermark##1{\markright {% deleted: \MakeUppercase{%
          \ifnum \c@secnumdepth >\m@ne \@chapapp\ \thechapter. \ 
          \fi ##1}}}
\fi
\ps@headings

%% Redefine \cleardoublepage to leave completely blank page
\renewcommand\cleardoublepage{\clearpage\if@twoside \ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi\fi}

%% Redefine \chapter command (adapted from report.cls)
\renewcommand\chapter{\if@openright\cleardoublepage\else\clearpage\fi
  \thispagestyle{plain}%
  \global\@topnum\z@
  \@afterindentfalse
  \secdef\@chapter\@schapter  
}

%% Redefine \tableofcontents command (adapted from report.cls)
\renewcommand\tableofcontents{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\contentsname\@mkboth{\spacedlowsmallcaps{\contentsname}}{\spacedlowsmallcaps{\contentsname}}}
  \@starttoc{toc}%
  \if@restonecol\twocolumn\fi
  }
  
%% Redefine \listoffigure command (adapted from report.cls)
\renewcommand\listoffigures{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\listfigurename\@mkboth{\spacedlowsmallcaps{\listfigurename}}{\spacedlowsmallcaps{\listfigurename}}}%
  \@starttoc{lof}%
  \if@restonecol\twocolumn\fi
  }
  
%% Redefine \listoftables command (adapted from report.cls)
\renewcommand\listoftables{%
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  \chapter*{\listtablename\@mkboth{\spacedlowsmallcaps{\listtablename}}{\spacedlowsmallcaps{\listtablename}}}%
  \@starttoc{lot}%
  \if@restonecol\twocolumn\fi
  }
  
%% Redefine \thebibliography environment (adapted from report.cls)
\renewenvironment{thebibliography}[1]
     {\chapter*{\bibname\@mkboth{\spacedlowsmallcaps{\bibname}}{\spacedlowsmallcaps{\bibname}}}%
      \list{\@biblabel{\@arabic\c@enumiv}}%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \itemsep 0pt
            \advance\leftmargin\labelsep
            \@openbib@code
            \usecounter{enumiv}%
            \let\p@enumiv\@empty
            \renewcommand\theenumiv{\@arabic\c@enumiv}}%
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.\@m}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
      
%% Redefine \theindex environment (adapted from report.cls)
\renewenvironment{theindex}
  {\if@twocolumn
      \@restonecolfalse
    \else
      \@restonecoltrue
    \fi
    \columnseprule \z@
    \columnsep 35\p@
    \twocolumn[\@makeschapterhead{\indexname}]%
    \@mkboth{\spacedlowsmallcaps{\indexname}}{\spacedlowsmallcaps{\indexname}}%
    \thispagestyle{plain}\parindent\z@
    \parskip\z@ \@plus .3\p@\relax
    \let\item\@idxitem}
  {\if@restonecol\onecolumn\else\clearpage\fi}


%% new definition for the chapter title:
%% \@makechapterhead{TEXT} : Makes the heading for the \chapter command.
\def\@makechapterhead#1{%             Heading for \chapter command
  \if@Afive
    \if@modern \font\nrfont=pagd at 54pt
    \else      \font\nrfont=cmbx12 at 54pt
    \fi
    %\font\nrfont=ptmb at 54pt
  \else
    \if@modern \font\nrfont=pagd at 75pt
    \else      \font\nrfont=cmbx12 at 75pt
    \fi
    %\font\nrfont=ptmb at 75pt
  \fi
  \vspace*{5\p@}%                     space at top of text page.
  { \parindent \z@ \raggedright \normalfont
    \ifnum \c@secnumdepth >\m@ne    % IF secnumdepth > -1 THEN
      {\nrfont \thechapter}%          print number.
        \par\nobreak
        \if@Afive\vskip 15\p@\else\vskip 20\p@\fi
                                    % space between number and title.
    \fi
    \interlinepenalty\@M
    \if@modern
      \sffamily\if@Afive\LARGE\else\huge\fi
    \else
      \if@Afive\huge\else\Huge\fi
    \fi
    \bfseries #1\par\nobreak  % title.
    \if@Afive\vskip 28\p@\else\vskip 40\p@\fi
                                    % space between title and text.
  }}
%% \@makeschapterhead{TEXT} : Makes the heading for the \chapter* command.
\def\@makeschapterhead#1{%
  \if@Afive\vspace*{35\p@}\else\vspace*{50\p@}\fi
  %
  {\parindent \z@ \raggedright
    \normalfont
    \interlinepenalty\@M
    \if@modern
      \sffamily\if@Afive\LARGE\else\huge\fi
    \else
      \if@Afive\huge\else\Huge\fi
    \fi
    \bfseries #1\par\nobreak
    \if@Afive\vskip 28\p@\else\vskip 40\p@\fi
  }}

\renewcommand\section{\@startsection{section}{1}{\z@}%
                                    {-3.5ex \@plus -1ex \@minus -.2ex}%
                                    {2.3ex \@plus.2ex}%
                                    {\normalfont\if@modern\sffamily
                                      \large\else\Large\fi\bfseries}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
                                       {-3.25ex\@plus -1ex \@minus -.2ex}%
                                       {1.5ex \@plus .2ex}%
                                       {\normalfont\if@modern\sffamily
                                         \normalsize\else\large\fi\bfseries}}

%% new definition for the figure and table caption (from report.sty)
%% \@makecaption{NUMBER}{TEXT} : Macro to make a figure or table caption.  
%%      NUMBER : Figure or table number--e.g., 'Figure 3.2' 
%%      TEXT   : The caption text.
%\long\def\@makecaption#1#2{%
%  \vskip\abovecaptionskip
%%  \sbox\@tempboxa{\textsl{\textbf{#1}: #2}}%
%  \ifdim \wd\@tempboxa >\hsize
%    \textsl{\textbf{#1}: #2}\par
%    \else
%    \global \@minipagefalse
%    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
%    \fi
%    \vskip\belowcaptionskip}

%% new command for starting next page with odd number
%% (also works if not two-sided output, adapted from \cleardoublepage)
\newcommand{\clearoddpage}{\clearpage\ifodd\c@page\else
    \hbox{}\thispagestyle{empty}\newpage\if@twocolumn\hbox{}\newpage\fi\fi}

%% new definition for an abstract (in a report)
\renewenvironment{abstract}{\chapter*{\abstractname
    \@mkboth{\spacedlowsmallcaps{\abstractname}}{\spacedlowsmallcaps{\abstractname}}}}{}

%% new definition for a list of abbreviations
\newcommand{\@loalabel}[1]{\textbf{#1}}
\newenvironment{listofabbrevs}[1]
     {\chapter*{\listabbrevname\@mkboth{\spacedlowsmallcaps{\listabbrevname}}{\spacedlowsmallcaps{\listabbrevname}}}%
      \list{}%
           {\settowidth\labelwidth{\@loalabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep 0pt
            \renewcommand{\makelabel}[1]{\@loalabel{##1}\hfill}}%
     }
     {\endlist}

%% new definition for a list of symbols
\newcommand{\@loslabel}[1]{#1}
\newenvironment{listofsymbols}[1]
     {\chapter*{\listsymbolname\@mkboth{\spacedlowsmallcaps{\listsymbolname}}{\spacedlowsmallcaps{\listsymbolname}}}%
      \list{}%
           {\settowidth\labelwidth{\@loslabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
            \itemsep 0pt
            \renewcommand{\makelabel}[1]{\@loslabel{##1}\hfill}}%
     }
     {\endlist}

%% new definition for an acknowledgement
\newenvironment{acknowledgment}{\chapter*{\acknowledgename
    \@mkboth{\spacedlowsmallcaps{\acknowledgename}}{\spacedlowsmallcaps{\acknowledgename}}}}{}

%% new definition for a curriculum vitae
\newenvironment{curriculumvitae}{\chapter*{\curriculumvitaename
    \@mkboth{\spacedlowsmallcaps{\curriculumvitaename}}{\spacedlowsmallcaps{\curriculumvitaename}}}}{}

%% define list environment for cv
\newenvironment{cvsection}[2]{%
  \subsection*{#1}
  \begin{list}{\textbullet\hfill\strut}{\raggedright
      \setlength{\labelwidth}{#2}\setlength{\leftmargin}{\labelwidth}%
      \addtolength{\leftmargin}{\labelsep}%
      \renewcommand{\makelabel}[1]{##1\hfill}%
      \setlength{\itemsep}{0pt}\setlength{\parsep}{0pt}}%
    }{\end{list}}

%% define internal command
\newcommand{\@eqbold}[1]{\mathchoice{\mbox{\boldmath$\displaystyle{#1}$}}
  {\mbox{\boldmath$\textstyle{#1}$}}
  {\mbox{\boldmath$\scriptstyle{#1}$}}
  {\mbox{\boldmath$\scriptscriptstyle{#1}$}}}

%% commands in math environment
\newcommand{\Real}{{\it I\!\!R}}
\newcommand{\RealN}[1]{{\it I\!\!R^{#1}}}
\newcommand{\abs}[1]{| #1 |}
\newcommand{\ABS}[1]{\left| #1 \right|}

\newcommand{\dotprod}[2]{#1\bullet#2}
\newcommand{\deriv}[2]{\frac{d #1}{d #2}}
\newcommand{\pderiv}[2]{\frac{\partial #1}{\partial #2}}
\newcommand{\pqderiv}[3]{\frac{\partial^2 #1}{{\partial #2}{\partial #3}}}
\newcommand{\ppderiv}[2]{\frac{\partial^2 #1}{{\partial #2}^2}}
\newcommand{\eqnsp}{\:}% space before period in equations.

\newcommand{\vc}[1]{#1}                   % vector
\newcommand{\mat}[1]{#1}                  % matrix
\newcommand{\vcT}[1]{\vc{#1^T\!}}         % transposed vector
\newcommand{\matT}[1]{\mat{#1^T\!}}       % transposed matrix
\newcommand{\matInv}[1]{\mat{#1^{-\!1}}}  % inverse matrix
\newcommand{\ssT}{{T\!}}                  % superscript for transpose
\newcommand{\ssInv}{{-\!1}}               % superscript for inverse matrix
\if@mathbold
  %%\typeout{bold math style.}
  \renewcommand{\vc}[1]{\@eqbold{#1}}
  \renewcommand{\mat}[1]{\@eqbold{#1}}
  \renewcommand{\ssT}{{\mathbf{T\!}}}
  \renewcommand{\ssInv}{{\mathbf{-\!1}}}
\fi

%% hack from dante faq for mixed float object (figure-table)
\newcommand{\setfloattype}[1]{\renewcommand{\@captype}{#1}}

\endinput
