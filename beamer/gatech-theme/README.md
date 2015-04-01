# Georgia Tech LaTeX Theme

Georgia Tech LaTex Beamer Theme based on the RWTH Aachen University LaTex Beamer Theme by Tobias Pohlen.

## FAQ

**How to not show the table of contents before each _sub_section?**

In the method `GTtoc` comment out the `AtBeginSubsection` statement:

    %
    % Show table of contents.
    %
    % @param frame title
    %
    \newcommand{\GTtoc}[1]
    {
        \AtBeginSection[]
        {
            \begin{frame}
                \frametitle{#1}
                % Highlight the current subsection and its parent section.
                \tableofcontents[currentsection]
            \end{frame}
        }
        %\AtBeginSubsection[]
        %{
        %    \begin{frame}
        %        \frametitle{#1}
        %        % Highlight the current subsection and its parent section.
        %        \tableofcontents[currentsection,currentsubsection]
        %    \end{frame}
        %}
    }

## License

**Note:** The below license does not include the Georgia Tech logo (that is, `logo-gt.png`), that is Georgia Tech is copyright holder of the provided logo.

Copyright (c) 2015, David Stutz

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see [http://www.gnu.org/licenses/](http://www.gnu.org/licenses/).
