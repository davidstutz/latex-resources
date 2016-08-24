% resume_brennen.cls 
% slight tweak of D. Burrows version

% resume.cls
%
%    Copyright 2005 Daniel Burrows
%
% You may use, modify, and redistribute this file in any way you please, so
% long as this copyright notice is maintained.

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume_brennen}

\LoadClassWithOptions{article}

% No page numbers by default.
\pagestyle{empty}

\RequirePackage{calc}
\RequirePackage{ifthen}
\RequirePackage{url}
\RequirePackage{tabularx}
\RequirePackage{pgf}
\RequirePackage{pgfshade}
\RequirePackage{xxcolor}

% <Brennen> Commented these trying to get back to Computer Modern.
%           This appears to have worked. Should do the right thing
%           at some future point.
%\RequirePackage{times}
%\RequirePackage[T1]{fontenc}

\RequirePackage[tmargin=1in,bmargin=1in]{geometry}

\definecolor{rulestartcolor}{rgb}{0,0,0}
\definecolor{ruleendcolor}{rgb}{0.4,0.4,0.4}

\newlength{\headerbuffer}
\setlength{\headerbuffer}{2pt}
\newlength{\secskip}
\setlength{\secskip}{6pt}

\newlength{\@headerscratch}

% Usage: \@setupshading{width}{height}{start}{end}
\newcommand{\@setupshading}[4]{%
  \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
    color(0pt)=(#3); color(#1)=(#4)%
  }
}

\newcommand{\pgfrule}[4]{%
  \begin{pgfpicture}{0pt}{0pt}{#1}{#2}%
    \pgfdeclarehorizontalshading{@ruleshading}{#2}{%
      color(0pt)=(#3); color(#1)=(#4)%
    }
    \pgfputat{\pgfxy(0,0)}{\pgfbox[left,bottom]{\pgfuseshading{@ruleshading}}}
  \end{pgfpicture}%
}

\newcommand{\lrule}[2]{\pgfrule{#1}{#2}{rulestartcolor}{ruleendcolor}}
\newcommand{\rrule}[2]{\pgfrule{#1}{#2}{ruleendcolor}{rulestartcolor}}

\newcommand{\@authorname}{}
\newcommand{\@email}{}
\newcommand{\@streetaddress}{}
\newcommand{\@citystatezip}{}
\newcommand{\@phone}{}
\newcommand{\@webpage}{}

\renewcommand{\author}[1]{\renewcommand{\@authorname}{#1}}
\newcommand{\email}[1]{\urldef{\@email}{\url}{<#1>}}
\newcommand{\streetaddress}[1]{\renewcommand{\@streetaddress}{#1}}
\newcommand{\citystatezip}[1]{\renewcommand{\@citystatezip}{#1}}
\newcommand{\phone}[1]{\renewcommand{\@phone}{#1}}
\newcommand{\webpage}[1]{\urldef{\@webpage}{\url}{#1}}

\renewcommand{\maketitle}{{%
  \setlength{\@headerscratch}{\linewidth*2/3}%
  % <Brennen> Commented this to get rid of rule above name.
  %\noindent \lrule{\@headerscratch}{1.5pt}%
  \vspace{\headerbuffer}%
  \ifthenelse{\equal{\@email}{}}{%
    \par\nointerlineskip\noindent\makebox[\linewidth]{\textbf{\Large{\@authorname}}}%
  } {%
    \par\nointerlineskip\noindent\makebox[\linewidth]{\textbf{\Large{\@authorname\ \@email}}}%
  }%
  \vspace{\headerbuffer}%
  \par\nointerlineskip\noindent%
  \hspace{\linewidth}%
  \hspace{-\@headerscratch}%

  % <Brennen> Commented this to get rid of rule below name.
  %\rrule{\@headerscratch}{1.5pt}%
  \par\nointerlineskip\noindent%
  % Typeset webpage/phone in columns if both are specified, or
  % just on the LHS if only one is.
  \begin{small}%
    \ifthenelse{\equal{\@webpage}{}}{%
      \ifthenelse{\equal{\@phone}{}}{}{\@phone\par\nointerlineskip\noindent}%
    } {%
      \ifthenelse{\equal{\@phone}{}}{\@webpage\par\nointerlineskip\noindent}{%
        \begin{tabular*}{\linewidth}{l@{\extracolsep{\fill}}r}%
          \@phone & \@webpage%
        \end{tabular*}%
        \par\nointerlineskip\noindent%
      }%
    }%
    \ifthenelse{\equal{\@streetaddress}{} \and%
      \equal{\@citystatezip}{}}{}{%
      \ifthenelse{\equal{\@streetaddress}{} \or %
        \equal{\@citystatezip}{}}{%
          \ClassError{resume}{%
            Only one of \protect\streetaddress and \protect\citystatezip given
          }{%
            You must either define both \protect\streetaddress and \protect\citystatezip,
            or define neither of them.
          }%
        }{%
%
          \begin{tabular*}{\linewidth}{l@{\extracolsep{\fill}}r}%
            \@streetaddress & \@citystatezip%
          \end{tabular*}%
        }}%
%     \ifthenelse{\equal{\@webpage}{}}{}{%
%       \@webpage%
%     }%
  \end{small}
}}

\renewcommand{\section}[1]{%
  \goodbreak\vspace{\secskip}%
  \par\nointerlineskip\noindent\textbf{\textsc{\large\makebox[\linewidth][l]{#1}}}\vspace{\headerbuffer}\par\nointerlineskip\noindent%
  \lrule{\linewidth}{0.4pt}%
  \vspace{\headerbuffer}\par\nointerlineskip}

\renewcommand{\subsection}[1]{%
  \goodbreak\vspace{\secskip}\par\nointerlineskip\vspace{-1em}\textbf{\flushleft{#1}:}\par%
}

% General catch-all for either educational or job affiliation.
%
%  Usage:
% \affiliation[title]{institution}{years}
% <Brennen> Changed to \emph[#1] down there.
\newcommand{\affiliation}[3][]{%
  \goodbreak\vspace{\secskip}\par\noindent\begin{tabularx}{\linewidth}{Xr}%
    {\bfseries #2} & \textit{#3}%
    \ifthenelse{\equal{#1}{}}{}{%
      \\ \emph{#1}%
    }%
  \end{tabularx}%
}%

