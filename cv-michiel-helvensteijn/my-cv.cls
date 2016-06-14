%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \iffalse %%%%
%                                                                              %
%  Copyright (c) 2013 - Michiel Helvensteijn   (www.mhelvens.net)              %
%                                                                              %
%  This work may be distributed and/or modified under the conditions           %
%  of the LaTeX Project Public License, either version 1.3 of this             %
%  license or (at your option) any later version. The latest version           %
%  of this license is in       http://www.latex-project.org/lppl.txt           %
%  and version 1.3 or later is part of all distributions of LaTeX              %
%  version 2005/12/01 or later.                                                %
%                                                                              %
%  This work has the LPPL maintenance status `author-maintained'.              %
%                                                                              %
%  The Current Maintainer of this work is Michiel Helvensteijn.                %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% \fi %%%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{my-cv}[2012/11/12 Personal CV Class]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Class                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\LoadClassWithOptions{curve}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages                                                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[pdftex,colorlinks=true]{hyperref}
\RequirePackage[super]{nth}
\RequirePackage{my-whenprinting}
\RequirePackage{etoolbox}
\RequirePackage{etextools}
\RequirePackage{xcolor}
\RequirePackage{textcomp}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Narrower Page Margins                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\RequirePackage[margin=2cm]{geometry}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Link Commands                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\pdfonlylink}[2]{\ifpdf\coverwhenprinting{\href{#1}{#2}}\fi}

\newcommand{\pdflink}[2]{\ifpdf\coverwhenprinting[#2]{\href{#1}{#2}}\else#2\fi}

\newcommand{\pdfurl}[1]{{\ttfamily\pdflink{#1}{#1}}}

\newcommand{\pdfref}[2]{\ifpdf\coverwhenprinting[#2]{\hyperref[#1]{#2}}\else#2\fi}

\newcommand{\pdfemail}[1]{{\ttfamily\pdflink{mailto:#1}{#1}}}

\newcommand{\www}[1]{\pdfonlylink{#1}{{\setlength\fboxsep{2px}\fbox{\vphantom{W}www}}}}

\newcommand{\doi}[1]{\pdfonlylink{http://dx.doi.org/#1}{{\setlength\fboxsep{2px}\fbox{\vphantom{W}doi}}}}

\newcommand{\emptydoi}{%
	\coverwhenprinting{{\color{gray}\setlength\fboxsep{2px}\fbox{\vphantom{W}\phantom{doi}}}}%
}

\newcommand{\emptywww}{%
	\coverwhenprinting{{\color{gray}\setlength\fboxsep{2px}\fbox{\vphantom{W}\phantom{\vphantom{W}www}}}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Year Commands                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newlength{\yearwidth} \settowidth {\yearwidth} {0000}
\newlength{\yearheight}\settoheight{\yearheight}{0000}

% .... dirty hack
\let\mycv@oldnoalign\noalign
\newcommand{\mycv@oneshotnoalign}{\def\noalign{\let\noalign\mycv@oldnoalign}}

%%% Different kinds of entry markers
%
\newcommand{\mycv@futuremarker} {\prefix{\textopenbullet}\ignorespaces}
\newcommand{\mycv@starredmarker}{\prefix{{\Large$\hspace{-.34mm}\star$}}\ignorespaces}
\newcommand{\mycv@normalmarker} {\prefix{\textbullet}\ignorespaces}
\newcommand{\mycv@nomarker}     {\prefix{\phantom{\textbullet}}\ignorespaces}

\let\in\relax
\NewDocumentCommand{\in}{sm}{%
	\IfBooleanTF{#1}{\mycv@starredmarker}{\mycv@normalmarker}%
	\mycv@oneshotnoalign%
	\entry*[#2]%
}
\newcommand{\mycv@future}[1]{\parbox[][\yearheight][t]{\yearwidth}{\centering\footnotesize\textit{#1}}}
\NewDocumentCommand{\inExpected}{sm}{%
	\mycv@futuremarker%
	\mycv@oneshotnoalign%
	\entry*[\mycv@future{#2}]%
}

\NewDocumentCommand{\fromToExpected}{smm}{%
	\mycv@futuremarker%
	\mycv@oneshotnoalign%
	\entry*[#2 -- \mycv@future{#3}]%
}

\NewDocumentCommand{\fromExpectedToExpected}{smm}{%
	\mycv@futuremarker%
	\mycv@oneshotnoalign%
	\entry*[\mycv@future{#2} -- \mycv@future{#3}]%
}

\newcommand{\mycv@yeardots}{\parbox{\yearwidth}{\centering\ensuremath{\cdots}}}
\NewDocumentCommand{\from}{sm}{%
	\IfBooleanTF{#1}{\mycv@starredmarker}{\mycv@normalmarker}%
	\mycv@oneshotnoalign%
	\entry*[#2 -- \mycv@yeardots]%
}

\NewDocumentCommand{\fromTo}{smm}{%
	\IfBooleanTF{#1}{\mycv@starredmarker}{\mycv@normalmarker}%
	\mycv@oneshotnoalign%
	\entry*[#2 -- #3]%
}

\NewDocumentCommand{\breakline}{}{%
	\mycv@nomarker%
	\mycv@oneshotnoalign%
	\entry*[]%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Curve Settings                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\rubricalignment{cl}
\keyalignment{r}
\def\subrubricspace{10pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Headers                                                                      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\let\mycv@oldleftheader\leftheader
\let\mycv@oldrightheader\rightheader

\newcommand{\mycv@headerframe}[1]{%
	\begin{tabular}{@{}l@{$\ $}l@{}}%
	#1\\[7mm]%
	\end{tabular}%
}

\renewcommand{\leftheader}[1]{\mycv@oldleftheader{\mycv@headerframe{#1}}}
\renewcommand{\rightheader}[1]{\mycv@oldrightheader{\mycv@headerframe{#1}}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title and Subtitle                                                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\title{Curriculum Vit\ae}

\let\myname\subtitle

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inserting Headers and Titles                                                 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{\makeheaders[b]\maketitle}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rubric Tweaks                                                                %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Custom Underlining of Rubric Titles
%
\def\@@rubrichead#1{%
	\@rubricfont%
	\makebox[0pt][l]{\rule[-1.5mm]{0.857\linewidth}{0.4mm}}%
	\makebox[\linewidth-24.5\fboxsep][l]{#1}
	\vspace{8pt}
}

%%% Looking in the rubric subdirectory
%
\let\@oldmakerubric\makerubric
\renewcommand{\makerubric}[1]{\@oldmakerubric{rubrics/#1}}






%%% Copied original code for the rubric environment
%%% to add an optional extra column.
%
\def\@rubrichead#1#2{%
	&\multicolumn{#2}{@{\@clcccolsep}l@{}}{\@@rubrichead{#1}}%
}
\renewenvironment{rubric}[3]{%
  %% \begin{rubric}
  \def\raggedright{%
    \@rightskip\@flushglue\rightskip\@rightskip\leftskip\z@skip}%
  \def\raggedleft{%
    \rightskip\z@skip\leftskip\@flushglue\parfillskip\z@skip}%
  \gdef\@beforespace{0pt}%
  \gdef\@nextentry{}%
  \gdef\@previouskey{}%
  \global\let\old@newpage\newpage%
  \global\let\old@pagebreak\pagebreak%
  \global\let\old@nopagebreak\nopagebreak
  \begin{longtable}{#3}
    \@rubrichead{#1}{#2}\\*[\rubricspace]
    \endfirsthead
    \@rubrichead{#1\@continuedname}{#2}\\*[\rubricspace]
    \endhead
    \noalign{\@rubricmark{#1}%
      \global\let\in@newpage\newpage%
      \global\let\in@pagebreak\pagebreak%
      \global\let\in@nopagebreak\nopagebreak%
      \gdef\newpage{\@nextentry\noalign{\gdef\@nextentry{}}\in@newpage}
      \gdef\pagebreak{\@nextentry\noalign{\gdef\@nextentry{}}\in@pagebreak}
      \gdef\nopagebreak{\@nextentry\noalign{\gdef\@nextentry{}}\in@nopagebreak}}}{%
    %% \end{rubric}
    \@nextentry
  \end{longtable}\par\vspace\rubricafterspace
  \global\let\newpage\old@newpage%
  \global\let\pagebreak\old@pagebreak%
  \global\let\nopagebreak\old@nopagebreak}





%%% Constant width to the left of content and
%%% extra info to the right of the title
%
\let\@oldbeginrubric\rubric
\let\@oldendrubric\endrubric
\let\@extrainfo\relax

\let\@oldcontinuedname\@continuedname % swallow \@extrainfo
\renewcommand{\@continuedname}[1]{\hfill{\normalsize\textit{continued}}}

\let\@oldrubrichead\@rubrichead
\renewcommand{\@rubrichead}[1]{\@oldrubrichead{#1{\@extrainfo}}}

\RenewDocumentEnvironment{rubric}{+mso}{%
	\IfValueT{#3}{\def\@extrainfo{\hfill{\normalsize $\star$ #3}}}%
	\IfBooleanTF{#2}{%
		\@oldbeginrubric{%
			#1\noexpand\@extrainfo%
		}{3}{@{}kl@{~}l@{}l@{}}
	}{%
		\@oldbeginrubric{%
			#1\noexpand\@extrainfo%
		}{2}{@{}kl@{~}X@{}}
	}%
	%
	\noentry{0000 -- 0000}%
}{%
	\@oldendrubric%
}
