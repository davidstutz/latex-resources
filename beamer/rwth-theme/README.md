# RWTH Aachen University LaTeX Theme

This is a fork of the RWTH Aachen Unviersity LaTeX/Beamer Theme.

The original project can be found at: [http://geekstack.net/projects/rwth-latex-theme/](http://geekstack.net/projects/rwth-latex-theme/).

## FAQ

*How to show outline only before sections?*

Change the following lines:

	\AtBeginSubsection[]
    {
        \begin{frame}
            % This shouldn't be fixed. 
            \frametitle{#1}
            % Highlight just the current subsection and its parent section
            \tableofcontents[currentsection,currentsubsection]
        \end{frame}
    }

New code:
	
	\AtBeginSection[]
    {
        \begin{frame}
            % This shouldn't be fixed. 
            \frametitle{#1}
            % Highlight just the current subsection and its parent section
            \tableofcontents[currentsection]
        \end{frame}
    }

## License

**Note:** The below license does not include the RWTH Aachen University logo (that is, `logo.png`), that is RWTH Aachen University is copyright holder of the provided logo.

Copyright (c) 2012 - 2014 by Tobias Pohlen <tobias.pohlen@gmail.com>

Released under the GPL License, see `GPL.txt`.