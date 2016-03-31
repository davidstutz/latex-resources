%%
%% This is file `siamart.cls', based on article.cls
%% Revision of siam macros for use with LaTeX 2e
%% 
%% August 2015
%%
%% Major overhaul including hyperlinks, clever cross-references, and
%% supplemental file support.
%% 
%% You are not allowed to change this file. 
%% 
%% You are allowed to distribute this file under the condition that 
%% it is distributed together with all of the files in the siam macro 
%% distribution. These are:
%%
%% * siamart.cls: Main LaTeX class file (this file)
%% * siamplain.bst: Bibliographic style file for BibTeX
%% * docsiamart.tex: Produces documentation
%% * docsiamart.pdf: Documentation
%% * references.bib: BibTeX database for documentation and examples
%% * ex_article.tex: Template for article
%% * ex_supplement.tex: Template for supplement
%% * ex_shared.tex: Template for article/supplement shared info
%%
%% If you receive only some of these files from someone, complain! 
%% 
%% You are NOT ALLOWED to distribute this file alone. You are NOT 
%% ALLOWED to take money for the distribution or use of either this 
%% file or a changed version, except for a nominal charge for copying 
%% etc. 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
% [[[TODO: Update date and version in next line]]]
\ProvidesClass{siamart0216}[2016/02/26 v1.4 LaTeX document e-class]
%%
%% <<tgk<<
%%
\RequirePackage[leqno]{amsmath}[2.14]
\newcommand\@ptsize{}
\newif\if@restonecol
\newif\if@titlepage
\@titlepagefalse
%_%_%_%_%add class option to change hyperref driver for Bakoma
\newif\if@bakoma
\@bakomafalse
%_%_%_%_%add class option to turn of hypdvips
\newif\if@nohypdvips
\@nohypdvipsfalse
%%
%% >>tgk>> --- Removed Summer 2015 ---
%%
% \newif\if@oneeqnum
% \@oneeqnumfalse
% \newif\if@onetabnum
% \@onetabnumfalse
% \newif\if@onefignum
% \@onefignumfalse
% \newif\if@onethmnum
% \@onethmnumfalse
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for "review" class option to turn on features like line
%% numbers for paper under review.
\newif\if@review
\@reviewfalse
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for "supplement" class option to change title and labels
%% appropriately for supplemental materials.
\newif\if@supplement
\@supplementfalse
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for "hidelinks" class option to hide hyperlinks.
\newif\if@hidelinks
\@hidelinksfalse
%%
%% <<tgk<<
%%
%_%_%_%_%
\newif\if@translated
\@translatedfalse
%_%_%_%_%
%\newif\if@openbib
%\@openbibfalse
\DeclareOption{a4paper}
   {\setlength\paperheight {297mm}%
    \setlength\paperwidth  {210mm}}
\DeclareOption{a5paper}
   {\setlength\paperheight {210mm}%
    \setlength\paperwidth  {148mm}}
\DeclareOption{b5paper}
   {\setlength\paperheight {250mm}%
    \setlength\paperwidth  {176mm}}
\DeclareOption{letterpaper}
   {\setlength\paperheight {11in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{legalpaper}
   {\setlength\paperheight {14in}%
    \setlength\paperwidth  {8.5in}}
\DeclareOption{executivepaper}
   {\setlength\paperheight {10.5in}%
    \setlength\paperwidth  {7.25in}}
\DeclareOption{landscape}
   {\setlength\@tempdima   {\paperheight}%
    \setlength\paperheight {\paperwidth}%
    \setlength\paperwidth  {\@tempdima}}
\DeclareOption{10pt}{\renewcommand\@ptsize{0}}
\DeclareOption{11pt}{\renewcommand\@ptsize{1}}
\DeclareOption{12pt}{\renewcommand\@ptsize{2}}
\DeclareOption{twoside}{\@twosidetrue  \@mparswitchtrue}
\DeclareOption{draft}{\setlength\overfullrule{5pt}}
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for new class options
\DeclareOption{review}{\@reviewtrue}
\DeclareOption{supplement}{\@supplementtrue}
\DeclareOption{hidelinks}{\@hidelinkstrue}
\DeclareOption{bakoma}{\@bakomatrue}
\DeclareOption{nohypdvips}{\@nohypdvipstrue}
%%
%% <<tgk<<
%%
\DeclareOption{final}{\setlength\overfullrule{0pt}}
\DeclareOption{notitlepage}{\@titlepagefalse}
\DeclareOption{onecolumn}{\@twocolumnfalse}
\DeclareOption{twocolumn}{\@twocolumntrue}
%%
%% >>tgk>> --- Removed Summer 2015 ---
%%
% \DeclareOption{leqno}{\input{leqno.clo}}
% \DeclareOption{subeqn}{\input{subeqn.clo}}
% \DeclareOption{oneeqnum}{\@oneeqnumtrue} % added 7.19.96
% \DeclareOption{onetabnum}{\@onetabnumtrue} % added 7.19.96
% \DeclareOption{onefignum}{\@onefignumtrue} % added 7.19.96
% \DeclareOption{onethmnum}{\@onethmnumtrue} % added 7.29.96
%%
%% <<tgk<<
%%
\DeclareOption{translated}{\@translatedtrue} % jan 7 2004
%\DeclareOption{openbib}{\@openbibtrue}
\ExecuteOptions{letterpaper,10pt,twoside,onecolumn,leqno,draft,notitlepage}
\ProcessOptions
%
% eliminate siam10.clo altogether:
%%%%%%%%%%%%%%%%%\input{siam1\@ptsize.clo}
\renewcommand{\normalsize}{%
   \@setfontsize\normalsize\@xpt\@xiipt
   \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
   \abovedisplayshortskip \z@ \@plus3\p@ %5\p@ \@plus1\p@ \@minus2.5\p@
   \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@ %5\p@ \@plus1\p@ \@minus2.5\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\normalsize
\newcommand{\small}{%
   \@setfontsize\small\@ixpt{11}%
   \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus2\p@
   \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@ %4\p@ \@plus2\p@ \@minus2\p@
               \parsep \z@ %2\p@ \@plus\p@ \@minus\p@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand{\footnotesize}{%
   \@setfontsize\footnotesize\@viiipt{9.5}%
   \abovedisplayskip 6\p@ \@plus2\p@ \@minus4\p@
   \abovedisplayshortskip \z@ \@plus\p@ %\abovedisplayskip
   \belowdisplayshortskip 3\p@ \@plus\p@ \@minus2\p@ %\belowdisplayskip
   \def\@listi{\leftmargin\leftmargini
               \topsep \z@
               \parsep \z@
               \itemsep \parsep}%
   \belowdisplayskip \abovedisplayskip
}
\newcommand{\scriptsize}{\@setfontsize\scriptsize\@viipt\@viiipt}
\newcommand{\tiny}{\@setfontsize\tiny\@vpt\@vipt}
\newcommand{\large}{\@setfontsize\large\@xiipt{14}}
\newcommand{\Large}{\@setfontsize\Large\@xivpt{18}}
\newcommand{\LARGE}{\@setfontsize\LARGE\@xviipt{22}}
\newcommand{\huge}{\@setfontsize\huge\@xxpt{25}}
\newcommand{\Huge}{\@setfontsize\Huge\@xxvpt{30}}
\if@twocolumn
  \setlength\parindent{1em}
\else
  \setlength\parindent{.25in}
\fi
\setlength\headheight{10\p@}
\setlength\headsep   {.2in}
%\setlength\topskip   {10\p@}
\setlength\footskip{.2in}
\if@compatibility 
 \setlength\maxdepth{4\p@}
\else
 \setlength\maxdepth{.5\topskip} 
\fi
\setlength\@maxdepth\maxdepth
\if@compatibility
  \if@twocolumn
    \setlength\textwidth{410\p@}
  \else
    \setlength\textwidth{5.125in}
  \fi
\else
  \if@twocolumn
    \setlength\textwidth{410\p@}
  \else
    \setlength\textwidth{5.125in}
  \fi
\fi
%\if@compatibility\else
%  \@settopoint\textwidth
%\fi
\if@compatibility
  \setlength\textheight{8.25in}
\else
  \setlength\textheight{8.25in}
\fi
%\addtolength\textheight{\topskip}
\if@compatibility
  \if@twoside
%     \setlength\oddsidemargin   {.5in}
%     \setlength\evensidemargin  {.5in}
     \setlength\marginparwidth {1.25in}
  \else
%     \setlength\oddsidemargin   {.5in}
%     \setlength\evensidemargin  {.5in}
     \setlength\marginparwidth  {1.25in}
  \fi
  \if@twocolumn
     \setlength\oddsidemargin  {30\p@}
     \setlength\evensidemargin {30\p@}
     \setlength\marginparwidth {48\p@}
  \fi
\else
  \if@twoside
%     \setlength\oddsidemargin   {.5in}
%     \setlength\evensidemargin  {.5in}
     \setlength\marginparwidth {1.25in}
  \else
%     \setlength\oddsidemargin   {.5in}
%     \setlength\evensidemargin  {.5in}
     \setlength\marginparwidth {1.25in}
  \fi
  \@settopoint\oddsidemargin
  \@settopoint\marginparwidth
\fi
\if@twocolumn
  \setlength\marginparsep {10\p@}
\else
  \setlength\marginparsep{11\p@}
\fi
\setlength\marginparpush{5\p@}
\if@compatibility
  \setlength\topmargin{\z@}
\else
\setlength\topmargin {\z@}
%  \@settopoint\topmargin
\fi

%% >>tgk>> --- Added Summer 2015 ---
%%
%% Fix to make bookmarks show up when using pdflatex (+hypertex).
\setcounter{tocdepth}{3}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% First step to adding the ntheorem package for theorems, etc. Second
%% step is further down below. Need to split them because this needs
%% to be loaded *before* cleveref and lineno.
\RequirePackage[amsmath,thmmarks,hyperref]{ntheorem}[1.33]
%%
%% <<tgk<<
%%

\setlength\footnotesep{6.65\p@}
\skip\footins 13\p@ \@plus 4\p@ \@minus 2\p@
\setlength\floatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\textfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\intextsep   {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dblfloatsep    {12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength\dbltextfloatsep{20\p@ \@plus 2\p@ \@minus 4\p@}
\setlength\@fptop{0\p@ \@plus 1fil}
\setlength\@fpsep{8\p@ \@plus 2fil}
\setlength\@fpbot{0\p@ \@plus 1fil}
\setlength\@dblfptop{0\p@ \@plus 1fil}
\setlength\@dblfpsep{8\p@ \@plus 2fil}
\setlength\@dblfpbot{0\p@ \@plus 1fil}
\setlength\partopsep{\z@}
\def\@listI{\leftmargin\leftmargini
            \parsep \z@
            \topsep \z@
            \itemsep \parsep}
\let\@listi\@listI
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    \z@
              \parsep    \z@
              \itemsep   \parsep}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    \z@
              \parsep    \z@
              \partopsep \z@
              \itemsep   \topsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}
%
\setlength\lineskip{1\p@}
\setlength\normallineskip{1\p@}
\renewcommand\baselinestretch{}
%%
%% >>tgk>> Modified Summer 2015
%%
\setlength\parskip{0\p@}
%%
%% <<tgk<<
%%
\@lowpenalty   51
\@medpenalty  151
\@highpenalty 301
\setcounter{topnumber}{2}
\renewcommand\topfraction{.9}
\setcounter{bottomnumber}{1}
\renewcommand\bottomfraction{.1}
\setcounter{totalnumber}{3}
\renewcommand\textfraction{.1}
\renewcommand\floatpagefraction{.91}
\setcounter{dbltopnumber}{2}
\renewcommand\dbltopfraction{.7}
\renewcommand\dblfloatpagefraction{.5}

%\renewcommand{\ps@plain}{\let\@mkboth\@gobbletwo%
%  \renewcommand{\@oddhead}{}%
%  \renewcommand{\@evenhead}{}%
%  \renewcommand{\@evenfoot}{\hfil\footnotesize\textrm{\thepage}\hfil}%
%  \renewcommand{\@oddfoot}{\@evenfoot}}
%  
%  \def\copyrightfooter#1{\gdef\@copyrightfooter{#1}}
%  \gdef\@copyrightfooter{}
%  
%%%add copyright footer, per SIAM
%  \renewcommand{\ps@plain}{\let\@mkboth\@gobbletwo%
%  \renewcommand{\@oddhead}{}%
%  \renewcommand{\@evenhead}{}%
%  \renewcommand{\@evenfoot}{\hfil\vtop{\hsize\textwidth\centering\footnotesize\textrm{\thepage}\\[4pt] \@copyrightfooter}\hfil}%
%  \renewcommand{\@oddfoot}{\@evenfoot}}

\newlength{\fromfoliotocopyright}
\setlength{\fromfoliotocopyright}{.75in}

\newcommand{\footercopyright}{}

\newcommand{\f@@terwithc@pyright}[1]{\raisebox{0pt}[\height][0pt]{\vtop{%
  \hbox to \textwidth{\normalfont\footnotesize\hfil\rule{0pt}{14.4pt}#1\hfil}%
  \vskip\fromfoliotocopyright%
  \hbox to \textwidth{\normalfont\normalsize\hfil\footercopyright\hfil}%
  }}%
}

\renewcommand{\ps@plain}{\let\@mkboth\@gobbletwo%
  \renewcommand{\@oddhead}{}%
  \renewcommand{\@evenhead}{}%
  \renewcommand{\@evenfoot}{\f@@terwithc@pyright{\thepage}}%
  \renewcommand{\@oddfoot}{\@evenfoot}}

\def\ps@headings{%
      \renewcommand{\@oddfoot}{\hfil\vtop{\hsize\textwidth\centering\footnotesize\textrm{\strut}\\[4pt] \@copyrightfooter}\hfil}\let\@evenfoot\@oddfoot%
      \def\@evenhead{\rlap{\thepage}\hfil\upshape\footnotesize\leftmark\hfil}%          %!
      \def\@oddhead{\hbox{}\hfil{\upshape\footnotesize\rightmark}\hfil\llap{\thepage}}% %!
      \let\@mkboth\markboth
      \def\sectionmark##1{%
        \markboth {\uppercase{\ifnum \c@secnumdepth >\z@
            \thesection.\hskip 1em\relax\fi
            ##1}}{}}%
      \def\subsectionmark##1{%
        \markright {\ifnum \c@secnumdepth >\@ne
            \thesubsection\hskip 1em\relax \fi
            ##1}}}
            

%\def\ps@myheadings{%
%    \renewcommand{\@oddfoot}{\hfil\vtop{\hsize\textwidth\centering\footnotesize\textrm{\strut}\\[4pt] \@copyrightfooter}\hfil}\let\@evenfoot\@oddfoot%
%    \def\@evenhead{\rlap{\thepage}\hfil\upshape\footnotesize\leftmark\hfil}%          %!
%    \def\@oddhead{\hbox{}\hfil{\upshape\footnotesize\rightmark}\hfil\llap{\thepage}}% %!
%    \let\@mkboth\@gobbletwo
%    \let\sectionmark\@gobble
%    \let\subsectionmark\@gobble
%    }

\def\ps@myheadings{%
    \def\@evenfoot{\f@@terwithc@pyright{}}%
    \let\@oddfoot\@evenfoot
    \def\@evenhead{\rlap{\thepage}\hfil\upshape\footnotesize\leftmark\hfil}%          %!
    \def\@oddhead{\hbox{}\hfil{\upshape\footnotesize\rightmark}\hfil\llap{\thepage}}% %!
    \let\@mkboth\@gobbletwo
    \let\sectionmark\@gobble
    \let\subsectionmark\@gobble
    }


\newcommand\maketitle{\par
  \begingroup\def\@fnsymbol##1{\ensuremath{\ifcase##1\or *\or \dagger\or \ddagger\or
   \mathsection\or \mathparagraph\or \|\or \#\or \dagger\dagger
   \or \ddagger\ddagger\else\@ctrerr\fi}}
    \renewcommand{\thefootnote}{\fnsymbol{footnote}}%
    \def\@makefnmark{\hbox to\z@{$\m@th^{\@thefnmark}$\hss}}%
    \long\def\@makefntext##1{\parindent 1em\noindent
            \hbox to1.8em{\hss$\m@th^{\@thefnmark}$}##1}%
    \if@twocolumn
      \ifnum \col@number=\@ne
        \@maketitle
      \else
        \twocolumn[\@maketitle]%
      \fi
    \else
      \global\@topnum\z@   % Prevents figures from going at top of page.
      \@maketitle
    \fi
    \thispagestyle{plain}\@thanks
  \endgroup
  \setcounter{footnote}{0}%
  \let\maketitle\relax\let\@maketitle\relax
  \gdef\@thanks{}\gdef\@author{}\gdef\@title{}\let\thanks\relax}
%_%_%_%_%
%_%_%_%_% Macros for subtitle (subauthor?), altered slugline/slugger for translated version
%_%_%_%_%
\long\def\subtitle#1{\gdef\@subtitle{\par\vskip8pt\footnotesize#1}}
\def\@subtitle{}
%
\long\def\supertitle#1{\gdef\@supertitle{\par\bfseries#1\vskip17.5pt\par}}
\def\@supertitle{}
%_%_%_%_%
%_%_%_%_%
%_%_%_%_%
%
\def\@translation{}
%

\def\copyrightlineone#1{\gdef\@copyrightlineone{#1}}
\def\copyrightlinetwo#1{\gdef\@copyrightlinetwo{#1}}

\def\@copyrightlineone{Society for Industrial and Applied Mathematics}
\def\@copyrightlinetwo{}


\def\slugger#1#2#3#4#5{\gdef\@slugger{\thispagestyle{plain}%
\vspace*{-36pt}
{\sixptsize\baselineskip10pt
\noindent
\expandafter\csname#1\endcsname.\hspace*{\fill}
{\scriptsize{\copyright}} #2 \@copyrightlineone\vspace*{-1.2mm}\\
Vol.\ #3, No.\ #4, pp.\ #5
\hspace*{\fill} \@translation\@copyrightlinetwo\par}
\normalsize\vskip19.7pt}}
%
\if@translated
\newcommand\tpa{T{\fiveptsize HEORY}~P{\fiveptsize ROBAB.}~A{\fiveptsize PPL}}% added 1/7/04
\def\@translation{Translated from Russian Journal}  
\else%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\tpa{T{\fiveptsize HEORY}~P{\fiveptsize ROBAB.}~A{\fiveptsize PPL}}% added 1/7/04  
\fi
%
\def\@slugger{}
\def\@slugline{}
%_%_%_%_%
%_%_%_%_%
%_%_%_%_%
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for "supplement" class option, to change the title and labels.
\def\siampretitle{}
\def\siamprelabel{}
\if@supplement
\def\siampretitle{Supplementary Materials: }
\def\siamprelabel{SM}
\fi
%%
%% <<tgk<<
%%
\def\@maketitle{%
  \null
\@slugger
  \begin{center}%
\@supertitle%
%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
%% Support for supplementary materials
    {\bfseries\MakeUppercase{\siampretitle}\@ucnothanks{\@title}\par}%
%%
%% <<tgk<< 
%%
    \vskip .075in%
    {\footnotesize
      \spaceskip=1.5\fontdimen2\the\font
      \def\and{\ \scriptsize AND }
      \@tempswafalse\expandafter\@doauth\@author\and\relax}%
\@subtitle%
  \end{center}%
  \par
  \vskip .11in}
\def\@ucnothanks#1{\expandafter\@ucnt#1\thanks\relax}
%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
%% Fixed capitalization to work with macro for title
\def\@ucnt#1\thanks{\uppercase\expandafter{#1}\futurelet\@tempa\@ucnta}
%%
%% <<tgk<< 
%%
\def\@ucnta{\ifx\@tempa\relax\else\@ucntb\fi}
\def\@ucntb#1\thanks\relax{\thanks{#1}}
\def\@doauth#1\and{\let\@nextdoa=\@doauth
 \def\@tempc{\@ucnothanks{#1}}
 \futurelet\@tempa\@doautha}
\def\@doautha{\ifx\@tempa\relax
  \if@tempswa {\and}\fi
  \let\@nextdoa=\relax
 \else
  \if@tempswa \gdef\and{,\ \scriptsize AND }, \fi
 \fi
 \@tempc\unskip\@tempswatrue\@nextdoa}
\let\and=\relax

\newcommand{\sixptsize}{%
   \@setfontsize\sixptsize{6}{8}}

%%create five-point size
\newcommand{\fiveptsize}{%
   \@setfontsize\fiveptsize{5}{7}}


\newcommand\simac{SIAM J{\fiveptsize OURNAL} M{\fiveptsize ACRO}}
\newcommand\siap{SIAM J.\ A{\fiveptsize PPL}.\ M{\fiveptsize ATH}}
\newcommand\sicomp{SIAM J.\ C{\fiveptsize OMPUT}}
\newcommand\sicon{SIAM J.\ C{\fiveptsize ONTROL}  O{\fiveptsize PTIM}}
\newcommand\sidma{SIAM J.\ D{\fiveptsize ISCRETE} M{\fiveptsize ATH}}
\newcommand\sima{SIAM J.\ M{\fiveptsize ATH}.\ A{\fiveptsize NAL}}
\newcommand\simax{SIAM J.\ M{\fiveptsize ATRIX} A{\fiveptsize NAL}.\ A{\fiveptsize PPL}}
\newcommand\sinum{SIAM J.\ N{\fiveptsize UMER}.\ A{\fiveptsize NAL}}
\newcommand\siopt{SIAM J.\ O{\fiveptsize PTIM}}
\newcommand\sisc{SIAM J.\ S{\fiveptsize CI}.\ C{\fiveptsize OMPUT}}
\newcommand\sirev{SIAM R{\fiveptsize EV}}
\newcommand\mms{M{\fiveptsize ULTISCALE}~M{\fiveptsize ODEL}.~S{\fiveptsize IMUL}} % Added 9/17/02  
   
        
\setcounter{secnumdepth}{3}
\newcounter {section}
\newcounter {subsection}[section]
\newcounter {subsubsection}[subsection]
\newcounter {paragraph}[subsubsection]
\newcounter {subparagraph}[paragraph]
%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
%% Adding supplement support.
\renewcommand\thesection       {\siamprelabel\arabic{section}}
%%
%% <<tgk<<
%%
\renewcommand\thesubsection    {\thesection.\arabic{subsection}}
\renewcommand\thesubsubsection {\thesubsection.\arabic{subsubsection}}
\renewcommand\theparagraph     {\thesubsubsection.\arabic{paragraph}}
\renewcommand\thesubparagraph  {\theparagraph.\arabic{subparagraph}}




\def\nopunct{\def\@mypunct{}}
\gdef\@mypunct{.}
\def\punct{\gdef\@mypunct{.}}


\def\@sect#1#2#3#4#5#6[#7]#8{\ifnum #2>\c@secnumdepth
     \def\@svsec{}\else 
     \refstepcounter{#1}\edef\@svsec{\csname the#1\endcsname.\hskip .5em }\fi
     \@tempskipa #5\relax
      \ifdim \@tempskipa>\z@ 
        \begingroup #6\relax
          \@hangfrom{\hskip #3\relax\@svsec}{\interlinepenalty \@M #8\par}
        \endgroup
       \csname #1mark\endcsname{#7}\addcontentsline
         {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                      \protect\numberline{\csname the#1\endcsname}\fi
                    #7}\else
        \def\@svsechd{#6\hskip #3\@svsec #8\@mypunct\csname #1mark\endcsname
                      {#7}\addcontentsline
                           {toc}{#1}{\ifnum #2>\c@secnumdepth \else
                             \protect\numberline{\csname the#1\endcsname}\fi
                       #7}}\fi
     \@xsect{#5}}
\def\@ssect#1#2#3#4#5{\@tempskipa #3\relax
   \ifdim \@tempskipa>\z@
     \begingroup #4\@hangfrom{\hskip #1}{\interlinepenalty \@M
#5\@mypunct\par}\endgroup
   \else \def\@svsechd{#4\hskip #1\relax #5\@mypunct}\fi
    \@xsect{#3}}

              
\newcommand\section{\@startsection{section}{1}{.25in}%
                                   {1.3ex \@plus .5ex \@minus .2ex}%
                                   {-.5em \@plus -.1em}%
                                   {\reset@font\normalsize\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{.25in}%
                                     {1.3ex\@plus .5ex \@minus .2ex}%
                                     {-.5em \@plus -.1em}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\subsubsection{\@startsection{subsubsection}{3}{.25in}%
                                     {1.3ex\@plus .5ex \@minus .2ex}%
                                     {-.5em \@plus -.1em}%
                                     {\reset@font\normalsize\bfseries}}
\newcommand\paragraph{\@startsection{paragraph}{4}{.25in}%
                                    {\parskip}%
                                    {-.5em plus -.1em}%
                                    {\reset@font\normalsize\itshape}}
\newcommand\subparagraph{\@startsection{subparagraph}{5}{\parindent}%
                                       {\parskip}%
                                       {-.5em plus -.1em}%
                                      {\reset@font\normalsize\itshape}}
\if@twocolumn
  \setlength\leftmargini  {2em}
\else
  \setlength\leftmargini  {0.5in}
\fi
\setlength\leftmarginii  {22pt}
\setlength\leftmarginiii {18.7pt}
\setlength\leftmarginiv  {17pt}
\if@twocolumn
  \setlength\leftmarginv  {.5em}
  \setlength\leftmarginvi {.5em}
\else
  \setlength\leftmarginv  {10pt}
  \setlength\leftmarginvi {10pt}
\fi
\setlength  \leftmargin{\leftmargini}
\setlength  \labelsep  {.5em}
\setlength  \labelwidth{\leftmargini}
\addtolength\labelwidth{-\labelsep}
\@beginparpenalty -\@lowpenalty
\@endparpenalty   -\@lowpenalty
\@itempenalty     -\@lowpenalty
\renewcommand\theenumi{\arabic{enumi}}
\renewcommand\theenumii{\alph{enumii}}
\renewcommand\theenumiii{\roman{enumiii}}
\renewcommand\theenumiv{\Alph{enumiv}}
\newcommand\labelenumi{\textup{\theenumi.}}
\newcommand\labelenumii{\textup{(\theenumii)}}
\newcommand\labelenumiii{\textup{\theenumiii.}}
\newcommand\labelenumiv{\textup{\theenumiv.}}
\renewcommand\p@enumii{\theenumi}
\renewcommand\p@enumiii{\theenumi\theenumii}
\renewcommand\p@enumiv{\p@enumiii\theenumiii}
\newcommand\labelitemi{$\m@th\bullet$}
\newcommand\labelitemii{\normalfont\bfseries --}
\newcommand\labelitemiii{$\m@th\ast$}
\newcommand\labelitemiv{$\m@th\cdot$}
\newenvironment{description}
               {\list{}{\labelwidth\z@ \itemindent-\leftmargin
                        \let\makelabel\descriptionlabel}}
               {\endlist}
\newcommand\descriptionlabel[1]{\hspace\labelsep
                                \normalfont\bfseries #1}
\newcounter{rmnum}
\newenvironment{romannum}
               {\begin{list}{{\upshape (\roman{rmnum})}}{\usecounter{rmnum}
                \setlength{\leftmargin}{0pt}
                \setlength{\itemindent}{42pt}}}{\end{list}}
\newcounter{muni}
\newenvironment{remunerate}
               {\begin{list}{{\upshape \arabic{muni}.}}{\usecounter{muni}
                \setlength{\leftmargin}{0pt}
                \setlength{\itemindent}{38pt}}}{\end{list}}
                                
\newenvironment{@abssec}[1]{%
     \if@twocolumn
       \section*{#1}%
     \else
       \vspace{.05in}\footnotesize
       \parindent .2in
         {\upshape\bfseries #1. }\ignorespaces 
     \fi}
     {\if@twocolumn\else\par\vspace{.1in}\fi}

\newenvironment{@doisec}[1]{%
     \if@twocolumn
       \section*{#1}%
     \else
       \vspace{.05in}\footnotesize
       \parindent .2in
         {\upshape\bfseries #1. }\ignorespaces\ignorespaces
     \fi}
     {\if@twocolumn\else\par\vspace{.1in}\fi}

\newenvironment{abstract}{\begin{@abssec}{\abstractname}}{\end{@abssec}}
\newenvironment{keywords}{\begin{@abssec}{\keywordsname}}{\end{@abssec}}
\newenvironment{keyword}{\begin{@abssec}{\keywordname}}{\end{@abssec}}
\newenvironment{AMS}{\begin{@abssec}{\AMSname}}{\end{@abssec}}
\newenvironment{AM}{\begin{@abssec}{\AMname}}{\end{@abssec}}
%\newenvironment{PII}{\begin{@abssec}{\PIIname}}{\end{@abssec}}
\newenvironment{DOI}{\begin{@doisec}{\DOIname}}{\end{@doisec}}


\newenvironment{verse}
               {\let\\=\@centercr
                \list{}{\itemsep      \z@
                        \itemindent   -1.5em%
                        \listparindent\itemindent
                        \rightmargin  \leftmargin
                        \advance\leftmargin 1.5em}%
                \item[]}
               {\endlist}
\newenvironment{quotation}
               {\list{}{\listparindent 1.5em%
                        \itemindent    \listparindent
                        \rightmargin   \leftmargin
                        \parsep        \z@ \@plus\p@}%
                \item[]}
               {\endlist}
\newenvironment{quote}
               {\list{}{\rightmargin\leftmargin}%
                \item[]}
               {\endlist}
               
%\def\@begintheorem#1#2{\vspace{\abovedisplayskip}\par\bgroup{\scshape #1\ #2. }\it\ignorespaces}
%\def\@opargbegintheorem#1#2#3{\par\bgroup%
%   {\scshape #1\ #2\ ({\upshape #3}). }\it\ignorespaces}
%\def\@endtheorem{\egroup\vspace{\belowdisplayskip}}
%\def\proof{\par{\it Proof}. \ignorespaces}
%
%\def\endproof{\vbox{\hrule height0.6pt\hbox{%
%   \vrule height1.3ex width0.6pt\hskip0.8ex
%   \vrule width0.6pt}\hrule height0.6pt
%  }}

\newlength{\@sectionspace}
\setlength{\@sectionspace}{1.3ex \@plus .5ex \@minus .2ex} %the space added before a new section
\newlength{\@negsectionspace}
\setlength{\@negsectionspace}{-1.3ex \@plus -.5ex \@minus -.2ex} %its negation


%%
%% >>tgk>> --- Removed Summer 2015 ---
%% 
%\newcommand{\insertsectionspace}{\addvspace{\@sectionspace}}
%\newcommand{\removesectionspace}{\vspace{\@negsectionspace}} %I didn't end up needing these, but they might be needed somewhere
%
% \def\@begintheorem#1#2{\par\addvspace{\@sectionspace}{\scshape #1\ #2. }\itshape\ignorespaces}
%
% \def\@opargbegintheorem#1#2#3{\par\addvspace{\@sectionspace}{\scshape #1\ #2\ ({\upshape #3}). }\itshape\ignorespaces}
%
% \def\@endtheorem{\par\addvspace{\@sectionspace}}
%
% \def\proof{\par\addvspace{\@sectionspace}\textit{Proof}. \ignorespaces}
%
% \newcommand{\@proofbox}{\vbox{\hrule height0.6pt\hbox{\vrule height1.3ex width0.6pt\hskip0.8ex\vrule width0.6pt}\hrule height0.6pt}}
%
% \def\endproof{\ifmmode\@proofbox\else\@proofbox\par\addvspace{\@sectionspace}\fi}
%
% \if@onethmnum
%   \newtheorem{theorem}{Theorem}
%   \newtheorem{lemma}[theorem]{Lemma}
%   \newtheorem{corollary}[theorem]{Corollary}
%   \newtheorem{proposition}[theorem]{Proposition}
%   \newtheorem{definition}[theorem]{Definition}
% \else
%   \newtheorem{theorem}{Theorem}[section]
%   \newtheorem{lemma}[theorem]{Lemma}
%   \newtheorem{corollary}[theorem]{Corollary}
%   \newtheorem{proposition}[theorem]{Proposition}
%   \newtheorem{definition}[theorem]{Definition}
% \fi
%%
%% <<tgk<<
%%

% FROM FIXUP.STY
% We now redefine the eqnarray environment to correct the space around
% the operator.   Any changes to the definition in LaTeX itself
% will cause the `Warning: unable...'
% message to appear.  If this happens it will be necessary to update the
% definition of  \@tempb below and incorperate the changes into
% the new definitions of \eqnarray.
 
 
% This is the current definition of \eqnarray for the fleqn document style
% latex.ltx
 
