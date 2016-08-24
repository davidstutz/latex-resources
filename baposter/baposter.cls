%%
%% This is file `baposter.cls'
%%
%% A relatively comfortable latex class to produce posters with a grid based
%% layout. It comes with a number of combinable styles and is (maybe only for
%% the writer) easy to extend, as all the graphics is based on pgf.
%%
%% It is meant to be used with pdftex, but might also work with pslatex if you
%% are not interested in things like transparency.
%%
%% Copyright (C) 2007-2011 Brian Amberg
%% Copyright (C) 2011      Reinhold Kainhofer <reinhold@kainhofer.com>
%%
%% 29. September 2011: 
%%     - Finally fixed confusion with paper size handling and landscape. This required seperate handling of papersizes 
%%       known to the geometry package and other packages.
%% 26. September 2011:
%%     - Reverted drawing of faded borders to manual method, as the current result does not work with evince, 
%%       and produced spurious colored boxes with okular and acroread.
%%     - Added one more example due to popular request
%% 16. September 2011:
%%     - Removed nag package, such that it compiles on older systems
%%     - Added more examples
%% 15. September 2011:
%%     - Merged fork by (rk) back into mainline, essentially taking over all the great improvements that Reinhold Kainhofer coded.
%%       We call this version 2, as it breaks the interface in some small points. Essentially watch out for this:
%%       - no/yes keys are now false/true
%%       - the shade-lr etc. keys have the hypen removed, and are now called shadelr etc.
%      - Added more examples, which are all adapted to work with the current version
%% 27. August 2011 (rk):
%%     - Completely factored out all drawing commands to handler functions, assigned via choice keys
%%     - Added cornerradius, boxheaderheight, boxpadding options
%%     - Added missing roundedright
%% 26. August 2011 (rk):
%%     - Turned headerbox cmd into posterbox environment (allows verbatim)
%%     - pass several options to packages
%%     - added debug cls option to reduce default output
%%     - rewrote several loops and ifthenelse
%%     - Use boolean and choice keys for all options
%%     - Changed all choice options to set a global function to
%%       \baposter@OPTION@OPTIONVALUE, which are a functions that execute the
%%       option's setting (drawing routine, color setting for tikz, etc.)
%%     - Add a5paper
%% 07. April 2011: Fixed paper size handling
%%     - Fixed Paper Size handling, you can now specify all page sizes using paperwidth=, paperheight= class options.
%%     - Added rudimentary documentation of the available keys.
%% 11. December 2010: Fixed "Empty Second Page" bug
%%     - A second empty page was introduced when a document ended with
%%           \end{poster}
%%         \end{document}
%%       This was fixed thanks to a suggestion by Martin Aulbach
%%     - Added
%%         \thispagestyle{empty}
%%       to suppress page numbers, which became visible when the margins are large.
%%       The underlying problem of page-size handling has not yet been solved.
%% 30. September 2010: Border Bugfixes
%%     - Correct background color with textborder=rounded-small, Thanks to Ke Chen for the bugreport and patch
%%     - Correctly draw rectangular text boxes, Thanks to abenkst for the bugreport and fix
%% 10. June 2010: Added option to set the number of columns
%%     - added a class option to set the number of columns
%%         - columns=5: sets the number of columns to 5, possible values are 1..6, default is 3 in portrait and 4 in landscape format
%% 29. April 2009: Incorporated Patches by Arne Henningsen
%%     - added some class options
%%        - a4shrink: shrink the paper to A4 size (for printing drafts or handouts)
%%        - movebody=Xpt: move the text/poster body Xpt to the right
%%                    (or to the left if Xpt is negative),
%%                    e.g. for manually centering the poster on the page
%%        - showframe: use the "showframe" option of the "geometry" package
%%        - a0paper (default): set paper size to A0
%%        - archE: set paper size to Arch E
%%     - setting "background" can be "none" now (otherwise the "showframe"
%%          option has no effect)
%%     - the page number has been removed (it was mostly not visible before)
%%     - the "margin=" option works now
%% 04. December 2008
%%     - Mainly an update to the landscape example
%% 14. November 2008
%%     - Actually center the title when eyecatcher is used.
%% 04. November 2008
%%     - Fixed bug with eyecatcher not working.
%% 26. June 2008
%%     - Fixed bug with plain background mode.
%% 14. June 2008
%%     - Support for portrait/landscape switching.
%%     - Some smaller bugfixes.
%% 01. June 2007
%%     - First version released.
%%
%% Use this class with pdflatex
%%
%% I have confirmed that this package works with
%%   - texlive 2007 and
%%   - miktex 2.7
%%
%% It does not seem to work with
%%   - miktex 2.2
%%   - some old versions of tetex
%%
%%
%% TODO:
%% -) Rename backgrounds back to shaded-tb shade-lr
%% -) Rename textborder back to rounded-small (consistent naming needed!)
%% -) Rename headershade back to shade-lr, shade-tb, shade-tb-inverse
%% -) Rename headershape back to small-rounded
%% -) Option value consistency (small-rounded vs. rounded-small; missing ones)
%% -) Rename \baposterHeaderSetShade, \baposterHeaderDrawText to include @ and verb
%%
%%
%% Licence: GPL
\ProvidesClass{baposter}[2011/11/26 v2.0 baposter class]
\NeedsTeXFormat{LaTeX2e}[1995/06/01]
\LoadClass{article}
\typeout{baposter: Brian Amberg, 2007, 2008, 2009, 2010, 2011 | http://www.brian-amberg.de/uni/poster/}
\typeout{baposter: Reinhold Kainhofer, 2011 | http://reinhold.kainhofer.com/}

%% Define lengths only once on inclusion, such that we can make multiple posters
\newlength{\baposter@basepaperwidth}
\newlength{\baposter@basepaperheight}
\newlength{\baposter@basemargin}
\newlength{\baposter@finalpaperwidth}
\newlength{\baposter@finalpaperheight}
\newlength{\baposter@finalmargin}
\newlength{\headerheight}%
\newlength{\colwidth}%
\newlength{\colheight}%
\newlength{\baposter@@colspacing}%
\newlength{\baposter@box@@cornerradius}%
\newlength{\baposter@box@@boxheaderheight}%
\newlength{\baposter@box@@boxpadding}%
\newlength{\boxstartx}%
\newlength{\boxstarty}%
\newlength{\boxwidth}%
\newlength{\boxheight}%
\newlength{\baposter@titleimage@left@width}%
\newlength{\baposter@titleimage@right@width}%
\newlength{\baposter@titleimage@textwidth}%
\newbox\baposter@box@content%
\newbox\baposter@titleimage@left%
\newbox\baposter@titleimage@title%
\newbox\baposter@titleimage@right%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Packages
%-------------------------------------------------------------------------------
% The only ``weird'' dependency of this package is pgf. All the rest should be
% installed on any decent system.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\typeout{Use Packages}
\RequirePackage{xkeyval}
\RequirePackage{calc}
\RequirePackage[cmyk]{xcolor}
\RequirePackage{tikz}
\RequirePackage{pgf}
\RequirePackage{ifthen}
\RequirePackage[T1]{fontenc}
%\RequirePackage[l2tabu, orthodox]{nag}
\usetikzlibrary{decorations}
\usetikzlibrary{fadings}
\usetikzlibrary{snakes}
\usetikzlibrary{calc}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Settings
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Choose a smaller value for larger fonts
\newcommand{\baposter@fontscale}{0.292}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Zoom
%-------------------------------------------------------------------------------
% We scale the page from fontscale * papersize up to papersize
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Paper sizes
\newif\if@landscape
\newif\if@geometryKnowsThisSize
\DeclareOptionX{landscape}{\@landscapetrue}
\DeclareOptionX{portrait}{}

\newcommand{\baposter@setfinalpapersize}[2]{%
\if@geometryKnowsThisSize
  \setlength{\baposter@finalpaperwidth}{#1}%
  \setlength{\baposter@finalpaperheight}{#2}%
\else
\if@landscape
% Transpose length, if geometry does not handle the papersize based on the key
  \setlength{\baposter@finalpaperwidth}{#2}%
  \setlength{\baposter@finalpaperheight}{#1}%
\else
  \setlength{\baposter@finalpaperwidth}{#1}%
  \setlength{\baposter@finalpaperheight}{#2}%
\fi
\fi
}

% Default paperwidth and paperheight = a0paper
\DeclareOptionX{paperwidth}[841mm]{\setlength{\baposter@finalpaperwidth}{#1}}
\DeclareOptionX{paperheight}[1189mm]{\setlength{\baposter@finalpaperheight}{#1}}
\DeclareOptionX{archA}         {                           \baposter@setfinalpapersize{9in}{12in}}%
\DeclareOptionX{archB}         {                           \baposter@setfinalpapersize{12in}{18in}}%
\DeclareOptionX{archC}         {                           \baposter@setfinalpapersize{18in}{24in}}%
\DeclareOptionX{archD}         {                           \baposter@setfinalpapersize{24in}{36in}}%
\DeclareOptionX{archE}         {                           \baposter@setfinalpapersize{36in}{48in}}%
\DeclareOptionX{archE1}        {                           \baposter@setfinalpapersize{30in}{42in}}%
\DeclareOptionX{archE2}        {                           \baposter@setfinalpapersize{26in}{38in}}%
\DeclareOptionX{archE3}        {                           \baposter@setfinalpapersize{27in}{39in}}%
\DeclareOptionX{a0paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{841mm}{1189mm}}%g
\DeclareOptionX{a1paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{594mm}{841mm}}%g
\DeclareOptionX{a2paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{420mm}{594mm}}%g
\DeclareOptionX{a3paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{297mm}{420mm}}%g
\DeclareOptionX{a4paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{210mm}{297mm}}%g
\DeclareOptionX{a5paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{148mm}{210mm}}%g
\DeclareOptionX{a6paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{105mm}{148mm}}%g
\DeclareOptionX{b0paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{1000mm}{1414mm}}%g
\DeclareOptionX{b1paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{707mm}{1000mm}}%g
\DeclareOptionX{b2paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{500mm}{707mm}}%g
\DeclareOptionX{b3paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{353mm}{500mm}}%g
\DeclareOptionX{b4paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{250mm}{353mm}}%g
\DeclareOptionX{b5paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{176mm}{250mm}}%g
\DeclareOptionX{b6paper}       {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{125mm}{176mm}}%g
\DeclareOptionX{ansiapaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{11in}}%
\DeclareOptionX{ansibpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{11in}{17in}}%
\DeclareOptionX{ansicpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{17in}{22in}}%
\DeclareOptionX{ansidpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{22in}{34in}}%
\DeclareOptionX{ansiepaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{34in}{44in}}%
\DeclareOptionX{letterpaper}   {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{11in}}%
\DeclareOptionX{legalpaper}    {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{8.5in}{14in}}%
\DeclareOptionX{executivepaper}{\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{7.25in}{10.5in}}%
\DeclareOptionX{screen}        {\@geometryKnowsThisSizetrue\baposter@setfinalpapersize{225mm}{180mm}}%g

% Margin
\setlength{\baposter@finalmargin}{1.5cm}
\DeclareOptionX{fontscale}[0.292]{\renewcommand{\baposter@fontscale}{#1}}
\DeclareOptionX{margin}   [1.5cm]{\setlength{\baposter@finalmargin}{#1}}

% move text/poster body to the right (or to the left if negative)
\newlength{\baposter@movebody}
\setlength{\baposter@movebody}{0cm}
\DeclareOptionX{movebody}[0cm]{\setlength{\baposter@movebody}{#1}}


\newif\if@debug
\DeclareOptionX{debug}{\@debugtrue}
%% Will be passed on to other packages (xcolor and geometry), still we don't want unused warnings
\DeclareOptionX{table}{}
\DeclareOptionX{showframe}{}

\ProcessOptionsX

\if@debug
\newcommand{\debug}[1]{\typeout{#1}}
\else
\newcommand{\debug}[1]{}
\fi



\setlength{\baposter@basepaperwidth} {\baposter@fontscale\baposter@finalpaperwidth }
\setlength{\baposter@basepaperheight}{\baposter@fontscale\baposter@finalpaperheight}
\setlength{\baposter@basemargin}     {\baposter@fontscale\baposter@finalmargin}
\newlength{\baposter@basemarginright}
\setlength{\baposter@basemarginright}{\baposter@basemargin}
\addtolength{\baposter@basemarginright}{-\baposter@fontscale\baposter@movebody}
\newlength{\baposter@basemarginleft}
\setlength{\baposter@basemarginleft}{\baposter@basemargin}
\addtolength{\baposter@basemarginleft}{\baposter@fontscale\baposter@movebody}

\typeout{Paperwidth=\the\baposter@finalpaperwidth}
\typeout{Paperheight=\the\baposter@finalpaperheight}
\typeout{BasePaperwidth=\the\baposter@basepaperwidth}
\typeout{BasePaperheight=\the\baposter@basepaperheight}
\usepackage[
   paperwidth=\baposter@basepaperwidth,
   paperheight=\baposter@basepaperheight,
   tmargin=\baposter@basemargin,
   bmargin=\baposter@basemargin,
   lmargin=\baposter@basemarginleft,
   rmargin=\baposter@basemarginright,
   ]{geometry} 

\usepackage{pgfpages}
\if@landscape
\if@geometryKnowsThisSize
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperheight,physical paper height=\baposter@finalpaperwidth]
\else
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperwidth,physical paper height=\baposter@finalpaperheight]
\fi
\else
\pgfpagesuselayout{resize to}[physical paper width=\baposter@finalpaperwidth,physical paper height=\baposter@finalpaperheight]
\fi



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Default functions for borders/backgrounds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% These functions will all be redefined from the actual option values. In
%% particular, they will be set to \baposter@optionname@optionvalue, which
%% should do the actual work / setting for that particular optionvalue.

\newcommand{\baposterPosterDrawBackground}[2]{} % Draw poster background

\newcommand{\baposterBoxGetShape}{}             % Returns path of text box shape
\newcommand{\baposterBoxDrawBackground}[2]{}    % Draw bg of boxes
\newcommand{\baposterBoxDrawBorder}[1]{}        % Draw border of individual boxes

\newcommand{\baposterHeaderGetShape}{}          % Returns path of text box shape
\newcommand{\baposterHeaderSetShade}[3]{}       % Set bg style for box headers
\newcommand{\baposterHeaderDrawBackground}[3]{} % Draw background of box header
\newcommand{\baposterHeaderDrawBorder}[1]{}     % Draw border of box header
\newcommand{\baposterHeaderDrawText}[1]{}       % Draw text inside box header

\newcommand{\@@previousbox}{notset}             % stores the previously processed box for below=auto

% Function to set a user-defined background
\newcommand{\baposter@backgroundCmd}{\error{No background command defined. Use \background{...} to define background}}
\newcommand{\background}[1]{\renewcommand{\baposter@backgroundCmd}{#1}}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Handle poster and box options
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\debug{Handling keys}

%%
%% POSTER OPTIONS
%%
%% Store all poster options in variables of the form \baposter@option
%% choose-keys also store the index in \baposter@optionnr
%% choose-keys typically also assign a function
\definecolor{baposter@silver}{cmyk}{0,0,0,0.7}
\define@boolkey[ba]{poster}[baposter@]{grid}                 [false]       {}
\define@boolkey[ba]{poster}[baposter@]{eyecatcher}           [true]        {}
\define@cmdkey [ba]{poster}[baposter@]{headerheight}         [0.1\textheight]{}
\define@cmdkey [ba]{poster}[baposter@]{columns}              [{}]          {}
\define@cmdkey [ba]{poster}[baposter@]{colspacing}           [1em]         {}
\define@cmdkey [ba]{poster}[baposter@]{bgColorOne}           [baposter@silver]{}
\define@cmdkey [ba]{poster}[baposter@]{bgColorTwo}           [green]       {}

% background can be one of: shadeLR, shadeTB, plain, user, none
\define@choicekey*+[ba]{poster}{background}%
    [\baposter@background\baposter@backgroundnr]%
    {shadeLR, shadeTB, plain, user, none} [plain] {%
  \debug{Poster background: \baposter@background}
  \renewcommand{\baposterPosterDrawBackground}[2]{
      \csname baposter@background@\baposter@background\endcsname{##1}{##2}}
}{
  \PackageWarning{baposter}{Unknown background `\baposter@background' (use
      shadeLR, shadeTB, plain, none, or user). If user is used, you also
      have to define \background{...}.}
  \renewcommand{\baposterPosterDrawBackground}[2]{\baposter@background@none{##1}{##2}}
}


%%
%%  BOX OPTIONS
%%
\define@cmdkey[ba]{posterbox}[baposter@box@]{cornerradius}          [1em]         {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxheaderheight}       [2em]         {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxpadding}            [0.5em]       {}


% textborder can be one of: none, bars, coils, triangles, rectangle, rounded,
% roundedleft, roundedsmall, faded; UNIMPLEMENTED: roundedright
\edef\baposter@box@textborder@validvalues{none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedsmall,faded}
\define@choicekey*+[ba]{posterbox}{textborder}%
    [\baposter@box@textborder\baposter@box@textbordernr]%
    {none,bars,coils,triangles,rectangle,rounded,roundedleft,roundedright,roundedsmall,faded} [rectangle] {%
  \debug{Text border: \baposter@box@textborder}
  \renewcommand{\baposterBoxGetShape}{
      \csname baposter@box@boxshape@\baposter@box@textborder\endcsname}
  \renewcommand{\baposterBoxDrawBorder}[1]{
      \csname baposter@box@drawborder@\baposter@box@textborder\endcsname{##1}}
}{
  \PackageWarning{baposter}{Unknown text-border style `\baposter@box@textborder'.
      Edit your file to choose a valid option (\baposter@box@textborder@validvalues).}
  \renewcommand{\baposterBoxGetShape}{\baposter@boxshape@rectangle}
  \renewcommand{\baposterBoxDrawBorder}[1]{\baposter@drawborder@rectangle{##1}}
}

% boxshade can be one of: shadeLR, shadeTB, plain, none
\define@choicekey*+[ba]{posterbox}{boxshade}%
    [\baposter@box@boxshade\baposter@box@boxshadenr]%
    {shadelr,shadetb,plain,none} [none] {%
  \debug{Box shade: \baposter@box@boxshade}
  \renewcommand{\baposterBoxDrawBackground}[2]{
      \csname baposter@box@drawbackground@\baposter@box@boxshade\endcsname{##1}{##2}}
}{
  \PackageWarning{baposter}{Unknown boxshade style `\baposter@boxshade'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterBoxDrawBackground}[2]{\baposter@box@drawbackground@none{##1}{##2}}
}

% headershade can be one of: shade-lr, shade-tb, shade-tb-inverse, plain
\define@choicekey*+[ba]{posterbox}{headershade}%
    [\baposter@box@headershade\baposter@box@headershadenr]%
    {shadelr, shadetb, shadetbinverse, plain} [shadelr] {%
  \debug{Header shade: \baposter@box@headershade}
  \renewcommand{\baposterHeaderSetShade}[3]{
      \csname baposter@box@headershade@\baposter@box@headershade\endcsname{##1}{##2}{##3}}
}{
  \PackageWarning{baposter}{Unknown headershade style `\baposter@box@headershade'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterHeaderSetShade}[3]{\baposter@box@headershade@none{##1}{##2}{##3}}
}

% headershape can be one of: rectangle, rounded, smallrounded, roundedleft, roundedright
\define@choicekey*+[ba]{posterbox}{headershape}%
    [\baposter@box@headershape\baposter@box@headershapenr]%
    {rectangle,rounded,smallrounded,roundedleft,roundedright} [roundedright] {%
  \debug{Header shape: \baposter@box@headershape}
  \renewcommand{\baposterHeaderGetShape}{
      \csname baposter@box@headershape@\baposter@box@headershape\endcsname}
  \renewcommand{\baposterHeaderDrawText}[1]{
      \csname baposter@box@headerdrawtext@\baposter@box@headershape\endcsname{##1}}
  \renewcommand{\baposterHeaderDrawBorder}[1]{
      \csname baposter@box@headerdrawborder@\baposter@box@headershape\endcsname{##1}}
}{
  \PackageWarning{baposter}{Unknown headershape style `\baposter@headershape'.
      Edit your file to choose a valid option.}
  \renewcommand{\baposterHeaderGetShape}{\baposter@box@headershape@rectangle}
  \renewcommand{\baposterHeaderDrawText}[1]{\baposter@box@headerdrawtext@rectangle{##1}}
  \renewcommand{\baposterHeaderDrawBorder}[1]{\baposter@box@headerdrawborder@rectangle{##1}}
}

% headerborder can be one of: open, closed, none
\define@choicekey*+[ba]{posterbox}{headerborder}%
    [\baposter@box@headerborder\baposter@box@headerbordernr]%
    {open,closed,none} [open] {%
  \debug{Header border: \baposter@box@headerborder}
%   \renewcommand{\baposterHeaderBorder}{
%       \csname baposter@headerborder@\baposter@box@headerborder\endcsname}
}{
  \PackageWarning{baposter}{Unknown headerborder style `\baposter@headerborder'.
      Edit your file to choose a valid option.}
%   \renewcommand{\baposterHeaderBorder}{\baposter@box@headerborder@rectangle}
}


\define@cmdkey[ba]{posterbox}[baposter@box@]{borderColor}           [yellow]      {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerColorOne}        [red]         {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerColorTwo}        [brown]       {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerFontColor}       [black]       {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxColorOne}           [magenta]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{boxColorTwo}           [cyan]        {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{headerfont}            [\scshape\Large]   {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{textfont}              [{}]          {}

\define@cmdkey[ba]{posterbox}[baposter@box@]{linewidth}             [2pt]         {}

\define@cmdkey[ba]{posterbox}[baposter@box@]{below}  [notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{above}  [notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{aligned}[notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{bottomaligned}[notset]{}
\define@cmdkey[ba]{posterbox}[baposter@box@]{column} [0]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{row}    [0]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{span}   [1]     {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{height} [auto]  {}
\define@cmdkey[ba]{posterbox}[baposter@box@]{name}   [noname]{}

% Set some default values, the poster and posterbox environments can override:
\setkeys[ba]{poster}{
  % Debug grid
  grid=false,
  % Is there an eyecatcher image
  eyecatcher=true,
  columns={},
  % Colours
  bgColorOne=baposter@silver,
  bgColorTwo=green,
  %
  colspacing=1em,
  headerheight=0.1\textheight,
  background=shadeLR,
}{}
\setkeys[ba]{posterbox}{
  % Position
  column=0,row=0,span=1,
  below=notset,above=notset,
  bottomaligned=notset,
  aligned=notset,
  height=auto,
  % Name
  name=noname,
  % Box design: border:
  linewidth=2pt,
  borderColor=yellow,
  cornerradius=1em,
  % text box:
  textfont={},
  boxshade=plain,
  boxColorOne=magenta,
  boxColorTwo=cyan,
  textborder=faded,
  boxpadding=0.5em,
  % header
  headerfont=\scshape\Large,% or headerfont=\color{white}\textsf\textbf
  headerFontColor=black,
  headerColorOne=red,
  headerColorTwo=brown,
  headershape=rectangle,
  headershade=shadeLR,
  headerborder=none,
  boxheaderheight=2em,
}{}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Background options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\baposter@background@shadelr}[2]{
  \debug{BAPOSTER: Using shade left right background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \shade [shading=axis,left color=#1,right color=#2] (current page.north west)
           rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\baposter@background@shadetb}[2]{
  \debug{BAPOSTER: Using shade top to bottom background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \shade [shading=axis,top color=#1,bottom color=#2] (current page.north west)
           rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\baposter@background@plain}[2]{
  \debug{BAPOSTER: Using plain background.}
  \begin{tikzpicture}[remember picture,overlay]%
    \fill [fill=#1] (current page.north west) rectangle(current page.south east);
  \end{tikzpicture}%
}
\newcommand{\baposter@background@user}[2]{
  \debug{BAPOSTER: Using user background.}
  \baposter@backgroundCmd%
}
\newcommand{\baposter@background@none}[2]{
  \debug{BAPOSTER: Using no background.}
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\baposter@box@boxshape@none}{\baposter@box@boxshape@rectangle}
\newcommand{\baposter@box@boxshape@bars}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) %
  (\baposter@box@name se) -- (\baposter@box@name tne)
}
\newcommand{\baposter@box@boxshape@coils}{\baposter@box@boxshape@bars}
\newcommand{\baposter@box@boxshape@triangles}{\baposter@box@boxshape@bars}
\newcommand{\baposter@box@boxshape@rectangle}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) -- %
  (\baposter@box@name se) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@boxshape@faded}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) %
  (\baposter@box@name tne) -- (\baposter@box@name se)
  }
\newcommand{\baposter@box@boxshape@rounded}{
  [rc] \baposter@box@boxshape@rectangle%
}
\newcommand{\baposter@box@boxshape@roundedsmall}{
  [src] \baposter@box@boxshape@rectangle
}
\newcommand{\baposter@box@boxshape@roundedleft}{
  (\baposter@box@name tnw) {[rc]-- (\baposter@box@name sw)} -- %
  (\baposter@box@name se) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@boxshape@roundedright}{
  (\baposter@box@name tnw) -- (\baposter@box@name sw) {[rc]-- %
  (\baposter@box@name se)} -- (\baposter@box@name tne)%
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box background (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
\newcommand{\baposter@box@drawbackground@none}[2]{
  \tikzstyle{box colors}=[]
}
\newcommand{\baposter@box@drawbackground@plain}[2]{
  \tikzstyle{box colors}=[fill=#1]
  \fill[box colors] \baposterBoxGetShape;
}
\newcommand{\baposter@box@drawbackground@shadelr}[2]{
  \tikzstyle{box colors}=[shading=axis, left color=#1, right color=#2]%
  \fill[box colors] \baposterBoxGetShape;
}
\newcommand{\baposter@box@drawbackground@shadetb}[2]{
  \tikzstyle{box colors}=[shading=axis, top color=#1, bottom color=#2]%
  \fill[box colors] \baposterBoxGetShape;
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Draw box border
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: borderColor
\newcommand{\baposter@box@drawborder@none}[1]{}
\newcommand{\baposter@box@drawborder@bars}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@coils}[1]{
  \draw[color=#1,segment amplitude=0.35em,segment length=0.4em,snake=coil] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@triangles}[1]{
  \draw[color=#1,segment amplitude=0.2em,segment length=0.4em,snake=triangles] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@rectangle}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@rounded}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@roundedleft}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@roundedright}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}
\newcommand{\baposter@box@drawborder@faded}[1]{
  % This is the right way to do it, but it does not work with evince, and has problems during printing, so instead we do
  %\draw[color=#1,path fading=south] \baposterBoxGetShape;%
  % this
  \foreach \x in {0,1,...,90} \draw[color=#1!\x] ($(\baposter@box@name tnw)!{(100-\x)/100}!(\baposter@box@name sw)$) -- ($(\baposter@box@name tnw)!{(100-(\x+10))/100}!(\baposter@box@name sw)$);%
  \foreach \x in {0,1,...,90} \draw[color=#1!\x] ($(\baposter@box@name tne)!{(100-\x)/100}!(\baposter@box@name se)$) -- ($(\baposter@box@name tne)!{(100-(\x+10))/100}!(\baposter@box@name se)$);%
}
\newcommand{\baposter@box@drawborder@roundedsmall}[1]{
  \draw[color=#1] \baposterBoxGetShape;%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Return shape path of text box (depending on the box shape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take no arguments
% TODO: For headerborder==none, use (\baposter@box@name outer tnw) instead!
\newcommand{\baposter@box@headershape@rectangle}{%
  (\baposter@box@name tnw) -- (\baposter@box@name nw) -- %
  (\baposter@box@name ne) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@headershape@smallrounded}{%
  (\baposter@box@name tnw) {[src] -- (\baposter@box@name nw) -- %
  (\baposter@box@name ne)} -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@headershape@roundedright}{%
  (\baposter@box@name tnw) -- (\baposter@box@name nw) {[rc] -- %
  (\baposter@box@name ne)} -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@headershape@roundedleft}{%
  (\baposter@box@name tnw) {[rc]-- (\baposter@box@name nw)} -- %
  (\baposter@box@name ne) -- (\baposter@box@name tne)%
}
\newcommand{\baposter@box@headershape@rounded}{%
  (\baposter@box@name tnw) {[rc] -- (\baposter@box@name nw) -- %
  (\baposter@box@name ne) } -- (\baposter@box@name tne)%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header text drawing (one function for each possible value of headershape)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take one argument: the header text
\newcommand{\baposter@box@headerdrawtext@rectangle}[1]{
  \path (\baposter@box@name nw) +(0em,-0.5\baposter@box@@boxheaderheight) node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\baposter@box@headerdrawtext@smallrounded}[1]{
  \path (\baposter@box@name nw) +(0.5\boxwidth,-0.5\baposter@box@@boxheaderheight) node[anchor=center] {#1};%
}
\newcommand{\baposter@box@headerdrawtext@roundedright}[1]{
  \path (\baposter@box@name nw) +(0em,-0.5\baposter@box@@boxheaderheight)%
        node[anchor=west,inner sep=0.4em,text depth=0.0em] {#1};%
}
\newcommand{\baposter@box@headerdrawtext@roundedleft}[1]{
  \path (\baposter@box@name nw) +(0em,-0.5\baposter@box@@boxheaderheight)%
        node[anchor=west,inner sep=0.4em] {#1};%
}
\newcommand{\baposter@box@headerdrawtext@rounded}[1]{
    \path (\baposter@box@name nw) +(0.5\boxwidth,-0.5\baposter@box@@boxheaderheight) node[anchor=center] {#1};%
}



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Header shade options and functions (one function for each possible value)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These functions take two arguments: headerColorOne, headerColorTwo and borderColor
\newcommand{\baposter@box@headershade@shadelr}[3]{
    \debug{Header-Shade: Shade Left - Right}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      left color=#1,%
      right color=#2%
    ]%
}
\newcommand{\baposter@box@headershade@shadetb}[3]{
    \debug{Header-Shade: Shade Top - Bottom}
    \tikzstyle{header colors}=[%
      color=#3,%
      shading=axis,%
      top color=#1,%
      bottom color=#2%
    ]%
}
\newcommand{\baposter@box@headershade@shadetbinverse}[3]{
    \tikzstyle{header colors}=[%
      top color=#1!75!#2,%
      bottom color=#2!100!#1,%
      shading angle=20%
    ]%
    \colorlet{baposterHeaderFontColor}{white}%
}
\newcommand{\baposter@box@headershade@plain}[3]{
    \debug{Header-Shade: Plain}
    \tikzstyle{header colors}=[%
      color=#3,%
      fill=#1%
    ]%
}
\newcommand{\baposter@box@headershade@none}[3]{
    \debug{Header-Shade: none}
    \tikzstyle{header colors}=[]
}




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% The main poster environment
%%% \begin{baposter}{settings}{Eye Catcher}{Title}{Author}{University Logo}
%%%-----------------------------------------------------------------------------
%%% The settings are
%%%   - grid=true,[false]:Show grid to help with alignment
%%%   - colspacing=0.7em: Column spacing
%%%   - columns=4:        number of columns (default 4 in landscape and 3 in portrait format) (maximum number is 6)
%%%   - color=[orange]:   xcolor color definition used as the main color of the poster
%%%   - colortwo=[white]: The other color for gradient based layouts
%%%   - textborder=none,bars,coils,triangles,rectangle,rounded,roundedsmall,roundedleft,roundedright,[faded]
%%%                       The style of the box around the text area
%%%   - headerborder=none,closed,open
%%%                       No extra border around box header, full border around box header or border that is open below.
%%%   - headershape=rectangle,rounded,roundedleft,roundedright
%%%                       Shape of the box-header region
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newenvironment{poster}[5]{%
  \thispagestyle{empty}% Suppress Page Number
  \debug{Poster Starts}%
  % This setkeys call parses all provided options and depending on the option
  % value, assigns different handler functions to the \baposter(Box|Header)*
  % functions. Once that is done, we don't have to care about particular
  % values for border, shading, etc. All we have to do is call the
  % handler functions and let them do their job.
  % This also allows the user to override the poster-wide defaults on a per-box
  % basis.
  \setkeys[ba]{posterbox,poster}{#1}%
%
  % TODO: Move all those assignments to the key macros!
  % Parse Keys%
  \colorlet{bgColorOne}{\baposter@bgColorOne}
  \colorlet{bgColorTwo}{\baposter@bgColorTwo}
%
  %% Boxes%
  \setlength{\headerheight}{\baposter@headerheight}%
  \setlength{\colheight}{\textheight-\baposter@headerheight}%
  \renewcommand{\@@previousbox}{notset}

  \debug{Format}%
  % Set default for columns if unset (4 for landscape, 3 for portrait)
  \ifthenelse{\equal{\baposter@columns}{}}{%
    \renewcommand{\baposter@columns}{\if@landscape4\else3\fi}%
  }{}
%
  \debug{Columns: \baposter@columns}%
  \setlength{\baposter@@colspacing}{\baposter@colspacing}%
  \setlength{\colwidth}{\textwidth}%
  \addtolength{\colwidth}{\baposter@@colspacing*(1-\baposter@columns)}%
  \ifcase\baposter@columns\relax
    \error{You need to have at least one column!}
  \or % 1
    \setlength{\colwidth}{\colwidth}%
  \or % 2
    \setlength{\colwidth}{0.5\colwidth}%
  \or % 3
    \setlength{\colwidth}{0.3333333333333\colwidth}%
  \or % 4
    \setlength{\colwidth}{0.25\colwidth}%
  \or % 5
    \setlength{\colwidth}{0.2\colwidth}%
  \or % 6
    \setlength{\colwidth}{0.16666666666\colwidth}%
  \else % >6
    \error{You do not want so many columns}
  \fi
%
  \newcommand{\baposter@reference}{north west}%
%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % A box with a header and some content. The basic unit of the poster%
  %---------------------------------------------------------------------------%
  % Each box has a name and can be placed absolutely or relatively.%
  % The only inconvenience is that you can only specify a relative position %
  % towards an already declared box. So if you have a box attached to the %
  % bottom, one to the top and a third one which should be inbetween, you %
  % have to specify the top and bottom boxes before you specify the middle %
  % box.%
  %%
  % below=  name of other node%
  % above=  name of other node%
  % aligned=name of other node%
  % bottomaligned=name of other node%
  % column= [0]     %
  % row=    [0]     %
  % span=   [1]     %
  % height= <size in percent of column height>,[auto]%
  % name=   [noname]%
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  % Backward-compatibility definition (\headerbox command uses posterbox env):
  \newcommand{\headerbox}[3]{%
    \begin{posterbox}[##2]{##1}
      ##3
    \end{posterbox}
  }

  \newenvironment{posterbox}[2][]{%
    \debug{Poster box options: ##1}%
    % Override the poster-wide defaults on a per-box basis
    \setkeys[ba]{posterbox}{##1}%
%
    \def\baposter@box@title{##2}
%
    \colorlet{borderColor}{\baposter@box@borderColor}
    \colorlet{headerColorOne}{\baposter@box@headerColorOne}
    \colorlet{headerColorTwo}{\baposter@box@headerColorTwo}
    \colorlet{headerFontColor}{\baposter@box@headerFontColor}
    \colorlet{boxColorOne}{\baposter@box@boxColorOne}
    \colorlet{boxColorTwo}{\baposter@box@boxColorTwo}
%
    \setlength{\baposter@box@@cornerradius}{\baposter@box@cornerradius}%
    \setlength{\baposter@box@@boxheaderheight}{\baposter@box@boxheaderheight}%
    \setlength{\baposter@box@@boxpadding}{\baposter@box@boxpadding}%


    %% The columns is always given absolute
    % boxstartx = column * colwidth + column * colspacing
    \setlength{\boxstartx}{(\colwidth+\baposter@@colspacing)*\baposter@box@column}%
%
    %% The width is gvien absolute
    % Box Width = span * colwidth + (span-1) * colspacing
    \setlength{\boxwidth}{\baposter@box@span\colwidth} %
    \addtolength{\boxwidth}{\baposter@@colspacing*(\baposter@box@span-1)}%
%
    %% Measure the content of the box%
    \setbox\baposter@box@content=\hbox\bgroup%
      \begin{pgfinterruptpicture}%
        \begin{minipage}[t]{\boxwidth-\baposter@box@@boxpadding*2}%
          \baposter@box@textfont\bgroup%
  }% End of posterbox preamble
  %%% HERE COME THE ACTUAL CONTENTS OF THE HEADERBOX ENVIRONMENT
  {% posterbox handling after contents (i.e. drawing everything)
          \egroup%
        \end{minipage}%
      \end{pgfinterruptpicture}%
    \egroup%
    \setlength{\boxheight}{\ht\baposter@box@content}%
    \addtolength{\boxheight}{\dp\baposter@box@content}%
    \addtolength{\boxheight}{\baposter@box@@boxheaderheight} % Header%
    \addtolength{\boxheight}{2\baposter@box@@boxpadding} % Inner Sep
%
    \ifthenelse{\equal{\baposter@box@height}{bottom}}{%
    }{\ifthenelse{\equal{\baposter@box@height}{auto}}{%
    }{ % Neither auto nor bottom%
      \setlength{\boxheight}{\baposter@box@height\colheight}%
    }}%
%
    %% Determine the box position%
    \debug{Setting Coordinates}%
    \debug{Upper Right}%
    \debug{\baposter@box@name}%
%
    %%% Upper Right Corner%
    % if below=auto, set it to the previous box
    % TODO: We should generalize this to the previous box of the used column,
    %       currently we use the previous box, which might be in a different column
    \ifthenelse{\equal{\baposter@box@below}{auto}}{%
        \edef\baposter@box@below{\@@previousbox}
        \debug{Box \baposter@box@name  has below=auto, placing it below box \baposter@box@below.}
    }{}
    \xdef\@@previousbox{\baposter@box@name}

    \ifthenelse{\not\equal{\baposter@box@below}{notset} }{%
      %% Below%
      \debug{Below}%
      \path[shape=coordinate] (\boxstartx,0pt |- \baposter@box@below se) ++(0pt,-\baposter@@colspacing) coordinate(\baposter@box@name nw);%
    }{%
      \ifthenelse{\not\equal{\baposter@box@aligned}{notset} }{%
        %% Aligned%
        \debug{Aligned: \baposter@box@aligned}%
        \path[shape=coordinate] (\boxstartx,0pt |- \baposter@box@aligned nw)                           coordinate(\baposter@box@name nw);%
      }{%
        %% Fixed%
        \debug{Fixed}%
        \setlength{\boxstarty}{\baposter@box@row\colheight}%
        \path[shape=coordinate] (\boxstartx,\colheight-\boxstarty)                                                  coordinate(\baposter@box@name nw);%
    }}%
%
    %% Lower Left Corner%
    \debug{Lower Left}%
    \ifthenelse{\equal{\baposter@box@above}{bottom}}{%
      %% Above = Bottom%
      \debug{Above bottom}%
      \ifthenelse{\equal{\baposter@box@below}{notset} \and \equal{\baposter@box@aligned}{notset}}{%
      \path[shape=coordinate] (\boxstartx,\boxheight)                                                              coordinate(\baposter@box@name nw);%
      }{}%
      \path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                           coordinate(\baposter@box@name se);%
      }{\ifthenelse{\not \equal{\baposter@box@bottomaligned}{notset}}{%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \baposter@box@bottomaligned se)                       coordinate(\baposter@box@name se);%
      }{{\ifthenelse{\not \equal{\baposter@box@above}{notset}}{%
        %% Above = Node%
        \path[shape=coordinate] (\boxstartx+\boxwidth,0pt |- \baposter@box@above nw)  +(0pt,\baposter@@colspacing) coordinate(\baposter@box@name se);%
      }{%
        %% Above = notset%
        \debug{Above=not set}%
        \ifthenelse{\equal{\baposter@box@height}{bottom}}{%
          %% height=bottom%
          \debug{height=bottom}%
          \path[shape=coordinate] (\boxstartx+\boxwidth,0pt)                                                       coordinate(\baposter@box@name se);%
        }{ %% height=auto or fixed%
          \debug{height=auto or fixed}%
          \path[shape=coordinate] (\baposter@box@name nw) ++(\boxwidth,-\boxheight)                                coordinate(\baposter@box@name se);%
	  }}}}}%
%
        %
    % Set coordinates relative to nw,se%
    \debug{Fixing Coordinates}%
    \path[shape=coordinate]%
      (\baposter@box@name nw) +(0pt,-\baposter@box@@boxheaderheight)                coordinate(\baposter@box@name tnw)%
      (\baposter@box@name nw |- \baposter@box@name se)   coordinate(\baposter@box@name sw)%
      (\baposter@box@name se |- \baposter@box@name nw)   coordinate(\baposter@box@name ne)%
      (\baposter@box@name ne) +(0pt,-\baposter@box@@boxheaderheight)                coordinate(\baposter@box@name tne)%
%
      (\baposter@box@name nw)  +(-0.025em,0pt)           coordinate(\baposter@box@name outer nw)%
      (\baposter@box@name tnw) +(-0.025em,0pt)           coordinate(\baposter@box@name outer tnw)%
      (\baposter@box@name sw)  +(-0.025em,0pt)           coordinate(\baposter@box@name outer sw)%
%
      (\baposter@box@name ne)  +( 0.025em,0pt)           coordinate(\baposter@box@name outer ne)%
      (\baposter@box@name tne) +( 0.025em,0pt)           coordinate(\baposter@box@name outer tne)%
      (\baposter@box@name se)  +( 0.025em,0pt)           coordinate(\baposter@box@name outer se);%
%
      %% Setting the bg colors of the box header
      \baposterHeaderSetShade{headerColorOne}{headerColorTwo}{borderColor}
%
      \tikzstyle{rc}=[rounded corners=\baposter@box@@cornerradius];%
      \tikzstyle{src}=[rounded corners=0.5em];%
%

    %% Now that everything is set up, draw the actual box, with bg and header
    \begin{scope}[line width=\baposter@box@linewidth]
      %% Header%
      \debug{Header}%
      \debug{Header-Shape: \baposter@box@headershape, header-border: \baposter@box@headerborder (\baposter@box@headerbordernr)}%
      % TODO: Also turn this last ifcase construct into a handler function
      %       We only need to determine (fill|shade)(draw|)...
%       \baposterHeaderDrawBackground{bgColorOne}{bgColorTwo}{borderColor}
%       \baposterHeaderDrawBorder{borderColor}
      \ifcase\baposter@box@headerbordernr\relax%
        % open
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \filldraw  [style=header colors] \baposterHeaderGetShape;%
        }{
          \shadedraw [style=header colors] \baposterHeaderGetShape;%
        }
      \or
        % closed
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \filldraw  [style=header colors] \baposterHeaderGetShape -- cycle;%
        }{
          \shadedraw [style=header colors] \baposterHeaderGetShape -- cycle;%
        }
      \or
        % none
        \ifthenelse{\equal{\baposter@box@headershade}{plain}}{
          \fill      [style=header colors] \baposterHeaderGetShape;%
        }{
          \shade     [style=header colors] \baposterHeaderGetShape;%
        }
      \fi
      %
      %% Draw the text inside the box header:
      \baposterHeaderDrawText{\color{headerFontColor}\baposter@box@headerfont{\baposter@box@title}};%
      %
      %% Text borders (border around boxes)
      \debug{Poster boxes}%
      % First set box shade
      \baposterBoxDrawBackground{boxColorOne}{boxColorTwo}
      \baposterBoxDrawBorder{borderColor}
      %%
      %% Text Box%
      \debug{Drawing Text}%
      \path (\baposter@box@name tnw) node(text) [anchor=north west,
            outer sep=-0.000em,text width=\boxwidth-2\baposter@box@@boxpadding,inner sep=\baposter@box@@boxpadding,
            text justified] {\usebox{\baposter@box@content}};%
    \end{scope}
    %
    % Finally store the box name as the previous box for the next call
%     \xdef\@@previousbox{\baposter@box@name}%
  }% END of posterbox definition
%
  %% Poster Background%
  \baposterPosterDrawBackground{bgColorOne}{bgColorTwo}%
  %% Poster header/title
  \hspace{-1.5em}%
  \begin{tikzpicture}[inner sep=0pt,outer sep=0pt,line width=0.05em]%
    \useasboundingbox (0em,0em) rectangle(\textwidth,\textheight);%
    \path[shape=coordinate]%
      (0pt,\colheight) coordinate(north west) (\textwidth,\colheight) coordinate(north east)%
      (0pt,0pt) coordinate(south west)        (\textwidth,0pt) coordinate(south east);%
%
    \ifbaposter@eyecatcher% Has eye catcher
      \debug{Eyecatcher found!}
      \setbox\baposter@titleimage@left=\hbox{#2}%
    \else% Has no eye catcher%
      \setbox\baposter@titleimage@left=\hbox{}%
    \fi%
    \setlength{\baposter@titleimage@left@width}{\wd\baposter@titleimage@left}%
    \setbox\baposter@titleimage@right=\hbox{#5}%
    \setlength{\baposter@titleimage@right@width}{\wd\baposter@titleimage@right}%
    \setlength{\baposter@titleimage@textwidth}{\textwidth}%
    \addtolength{\baposter@titleimage@textwidth}{-\baposter@titleimage@left@width}%
    \addtolength{\baposter@titleimage@textwidth}{-\baposter@titleimage@right@width}%

    \debug{#3}
    %
    %
    %      % Draw Header%
    \draw (north west) +(0em,1em+0.5\headerheight) node(image)[anchor=west]   { {\usebox{\baposter@titleimage@left }} };%
    \draw (north east) +(0em,1em+0.5\headerheight) node(logo) [anchor=east]   { {\usebox{\baposter@titleimage@right}} };%
    %
    \ifbaposter@eyecatcher% Has eye catcher%
      \draw (image.east) node(title)[anchor=west,text width=\baposter@titleimage@textwidth]{%
        \begin{minipage}{\baposter@titleimage@textwidth}%
          \begin{center}%
          \textbf{\Huge #3}\\%
          {\Large #4}%
          \end{center}%
        \end{minipage}
      };%
    \else% Has no eye catcher
      \draw (image.east) node(title)[anchor=west]  { {\begin{minipage}{\baposter@titleimage@textwidth}{\bfseries\Huge #3}\\{\Large #4}\end{minipage}} };%
    \fi
  }% END poster begin
% The body
  {% BEGIN poster end
    % The end, draw gridlines if neccesary
    \ifbaposter@grid
      \newdimen{\gridpos}
      \pgfmathsetmacro{\z}{\baposter@columns-1}
      \foreach \y in {0,...,\z}
      {
        \setlength{\gridpos}{\y\colwidth+\y\baposter@@colspacing}
        \draw[draw=green,draw opacity=0.7] (\gridpos,0pt)  -- (\gridpos,\colheight)
            (\gridpos+\colwidth,0pt)  -- (\gridpos+\colwidth,\colheight);%
      }
      % Horizontal lines, every 0.1:
      %% Explicitly list all percentages, because with {0.0, 0.1, ..., 1.0} we
      %% get rounding errors in the displayed numbers!
      \foreach \y in {0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0}
        \draw[draw=green,draw opacity=0.7] (0pt,\colheight-\y\colheight)  --
            (\textwidth,\colheight-\y\colheight) node[anchor=west] {\y};%
    \fi%
  \end{tikzpicture}%
 % \xkvview{}
 \par
  }% END poster end