\def\@tempb{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne\hskip \tw@\arraycolsep \hfil${##}$\hfil
      &\global\@eqcnt\tw@ \hskip \tw@\arraycolsep
         $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}
\ifx\eqnarray\@tempb    % Try the default eqnarray environment
  \def\eqnarray{%
   \stepcounter{equation}%
   \def\@currentlabel{\p@equation\theequation}%
   \global\@eqnswtrue
   \m@th
   \global\@eqcnt\z@
   \tabskip\@centering
   \let\\\@eqncr
   $$\everycr{}\halign to\displaywidth\bgroup
       \hskip\@centering$\displaystyle\tabskip\z@skip{##}$\@eqnsel
      &\global\@eqcnt\@ne \hfil$\displaystyle{{}##{}}$\hfil
      &\global\@eqcnt\tw@ $\displaystyle{##}$\hfil\tabskip\@centering
      &\global\@eqcnt\thr@@ \hb@xt@\z@\bgroup\hss##\egroup
         \tabskip\z@skip
      \cr
}
\else    \typeout{Warning: Unable to fix unknown version of \string\eqnarray.}
\fi
 
\def\@tempb{}

%%
%% >>tgk>> --- Removed Summer 2015 ---
%%
%% New Mathops.

% \newcommand\const{\mathop{\operator@font const}\nolimits}
% \newcommand\diag{\mathop{\operator@font diag}\nolimits}
% \newcommand\grad{\mathop{\operator@font grad}\nolimits}
% \newcommand\Range{\mathop{\operator@font Range}\nolimits}
% \newcommand\rank{\mathop{\operator@font rank}\nolimits}
% \newcommand\supp{\mathop{\operator@font supp}\nolimits}
%%
%% <<tgk<<
%%

%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
%% The original changes to introduce the appendix didn't work
%% correctly. In particular, calling \section*{Acknowledgments} after
%% declaring \appendix produced an appendix with a letter (i.e.,
%% Appendix B) but no title --- exactly the reverse of what we would
%% expect. Now, using \section* produces what you would expect, i.e.,
%% just the title "Acknowledgments". The SIAM style guide also allows
%% a numbered but untitled section, so the command \appendixnotitle is
%% defined to facilitate that. Not sure it should be explicitly
%% documented??
%%

\newcommand\gobblepars{%
    \@ifnextchar\par%
        {\expandafter\gobblepars\@gobble}%
        {}}

\newcommand\appendix{%
  \setcounter{section}{0}
  \setcounter{subsection}{0}
  \renewcommand\thesection{\Alph{section}}
  \renewcommand{\section}{\secdef\append\sappend}
  \newcommand{\appendixnotitle}{%
    \refstepcounter{section}%
    {\par\addvspace{\@sectionspace} 
      \reset@font\normalsize\bfseries\appendixname\ \thesection. \gobblepars}%
    \addcontentsline{toc}{section}{\appendixname~\thesection}%
    }
}

\newcommand\append[2][?]{%
  \refstepcounter{section}%
  {\par\addvspace{\@sectionspace} 
    \reset@font\normalsize\bfseries\appendixname\ \thesection. #2\@mypunct{} }%
  \addcontentsline{toc}{section}{\appendixname~\thesection. #2}%
  \gobblepars
}

\newcommand\sappend[1]{%
  {\par\addvspace{\@sectionspace} 
    \reset@font\normalsize\bfseries#1\@mypunct{} }%
  \addcontentsline{toc}{section}{#1}%
  \gobblepars
}
%% 
%% <<tgk<<
%%

\setlength\arraycolsep{5\p@}
\setlength\tabcolsep{6\p@}
\setlength\arrayrulewidth{.4\p@}
\setlength\doublerulesep{2\p@}
\setlength\tabbingsep{\labelsep}
\skip\@mpfootins = \skip\footins
\setlength\fboxsep{3\p@}
\setlength\fboxrule{.4\p@}


\newcounter{figure}
%%
%% >>tgk>> --- Modified Summer 2015 ---
%%
%% Added \siamprelabel for supplement.
\renewcommand\thefigure{\siamprelabel\@arabic\c@figure}
%%
%% <<tgk<<
%%
\def\fps@figure{tp}
\def\ftype@figure{1}
\def\ext@figure{lof}
\def\fnum@figure{\figurename~\thefigure}
\newenvironment{figure}
               {\@float{figure}}
               {\end@float}
\newenvironment{figure*}
               {\@dblfloat{figure}}
               {\end@dblfloat}
\newcounter{table}
%%
%% >>tgk>>  Modified Summer 2015
%%
%% Adding support for supplement
\renewcommand{\thetable}{\siamprelabel\@arabic\c@table}
%%
%% <<tgk<<
%%
\def\fps@table{tp}
\def\ftype@table{2}
\def\ext@table{lot}
\def\fnum@table{\tablename~\thetable}
\newenvironment{table}
               {\@float{table}}
               {\end@float}
\newenvironment{table*}
               {\@dblfloat{table}}
               {\end@dblfloat}
\newlength\abovecaptionskip
\newlength\belowcaptionskip
\setlength\abovecaptionskip{10\p@}
\setlength\belowcaptionskip{10\p@}
\def\@figtxt{figure}
\long\def\@makecaption#1#2{%
    \footnotesize
    \setlength{\parindent}{1.5pc}
  \ifx\@captype\@figtxt
    \vskip\abovecaptionskip
    \setbox\@tempboxa\hbox{{\normalfont\scshape #1}. {\normalfont\itshape #2}}%
    \ifdim \wd\@tempboxa >\hsize
      {\normalfont\scshape #1}. {\normalfont\itshape #2}\par
    \else
      \global\@minipagefalse
      \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
  \else
    \hbox to\hsize{\hfil{\normalfont\scshape #1}\hfil}%
    \setbox\@tempboxa\hbox{{\normalfont\itshape #2}}%
    \ifdim \wd\@tempboxa >\hsize
      {\normalfont\itshape #2}\par
    \else
     \global\@minipagefalse
      \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
    \fi
    \vskip\belowcaptionskip
  \fi}
\DeclareOldFontCommand{\rm}{\normalfont\rmfamily}{\mathrm}
\DeclareOldFontCommand{\sf}{\normalfont\sffamily}{\mathsf}
\DeclareOldFontCommand{\tt}{\normalfont\ttfamily}{\mathtt}
\DeclareOldFontCommand{\bf}{\normalfont\bfseries}{\mathbf}
\DeclareOldFontCommand{\it}{\normalfont\itshape}{\mathit}
\DeclareOldFontCommand{\sl}{\normalfont\slshape}{\@nomath\sl}
\DeclareOldFontCommand{\sc}{\normalfont\scshape}{\@nomath\sc}
\DeclareRobustCommand*\cal{\@fontswitch{\relax}{\mathcal}}
\DeclareRobustCommand*\mit{\@fontswitch{\relax}{\mathnormal}}
\newcommand\@pnumwidth{1.55em}
\newcommand\@tocrmarg {2.55em}
\newcommand\@dotsep{4.5}

\newdimen\bibindent
\bibindent=16pt
\newenvironment{thebibliography}[1]
     {\par\addvspace{.25in}
     \begin{center}
     \footnotesize\uppercase\expandafter{\refname}%
     \addcontentsline{toc}{section}{References}
     \end{center}
     \@mkboth{\uppercase\expandafter{\refname}}{\uppercase\expandafter{\refname}}
     \addvspace{.15in}\nopagebreak%
%%
%% >>tgk>> --- Modified Summer 2015
%%
%% Adding supplement support by inserting \siamprelabel
      \list{\@biblabel{\siamprelabel\arabic{enumi}}}%
%%
%% <<tgk<<
%%
           {\settowidth\labelwidth{\@biblabel{#1}}%
            \leftmargin\labelwidth
            \advance\leftmargin\labelsep
%            \if@openbib
              \advance\leftmargin\bibindent
              \itemindent -\bibindent
              \listparindent \itemindent
              \parsep \z@
%            \fi
            \usecounter{enumi}%
            \let\p@enumi\@empty
            \renewcommand\theenumi{\arabic{enumi}}}%
%      \if@openbib
%        \renewcommand\newblock{\par}
%      \else
        \renewcommand\newblock{\hskip .11em \@plus.33em \@minus.07em}%
%      \fi
      \sloppy\clubpenalty4000\widowpenalty4000%
      \sfcode`\.=\@m\relax\footnotesize}
     {\def\@noitemerr
       {\@latex@warning{Empty `thebibliography' environment}}%
      \endlist}
\newcommand\newblock{}
\newenvironment{theindex}
               {\if@twocolumn
                  \@restonecolfalse
                \else
                  \@restonecoltrue
                \fi
                \columnseprule \z@
                \columnsep 35\p@
                \twocolumn[\section*{\indexname}]%
                \@mkboth{\uppercase{\indexname}}%
                        {\uppercase{\indexname}}%
                \thispagestyle{plain}\parindent\z@
                \parskip\z@ \@plus .3\p@\relax
                \let\item\@idxitem}
               {\if@restonecol\onecolumn\else\clearpage\fi}
\newcommand\@idxitem  {\par\hangindent 40\p@}
\newcommand\subitem   {\par\hangindent 40\p@ \hspace*{20\p@}}
\newcommand\subsubitem{\par\hangindent 40\p@ \hspace*{30\p@}}
\newcommand\indexspace{\par \vskip 10\p@ \@plus5\p@ \@minus3\p@\relax}
\renewcommand\footnoterule{%
  \kern-3\p@
  \hrule width .5in
  \kern 2.6\p@}
\long\def\@makefntext#1{%
    \parindent .25in%
    \noindent
    \hbox to .25in{\hss\@makefnmark}#1}
\newcommand\contentsname{Contents}
\newcommand\listfigurename{List of Figures}
\newcommand\listtablename{List of Tables}
\newcommand\refname{References}
\newcommand\indexname{Index}
\newcommand\figurename{Fig.}
\newcommand\tablename{Table}
\newcommand\partname{Part}
\newcommand\appendixname{Appendix}
\newcommand\abstractname{Abstract}
\newcommand\keywordsname{Key words}
\newcommand\keywordname{Key word}
\newcommand\AMSname{AMS subject classifications}
\newcommand\AMname{AMS subject classification}
%\newcommand\PIIname{PII}
\newcommand\DOIname{DOI\@}
%\newcommand\URL{\protect\\ \hspace*{15.37pt}http://www.siam.org/journals/}
\newcommand\URL[1]{\protect\\ \hspace*{15.37pt}\protect\href{http://www.siam.org/journals/#1}{http://www.siam.org/journals/#1}}
\newcommand\today{\ifcase\month\or
  January\or February\or March\or April\or May\or June\or
  July\or August\or September\or October\or November\or December\fi
  \space\number\day, \number\year}
\newcommand\sameauthor{\leavevmode\vrule height 2pt depth -1.6pt width 23pt}
\setlength\columnsep{10\p@}
\setlength\columnseprule{0\p@}
\pagestyle{plain}
\pagenumbering{arabic}      % Arabic page numbers

%%
%% >>tgk>> --- Removed Summer 2015 ---
%%
% \if@compatibility%
% \else
%   \if@oneeqnum
%   \else
%      \@addtoreset{equation}{section}   %  \section resets 'equation' counter
%      \renewcommand{\theequation}{\thesection.\arabic{equation}}  
%   \fi
%
%   \if@onefignum
%   \else
%     \@addtoreset{figure}{section}
%     \renewcommand{\thefigure}{\thesection.\@arabic\c@figure}
%   \fi
%
%   \if@onetabnum
%   \else
%     \@addtoreset{table}{section}
%     \renewcommand{\thetable}{\thesection.\@arabic\c@table}
%   \fi
%
%   \if@onethmnum
%   \else
%     \@addtoreset{theorem}{section}
%     \renewcommand{\thetheorem}{\thesection.\arabic{theorem}}
%   \fi
% \fi
%%
%% <<tgk<<
%%

\onecolumn

\gdef\@siamlabel@error#1#2{%
   \GenericError{%
      \space\space\space\@spaces\@spaces\@spaces
   }{%
      SIAM Label Error: #1%
   }{%
      Correct multiply-defined labels.%
   }{#2}%
}

%%% NEW -- causes multiply defined labels to generate errors
\def\@newl@bel#1#2#3{%
  \@ifundefined{#1@#2}%
    \relax
    {\gdef \@multiplelabels {%
      \@latex@warning@no@line{Label `#2' multiply defined}}%
      \@siamlabel@error{There were multiply-defined labels}{}}%
  \global\@namedef{#1@#2}{#3}}
\def\newlabel{\@newl@bel r}
\@onlypreamble\@newl@bel
\let \@multiplelabels \relax
\def\label#1{\@bsphack
  \protected@write\@auxout{}%
         {\string\newlabel{#1}{{\@currentlabel}{\thepage}}}%
  \@esphack}
\def\refstepcounter#1{\stepcounter{#1}%
    \protected@edef\@currentlabel
       {\csname p@#1\endcsname\csname the#1\endcsname}%
}
%%%



% \def\newarticle{\input{newart.tex}}

% \RequirePackage[dvips]{color}
%%
%% >>tgk>> --- Removed Summer 2015 ---
%%

% %\definecolor{header1}{cmyk}{.9,.5,0,.35}
% %\definecolor{blue1}{cmyk}{.9,.7,0,0}
% %\definecolor{blue2}{cmyk}{.93,.95,.2,.07}
% %\definecolor{maroon}{cmyk}{.4,1,.3,.2}
% %\definecolor{gold1}{cmyk}{.2,.2,1,.1}
% %\definecolor{gray}{cmyk}{0,0,0,.5}
% %\definecolor{green1}{cmyk}{1,0,1,0}
% %\definecolor{proofcolor}{cmyk}{1,0,1,0}
% %\definecolor{red1}{cmyk}{0,1,.8,0}
% %\definecolor{orange1}{cmyk}{0,.55,1,0}
% %\definecolor{strip}{cmyk}{.6,.1,.1,.1}

% \definecolor{header1}{cmyk}{0,0,0,1}
% \definecolor{blue1}{cmyk}{0,0,0,1}
% \definecolor{blue2}{cmyk}{0,0,0,1}
% \definecolor{maroon}{cmyk}{0,0,0,1}
% \definecolor{gold1}{cmyk}{0,0,0,1}
% \definecolor{gray}{cmyk}{0,0,0,1}
% \definecolor{green1}{cmyk}{0,0,0,1}
% \definecolor{proofcolor}{cmyk}{0,0,0,1}
% \definecolor{red1}{cmyk}{0,0,0,1}
% \definecolor{orange1}{cmyk}{0,0,0,1}
% \definecolor{strip}{cmyk}{0,0,0,1}


% \RequirePackage[]{graphics,graphicx}
% \RequirePackage[colorlinks,naturalnames=false,hypertexnames=false,breaklinks]{hyperref}%new
% \urlstyle{same}
% \usepackage{breakurl}%new
% \def\wwwbrowser{C:\string\Program\space
% Files\string\Plus!\string\Microsoft\space
% Internet\string\iexplore.exe}
% %\definecolor{extlink}{cmyk}{.05,1,1,.45}
% %\definecolor{intlink}{cmyk}{1,0,1,.5}
% %\definecolor{softpage}{cmyk}{0,0.01,.05,0}
% \definecolor{extlink}{cmyk}{0,0,0,0.7}
% \definecolor{intlink}{cmyk}{0,0,0,0.7}
% \definecolor{softpage}{cmyk}{0,0,0,0.7}

% \def\@linkcolor{intlink}
% \def\@anchorcolor{black}
% \def\@citecolor{intlink}
% \def\@filecolor{cyan}
% \def\@urlcolor{extlink}
% \def\@menucolor{red}
%%
%% <<tgk<<
%%
%%%\def\@pagecolor{softpage}

%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for cross-reference (xr-hyper).
\RequirePackage{xr-hyper}[6.00]
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
\RequirePackage{ifpdf}[2.3]
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for cross-reference hyperlinks
%% (hyperref). Made it so that it works for both dvi/ps and pdf
%% (ifpdf, breakurl).
%%
\if@bakoma
\RequirePackage[dvips]{hyperref}[6.83]
\else
\RequirePackage{hyperref}[6.83]
\fi
\hypersetup{
  colorlinks=false,
  frenchlinks=false,
  pdfborder={0 0 0},
  naturalnames=false,
  hypertexnames=false,
  breaklinks
}
\urlstyle{same}
\ifpdf
\usepackage{graphics,graphicx}
\usepackage{epstopdf}
\else
\usepackage{graphics,graphicx}
   \RequirePackage{breakurl}[1.40]
   \if@nohypdvips
   \else
   \usepackage{hypdvips}
   \fi
\fi
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%% 
\RequirePackage{xcolor}[2.11]
\colorlet{siaminlinkcolor}{green!50!black}
\colorlet{siamexlinkcolor}{red!50!black}
\colorlet{siamreviewcolor}{black!50}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%% 
%% Add support for color in order to color the hyperlinks.
%% 
\if@hidelinks
\hypersetup{ hidelinks = true }
\else
\hypersetup{
  colorlinks = true,
  allcolors = siaminlinkcolor,
  urlcolor = siamexlinkcolor,
}
\fi
%%
%% <<tgk<<
%%
\newcommand{\email}[1]{\protect\href{mailto:#1}{#1}}
%%
%% >>tgk>> --- Modified Summer 2015 ---
%% 
\newcommand{\mref}[1]{\burlalt{mailto:#1}{#1}}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Removed Summer 2015 ---
%\newcommand{\web}[1]{\href{#1}{#1}}
%%
%% <<tgk<< 
%%

%%%\pagecolor{softpage}


%%%%to fix link jump to "bottom" of float
\RequirePackage[all]{hypcap} [1.11]

\setlength{\parskip}{1\parskip}

%%
%% >>tgk>> --- Added Summer 2015 ---
%%
% This needs to be loaded *before* cleveref
\RequirePackage{algorithm}[0.1]
\renewcommand{\ALG@name}{Algorithm}
\renewcommand\thealgorithm{\siamprelabel\@arabic\c@algorithm}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Adding cleveref package for smart citations, with customizations to
%% make it act like SIAM expects.
\RequirePackage[capitalize,nameinlink]{cleveref}[0.19]

% Per SIAM Style Manual, "section" should be lowercase
\crefname{section}{section}{sections}
\crefname{subsection}{subsection}{subsections}

% Per SIAM Style Manual, "Figure" should be spelled out in references
\Crefname{figure}{Figure}{Figures}

% Per SIAM Style Manual, don't say equation in front on an equation.
\crefformat{equation}{\textup{#2(#1)#3}}
\crefrangeformat{equation}{\textup{#3(#1)#4--#5(#2)#6}}
\crefmultiformat{equation}{\textup{#2(#1)#3}}{ and \textup{#2(#1)#3}}
{, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
\crefrangemultiformat{equation}{\textup{#3(#1)#4--#5(#2)#6}}%
{ and \textup{#3(#1)#4--#5(#2)#6}}{, \textup{#3(#1)#4--#5(#2)#6}}{, and \textup{#3(#1)#4--#5(#2)#6}}

% But spell it out at the beginning of a sentence.
\Crefformat{equation}{#2Equation~\textup{(#1)}#3}
\Crefrangeformat{equation}{Equations~\textup{#3(#1)#4--#5(#2)#6}}
\Crefmultiformat{equation}{Equations~\textup{#2(#1)#3}}{ and \textup{#2(#1)#3}}
{, \textup{#2(#1)#3}}{, and \textup{#2(#1)#3}}
\Crefrangemultiformat{equation}{Equations~\textup{#3(#1)#4--#5(#2)#6}}%
{ and \textup{#3(#1)#4--#5(#2)#6}}{, \textup{#3(#1)#4--#5(#2)#6}}{, and \textup{#3(#1)#4--#5(#2)#6}}

% Make number non-italic in any environment.
\crefdefaultlabelformat{#2\textup{#1}#3}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Setting up theorems using ntheorem package, customizing to do the
%% indentations and other features that SIAM likes. Also, adding
%% macros that can be use to declare additional theorem-like
%% environments. The \newtheorem calls have to happen /after/ loading
%% cleveref when using ntheorem and sharing the same numbering.

% We fix the default style to have the indents that SIAM wants before
% theorem and proof definitions.
\renewtheoremstyle{plain}% Allow loooong optional labels for theorems???? JR
 {\item[\hskip\labelsep\hskip\parindent \theorem@headerfont ##1\ \textup{##2\theorem@separator}]}%
 {\item[\hskip\labelsep\hskip\parindent \theorem@headerfont ##1\ \textup{##2}]\textup{(##3)\theorem@separator}\ }


\renewtheoremstyle{nonumberplain}%
 {\item[\theorem@headerfont\hskip\labelsep\hskip\parindent ##1\theorem@separator]}%
{\item[\theorem@headerfont\hskip\labelsep\hskip\parindent ##3\theorem@separator]}


% Retained from old style file
\newcommand{\proofbox}{\vbox{\hrule height0.6pt\hbox{\vrule height1.3ex width0.6pt\hskip0.8ex\vrule width0.6pt}\hrule height0.6pt}}

% Extra space around theorem-like environments
\theorempreskip{1ex plus .25ex minus .1ex}
\theorempostskip{1ex plus .25ex minus .1ex}
%\theorempreskip{10\p@ \@plus2\p@ \@minus5\p@}
%\theorempostskip{10\p@ \@plus2\p@ \@minus5\p@}



% Proof environment: No number, italic header, normal body, ends with proofbox.
\theoremstyle{nonumberplain}
\theoremheaderfont{\normalfont\itshape}
\theorembodyfont{\normalfont}
\theoremseparator{.}
\theoremsymbol{\proofbox}
\newtheorem{proof}{Proof}

% Theorem environment: Small-caps header, italize body.
\theoremstyle{plain}
\theoremheaderfont{\normalfont\sc}
\theorembodyfont{\normalfont\itshape}
\theoremseparator{.}
\theoremsymbol{}
\newtheorem{theorem}{Theorem}

% Command to create other theorem-like environments, to be numbered
% along with the theorems.
\newcommand{\newsiamthm}[2]{
  \theoremstyle{plain}
  \theoremheaderfont{\normalfont\sc}
  \theorembodyfont{\normalfont\itshape}
  \theoremseparator{.}
  \theoremsymbol{}
  \newtheorem{#1}[theorem]{#2}
}

% Other predefined theorem-like environments
\newsiamthm{lemma}{Lemma}
\newsiamthm{corollary}{Corollary}
\newsiamthm{proposition}{Proposition}
\newsiamthm{definition}{Definition}

% Command to create remark-like environments, to be numbered
% along with the theorems.
\newcommand{\newsiamremark}[2]{
  \theoremstyle{plain}
  \theoremheaderfont{\normalfont\itshape}
  \theorembodyfont{\normalfont}
  \theoremseparator{.}
  \theoremsymbol{}
  \newtheorem{#1}[theorem]{#2}
}
%%
%% <<tgk<<
%%

%new: make new head for assumptions, remarks, etc. Numbered? Unnumbered?

%%
%% >>tgk>> --- Removed Summer 2015 ---
%%
% %%% create theorems, etc. with upright font, no italic
% \def\newheading#1{%
%   \@ifnextchar[{\@othmup{#1}}{\@nthmup{#1}}}
% \def\@nthmup#1#2{%
%   \@ifnextchar[{\@xnthmup{#1}{#2}}{\@ynthmup{#1}{#2}}}
% \def\@xnthmup#1#2[#3]{%
%   \expandafter\@ifdefinable\csname #1\endcsname
%     {\@definecounter{#1}\@newctr{#1}[#3]%
%      \expandafter\xdef\csname the#1\endcsname{%
%        \expandafter\noexpand\csname the#3\endcsname \@thmcountersep
%           \@thmcounterup{#1}}%
%      \global\@namedef{#1}{\@thmup{#1}{#2}}%
%      \global\@namedef{end#1}{\@endtheoremup}}}
% \def\@ynthmup#1#2{%
%   \expandafter\@ifdefinable\csname #1\endcsname
%     {\@definecounter{#1}%
%      \expandafter\xdef\csname the#1\endcsname{\@thmcounterup{#1}}%
%      \global\@namedef{#1}{\@thmup{#1}{#2}}%
%      \global\@namedef{end#1}{\@endtheoremup}}}
% \def\@othmup#1[#2]#3{%
%   \@ifundefined{c@#2}{\@nocounterr{#2}}%
%     {\expandafter\@ifdefinable\csname #1\endcsname
%     {\global\@namedef{the#1}{\@nameuse{the#2}}%
%   \global\@namedef{#1}{\@thmup{#2}{#3}}%
%   \global\@namedef{end#1}{\@endtheoremup}}}}
% \def\@thmup#1#2{%
%   \refstepcounter{#1}%
%   \@ifnextchar[{\@ythmup{#1}{#2}}{\@xthmup{#1}{#2}}}
% \def\@xthmup#1#2{%
%   \@begintheoremup{#2}{\csname the#1\endcsname}\ignorespaces}
% \def\@ythmup#1#2[#3]{%
%   \@opargbegintheoremup{#2}{\csname the#1\endcsname}{#3}\ignorespaces}
% \def\@thmcounterup#1{\noexpand\arabic{#1}}
% \def\@thmcountersep{.}
% \def\@begintheoremup#1#2{\trivlist
%    \item[\hskip \labelsep{\bfseries #1\ #2.}]\upshape}
% \def\@opargbegintheoremup#1#2#3{\trivlist
%       \item[\hskip \labelsep{\bfseries #1\ #2\ (#3).}]\upshape}
% \def\@endtheoremup{\endtrivlist}
%%
%% <<tgk<<
%%

%%
%% >>tgk>> --- Moved elsewhere, Summer 2015
%%
%\usepackage{lineno}
%%
%% <<tgk<<
%%

\setlength{\textheight}{598pt} %{598.2275pt}

%%
%% >>tgk>> --- Added Summer 2015 ---
%%
% Support for supplement numbering
\renewcommand{\theequation}{\siamprelabel\arabic{equation}}
\renewcommand{\thepage}{\siamprelabel\arabic{page}}
\renewcommand{\thetheorem}{\siamprelabel\arabic{theorem}}
\let\svbibcite\bibcite
\def\bibcite#1#2{\svbibcite{#1}{\siamprelabel#2}}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
% Adding a command to do running heads with uppercase and supplement support.
\newcommand{\headers}[2]{
% Declare page headings - use the \siampretitle command, which inserts
% "Supplementary Material" when appropriate.
\pagestyle{myheadings}
\markboth{\uppercase\expandafter{#2}}
{\uppercase\expandafter{\siampretitle{#1}}}}
%%
%% <<tgk<<
%%
%% >>tgk>> --- Added Summer 2015 ---
%%
%% Support for "review" class option to turn on linenumbers via the
%% lineno package. Slightly complicated because the lineno and amsmath
%% packages do not play well together.
\if@review
  \RequirePackage[mathlines]{lineno}[4.41]
  \linenumbers
  \renewcommand{\linenumberfont}{\normalfont\footnotesize\color{siamreviewcolor}}
  % The \linenumbers command does not play nice with amsmath, so we
  % have added some patches to fix it. See   
  % http://phaseportrait.blogspot.com/2007/08/lineno-and-amsmath-compatibility.html
  \newcommand*\patchAmsMathEnvironmentForLineno[1]{%
    \expandafter\let\csname old#1\expandafter\endcsname\csname #1\endcsname
    \expandafter\let\csname oldend#1\expandafter\endcsname\csname end#1\endcsname
    \renewenvironment{#1}%
    {\linenomath\csname old#1\endcsname}%
    {\csname oldend#1\endcsname\endlinenomath}}% 
  \newcommand*\patchBothAmsMathEnvironmentsForLineno[1]{%
    \patchAmsMathEnvironmentForLineno{#1}%
    \patchAmsMathEnvironmentForLineno{#1*}}%
  \patchBothAmsMathEnvironmentsForLineno{equation}%
  \patchBothAmsMathEnvironmentsForLineno{align}%
  \patchBothAmsMathEnvironmentsForLineno{flalign}%
  \patchBothAmsMathEnvironmentsForLineno{alignat}%
  \patchBothAmsMathEnvironmentsForLineno{gather}%
  \patchBothAmsMathEnvironmentsForLineno{multline}%
  \renewcommand{\footercopyright}{\textcolor{siamreviewcolor}%
    {\textit{This manuscript is for review purposes only.}}}
\fi
%%
%% <<tgk<<
%%

%_%_%_%_%
%_%_%_%_% patches, fixes JR 1/19/16
%_%_%_%_%


%_%_%_%_% for the benefit of Bakoma, no negative effect on Miktex, pdflatex
\newcommand{\listoffigures}{}
\newcommand{\listoftables}{}
\newcommand{\tableofcontents}{}
\ifpdf
  \DeclareGraphicsExtensions{.eps,.pdf,.png,.jpg,.jpeg}
\else
  \DeclareGraphicsExtensions{.eps}
\fi

%_%_%_%_% fixes a bug in ntheorem; % ending first line prevents 
%_%_%_%_% misalignment of equation numbers in eqnarray
\gdef\PotEndMark#1{%
\@ifnextchar[%]
    {\PotEndMark@opt{#1}}{\SetEndMark{\InTheoType}{#1}{\relax}}}%


%_%_%_%_% flag ro remove belowdisplay spacing in math
%\newcommand{\nomathspace}{\belowdisplayshortskip 0\p@ \@plus5\p@ \@minus3\p@%
%\belowdisplayskip 0\p@ \@plus0\p@ \@minus0\p@}
\newcommand{\nomathspace}{\belowdisplayshortskip 0\p@ \@plus3\p@ \@minus3\p@%
\belowdisplayskip 0\p@ \@plus3\p@ \@minus3\p@}




\endinput
%% 
%% End of file `siamart.cls'.


