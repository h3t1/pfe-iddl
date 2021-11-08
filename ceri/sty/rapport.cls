%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Classe de rapport pédagogique
%% v4.2.5 - 11/01/2021
%%
%% Vincent Labatut 2014-20 <vincent.labatut@univ-avignon.fr>
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% init class 
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ceri/sty/rapport}[Report LaTeX class]
\LoadClass[a4paper, 12pt, final]{article}	% based on the existing latex class
\renewcommand{\baselinestretch}{1.25}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% encoding and stuff
\RequirePackage[english,french]{babel}	% language package
%\frenchsetup{AutoSpacePunctuation=false}	% disable space insertion before colon (doesn't work)
%	\RequirePackage{polyglossia}			% alternative to babel for LuaLaTeX
%	\setmainlanguage{french}
%\RequirePackage[T1]{fontenc}				% select font encoding and allow hyphenation
\RequirePackage{fontspec}
\usepackage{stackengine}
\usepackage{xparse}
\usepackage{appendix}
\usepackage{menukeys}
\renewmenumacro{\directory}{pathswithfolder}
%\RequirePackage{luatextra}				    % same, but for LuaLaTex instead of PDFlatex
%    \defaultfontfeatures{Ligatures=TeX}     % for ligatures in LuaLaTex (may slow down the compilation)
%\RequirePackage[utf8]{inputenc}			% use source file containing diacritics (not necessary for LuaLaTeX or XeLaTeX)
\RequirePackage{soul}						% improves hyphenation
\usepackage{fontawesome}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% font settings
\RequirePackage{luatexbase}                 % solves problem between LuaLaTeX, TexLive 2018 and microtype
\RequirePackage[
	babel=true
%	kerning=true							% option conflicts with LuaLaTeX
]{microtype}					        	% typographical refinements
\RequirePackage{lmodern}					% uses better fonts (?)
\setsansfont{IBMPlexSans}[                       % set up custom font
    Extension = .ttf,
    Path = ceri/fonts/,
    UprightFont = *-Light,
    BoldFont = *-Medium,
    ItalicFont = *-LightItalic,
    BoldItalicFont = *-MediumItalic,
	SmallCapsFont = *-Medium,
    FontFace={k}{n}{*-Bold},
    FontFace={k}{it}{*-BoldItalic}
]
\newcommand{\textbbf}[1]{%                  % command to insert bolder text
    {\fontseries{k}\selectfont{}#1}}
\renewcommand{\familydefault}{\sfdefault}	% use the sans-serif font
\def\mathfamilydefault{\rmdefault}          % but keep the serif font for formulas
\RequirePackage{xspace}						% add missing spaces
\RequirePackage{icomma}						% no space inserted after commas in expressions such as 1,23 (French)
\RequirePackage{eurosym}					% euro symbol (€)
\RequirePackage{textcomp}					% degree character (°)
\RequirePackage{pifont}                     % dingbat characters
\newcommand{\cmark}{\ding{51}}              % command for check mark
\newcommand{\xmark}{\ding{55}}              % command for matching cross mark
\RequirePackage{relsize}                    % define relative font sizes

\newcommand\specialbox[6][t]{%
  \kern\fboxrule%
  \stackinset{r}{}{b}{0pt}{\color{#3}\rule{\fboxrule}{#4}}{%
  \stackinset{r}{}{b}{-\fboxrule}{\color{#3}\rule{#4}{\fboxrule}}{%
  \stackinset{l}{-\fboxrule}{t}{0pt}{\color{#3}\rule{\fboxrule}{#4}}{%
  \stackinset{l}{-\fboxrule}{t}{-\fboxrule}{\color{#3}\rule{#4}{\fboxrule}}{%
  \colorbox{#2}{\parbox[#1]{\dimexpr#5-2\fboxsep-2\fboxrule}{#6}}%
  }}}%
  \kern\fboxrule}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% middle dot
%%%%\newcommand{\tpc}{\textperiodcentered}      % original middle dot command
%%%%\newcommand{\tpc}{$\cdot$}                  % middle dot command
%%%\RequirePackage{fontspec}                   % this solution is more robust
%%%\RequirePackage{polyglossia}               % but much slower when compiling
%%%\setmainlanguage{french}                   % we don't really need polyglossia, apparently
%\RequirePackage{newunicodechar}
%%%\newunicodechar{·}{\makebox[0.27em]{·}}
%\newunicodechar{·}{\ensuremath{{\cdot}}}   % possibly unnecessary with appropriate font


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% needed for UAPV title page formating
\RequirePackage{graphicx}					% improves \includegraphics
\sodef\ugg{}{.4em plus 1fill}{1em plus 2 fill}{2em plus 2fill minus.1em}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% space-related settings
\RequirePackage[top=2.5cm, 
	bottom=2.5cm, 
    left=2.5cm, 
    right=2.5cm]{geometry}					% changes document margins
\RequirePackage{setspace}					% controls spacing between lines


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% misc
\RequirePackage[french]{varioref} 			% improves cross-refs
\RequirePackage{lipsum}						% inserts filler text
\RequirePackage{xifthen}					% if/then expressions
\RequirePackage{printlen}					% displays lengths
\RequirePackage{xstring}					% handles strings functions
\RequirePackage{titling}					% better control over the title
\RequirePackage{authoraftertitle}			% accesses title and author names
\RequirePackage{datetime}					% custom date format
\RequirePackage{etoolbox}					% test if a macro value is empty
\RequirePackage{multicol}                   % switch to 2 columns
\RequirePackage{footmisc}                   % additional footnote features


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% header/footer settings
\RequirePackage{lastpage}					% computes the number of pages
\RequirePackage{fancyhdr}					% changes headers and setters
\setlength{\headheight}{16.5pt}				% increases header size
\newcommand{\pageStyleA}{
	\pagenumbering{roman}	
	\pagestyle{fancy}
	\fancyhf{}
	
	\lhead{\textcolor{gray4}{\textbf{\leftmark} }}
	\cfoot{\textcolor{black}{\thepage}}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\renewcommand\headrule{					% color and thickness of the header rule
    	{\color{black}\hrule width \hsize}}
	\renewcommand\footrule{					% color and thickness of the header rule
    	{\color{black}\hrule width \hsize} \kern 1mm}

}


\newcommand{\pageStyleB}{	
% macro initializing the headers and footers
	\pagenumbering{arabic}
	\pagestyle{fancy}
	\fancyhf{}
	
	\lhead{\textcolor{gray4}{\textbf{\leftmark} }}
	\cfoot{\textcolor{black}{\thepage}}
	\renewcommand{\headrulewidth}{0.4pt}
	\renewcommand{\footrulewidth}{0.4pt}
	\renewcommand\headrule{					% color and thickness of the header rule
    	{\color{black}\hrule width \hsize}}
	\renewcommand\footrule{					% color and thickness of the header rule
    	{\color{black}\hrule width \hsize} \kern 1mm}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% color settings
\RequirePackage{luacolor}                       % prevent color changes at page breaks
%\let\normalcolor\relax						    % prevent automatic restoration to black >> but also sometimes causes table text to be completely colored
\RequirePackage{ceri/sty/tabularray}
\DefTblrTemplate{caption-tag}{normal}{Table\hspace{0.25em}\thetable}
\DefTblrTemplate{contfoot-text}{default}{Suite à la page suivante}
\DefTblrTemplate{conthead-text}{default}{(Suite)}
\DefTblrTemplate{note-text}{default}{\footnotesize\InsertTblrNoteText}

%\RequirePackage[table]{xcolor}% define custom colors
\RequirePackage{ceri/sty/ninecolors}
\NineColors{saturation=high}
\definecolor{fgRed}{RGB}{233,82,70}			    % headers and hyperlinks
\definecolor{fgDarkRed}{RGB}{91,27,22}          % text color in console (draft mode)
\definecolor{fgDarkerRed}{RGB}{51,8,6}          % background color in console
\definecolor{fgLightRed}{RGB}{241,167,159}      % table header rows
\definecolor{fgVeryLightRed}{RGB}{248,226,224}  % table normal rows
\definecolor{fgYellow}{RGB}{250,165,25}
\definecolor{fgDeepRed}{RGB}{238,42,36}
\definecolor{fgLightYellow}{RGB}{229,208,66}
\definecolor{bgLightGray}{RGB}{235,235,235}
\definecolor{chambray}{RGB}{58, 83, 155}
\definecolor{chestnut}{RGB}{246, 71, 71}
\definecolor{solitude}{RGB}{228, 233, 237}
\definecolor{hoki}{RGB}{103, 128, 159}
\definecolor{alice}{RGB}{228, 241, 254}
\definecolor{gallery}{RGB}{238, 238, 238}
\definecolor{humming}{RGB}{197, 239, 247}
\definecolor{arkevia-btn-border}{HTML}{a3d7de}
\definecolor{arkevia-btn-bg}{HTML}{1aa1b4}
\definecolor{arkevia-btn-bg2}{HTML}{453659}
% pseudocode background
%
\definecolor{LightGrey}{rgb}{0.96,0.96,0.96}    % title page
\definecolor{DarkGrey}{rgb}{0.83,0.83,0.83}
\definecolor{BaseColor}{rgb}{0.64,0.69,0.31}
% cegedim activities
\definecolor{actBlue}{RGB}{37,68,147}
\definecolor{actGreen}{RGB}{2,149,141}
\definecolor{actPink}{RGB}{227,16,110}
\definecolor{actPurple}{RGB}{127,59,143}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% notes
\usepackage%[disable]
	{todonotes}
\setlength {\marginparwidth }{2cm}%31%
\newcommand{\noteVL}[1]{\todo[color=red!40, author=\textbbf{Hamza Talaghzi}, inline]{#1}}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hyperlinks settings
\RequirePackage[
	bookmarks=true, bookmarksnumbered=true, bookmarksopen=true,
	unicode=true, colorlinks=true, linktoc=all, %linktoc=page
	linkcolor=chambray, citecolor=chambray, filecolor=chambray, urlcolor=chambray,
	pdfstartview=FitH, 
	pdfkeywords={spring, batch, processing, sirh, ged},
    pdfencoding=auto    % avoid encoding problems in PDF bookmarks (French)
]{hyperref}									% enables hyperlinks
\RequirePackage{url}						% properly displays urls
% deals with problem in PDF properties
\makeatletter
\pdfstringdefDisableCommands{%
  \def\\{}%
  \def\hbox{}%
  \def\mathsurround{}%
  \def\z@{0}%
  \def\@@underline{}%
  \def\textsuperscript#1{}%
  \def\texttt#1{<#1>}%
}
\makeatother
% check this: https://tex.stackexchange.com/questions/306988/automatically-add-texorpdfstring-for-math-mode-in-section-titles


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% table settings
\RequirePackage{multirow}						% cells spanning several rows
\newcommand{\HRule}{\rule{\linewidth}{0.5mm}}	% thicker line for the tables
\RequirePackage{tabularx} 						% for larger tables
\newcolumntype{L}{>{$}l<{$}}                    % math-mode version of "l" column type (tabularx)
\newcolumntype{R}{>{$}r<{$}}                    % math-mode version of "r" column type (tabularx)
\RequirePackage{array}							% extends table and array functions
% Macro by A. Kassi 							% don't remember what this is for...
% http://www.ukonline.be/programmation/latex/tutoriel/chapitre4/page2.php
\makeatletter
	\def\hlinewd#1{
	\noalign{\ifnum0=`}\fi\hrule \@height #1
	\futurelet\reserved@a\@xhline}
\makeatother
% end macro
\RequirePackage{csvsimple}						% populates table with file content



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% forms settings
\newcommand{\square}[1]{\tikz{\filldraw[draw=#1,fill=#1] (0,0) rectangle (0.6em,0.6em);}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bibliographic settings
%\RequirePackage[numbers]{natbib}		% incompatible with biblatex
\RequirePackage{doi}					% displays DOIs in the bibliography
\RequirePackage[autostyle]{csquotes}	% don't remember why I put this
\RequirePackage[
	maxcitenames=2,						% two authors max in the text (only for author-year)
	maxbibnames=99,						% list all authors in the reference list
	style=numeric,						% numeric style for reference list
	citestyle=numeric-comp,				% numeric style for citations
%	style=authoryear,					% NOTE: if you want the author-year style instead,
%	citestyle=authoryear-comp,			% uncomment these 2 lines and comment both ones above
%	backref=true,						% includes a page backlink in the reference list
%	dashed=false,						% displays all author names (only for authoryear)
    datamodel=ceri/sty/hal_id,          % prints custom hal-id fields
    backend=biber                       % uses biber to compile (instead of bibtex)
]
{biblatex}								% uses biblatex (instead of bibtex)
%\renewcommand*{\bibfont}				% changes font size for biblio
%		{\footnotesize} 				
\newcommand{\bibName}{Bibliographie}	% define bibliography header
\AtEveryCite{\restorecommand\mkbibnamefamily}	% avoid small caps in citations (French)
\setlength\bibitemsep{0.9\itemsep}		% reduce space between bibliographic items
% command to insert the bibliography
	\newcommand{\MyBibliography}{					% receives the bibtex file
		\newpage
		\phantomsection
		\addcontentsline{toc}{section}{\bibName}	% add the bibliography in the TOC
		{	\setstretch{0.8}
       		\printbibliography
		}
		\thispagestyle{fancy}						% force header/footer
	}
% specific commands for HAL ids
\DeclareFieldFormat{hal}{%
    \ifhyperref
    {$\langle$\href{https://hal.archives-ouvertes.fr/#1}{\nolinkurl{#1}}$\rangle$}
    {$\langle$\nolinkurl{#1}$rlangle$}
}
\DeclareFieldAlias{eprint:hal}{hal}
\DeclareFieldAlias{eprint:HAL}{eprint:hal}
\renewbibmacro*{eprint}{%
    \printfield{hal}%
    \newunit\newblock
    \iffieldundef{eprinttype}
    {\printfield{eprint}}
    {\printfield[eprint:\strfield{eprinttype}]{eprint}}
}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caption settings
\RequirePackage{caption}					% caption customization
\captionsetup{
	labelfont={color=chambray, bf, small},	% font(sf), color, bold, size of the caption label
	textfont={small},						% font(sf) and size of the caption text itself
	labelsep=period,						% separator between label and text
	margin=10mm								% left/right margins
}
\usepackage{amsmath}
\numberwithin{table}{section}
\numberwithin{figure}{section}
\DeclareCaptionType{fileText}[Fichier][Liste de fichiers]
\DeclareCaptionType{consoleText}[Console][Liste de sorties console]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom floats
\RequirePackage{subcaption}                 % handles subfloats
\RequirePackage{float}	 					% custom floats environments
%\RequirePackage{tocloft}	 				% list of custom float objects
% prevents vertical centering when only floats on the last page
\makeatletter
\setlength{\@fptop}{0pt}    
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom equations
\makeatletter								% change equation numbers
\def\tagform@#1{\maketag@@@{(\color{fgRed}\textbbf{#1}\normalcolor)\@@italiccorr}}
\makeatother


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom algorithms
\RequirePackage[							% environment for pseudo code
    french,									% language in the caption (default: English)
    ruled,									% boxed, ruled (shaded in v5.3)
    linesnumbered,							% add line numbers
    longend,								% block-specific end keyword
    procnumbered							% functions/procedures must be numbered
]{ceri/sty/algorithm2e}							% Overleaf does not have the latest version installed
\SetAlCapFnt{\color{fgRed}}				% change caption font (in algorithm floats)
\SetProcFnt{\color{fgRed}}				% change caption font (in function/procedure floats)
% keep the caption below 
% (see https://tex.stackexchange.com/questions/27671/algorithm2e-with-ruled-but-with-caption-underneath)
% and also shaded background
% (see https://tex.stackexchange.com/questions/375669/apply-background-color-in-algorithm2e-but-not-on-the-caption)
\makeatletter                       
\newenvironment{algorithm2e}[1][htpb]
{   \def\@algocf@pre@ruled{%
        \setlength{\OuterFrameSep}{0pt}
	    \setlength{\FrameSep}{1mm}
    	\colorlet{shadecolor}{bgLightGray}
        \begin{shaded}}%
    \def\@algocf@post@ruled{\end{shaded}\relax}%   % without horizontal separator
%    \def\@algocf@post@ruled{\end{shaded}\kern\interspacealgoruled\hrule  height\algoheightrule\kern3pt\relax}%           	% with horizontal separator
    \def\@algocf@capt@ruled{under}%
    \begin{algorithm}[#1]}
  {\end{algorithm}}
\makeatother
\setlength\algotitleheightrule{0pt} 		% remove the last rule (below the caption)
\newcommand{\mycaptfrmt}[1]{\parbox{\linewidth}{\centerline{#1}}}
%\SetAlgoCaptionLayout{mycaptfrmt}   		% center the caption (see open TODO task) >> see https://tex.stackexchange.com/questions/173776/algorithm2e-and-hanging-captions
\SetAlgoCaptionSeparator{\unskip.}          % use dot as the separator in captions


%%%%%%%%%%%%%%%%%%%%%%%%%
% bullet list
%\renewcommand{\labelitemi}{$\bullet$}
\renewcommand{\FrenchLabelItem}         % use bullets even in French
    {\raisebox{-0.4\height}{\scalebox{2}{\textbullet}}}
\RequirePackage{enumitem}				% gives more control over lists
\setlist{nosep}						% changes spacing between list items


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom section headers
\RequirePackage{titlesec}

\titleformat{\section}
{\color{chambray}\normalfont\Large\bfseries}
{\setlength\fboxsep{17pt}%
  \colorbox{chambray}{%
    \parbox{85pt}{\centering \color{white} Chapitre \thesection}}
}
{1em}
{}


\titleformat{\subsection}
	{\color{chestnut}\normalfont\large\bfseries}
    {\thesubsection}
    {1em}
    {}
\titleformat{\subsubsection}
	{\color{chestnut}\normalfont\normalsize\bfseries}
    {\thesubsubsection}
    {1em}
    {}
\makeatletter
\newcommand\subsubsubsection{\@startsection{paragraph}{4}{\z@}{-2.5ex\@plus -1ex \@minus -.25ex}{1.25ex \@plus .25ex}{\color{chestnut}\normalfont\normalsize\bfseries}}
\newcommand\subsubsubsubsection{\@startsection{subparagraph}{5}{\z@}{-2.5ex\@plus -1ex \@minus -.25ex}{1.25ex \@plus .25ex}{\color{chestnut}\normalfont\normalsize\bfseries}}
\makeatother
\setcounter{secnumdepth}{5}				% number subsubsections
\setcounter{tocdepth}{4}				% and include them in the TOC
% NOTE: only (?) for the report class
%	\RequirePackage{chngcntr}			% defines specific counters
%	\counterwithout{section}{chapter}	% hide the chapter number in section headings


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom paragraphs
\renewcommand{\paragraph}[1]{
	\par\vspace{0.15cm}
	\phantomsection
    \IfEndWith{\thesection}{0}{
    	\addcontentsline{toc}{section}{#1}
    }{\IfEndWith{\thesubsection}{.0}{
    	\addcontentsline{toc}{subsection}{#1}
    	}{\IfEndWith{\thesubsubsection}{.0}{
    		\addcontentsline{toc}{subsubsection}{#1}
    		}{\addcontentsline{toc}{paragraph}{#1}}
        }
    }
    \noindent
    \textbbf{#1}\hspace{0.1cm}
} 
\newcommand{\paragraphe}[1]{
	\par\vspace{0.15cm}
    \noindent
    \textbbf{#1.}\hspace{0.1cm}
} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom remark frames
\usepackage[most]{tcolorbox}
\newtcolorbox{beware}[1][]{%
  enhanced jigsaw, % better frame drawing
  borderline west={5pt}{0pt}{red}, % straight vertical line at the left edge
  sharp corners, % No rounded corners
  boxrule=0pt, % no real frame,
  coltitle={red},  % Black colour for title
  fonttitle=\bfseries,
  title={},  % Fixed title
  attach title to upper, % Move the title into the box
  #1
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% custom listings
\RequirePackage{listings}						% format source code
% \RequirePackage{lstlinebgrd}					% change background color - does not work anymore (v3.8.14)
\definecolor{colKeywords}{RGB}{127,0,85}		% keyword color
\definecolor{colComments}{RGB}{77,109,141}		% comment color
\definecolor{colStrings} {RGB}{42,0,255}		% string literal color
\definecolor{colLstHL}{RGB}{255,255,153}		% highlight color
\definecolor{colNumber}{rgb}{0.50,0.50,0.50}	% line number color
\definecolor{mauve}{rgb}{0.58,0.00,0.82}
\lstset{
%	frame=tb,									% frame around the source code
	aboveskip=1mm,								% space before the source code
	belowskip=1mm,								% space after the source code
	showstringspaces=false,						% display space char as underscore
	columns=flexible,
    captionpos=b,                               % position of the caption (t or b)
	basicstyle={\small\ttfamily\NoAutoSpacing},
	keywordstyle=\color{colKeywords},			% set keyword color
	commentstyle=\color{colComments},			% set comment color
	stringstyle=\color{colStrings},				% set string literal color
    backgroundcolor=\color{white},		% set background color
	numbers=left,								% line numbering: left, none
	numberstyle=\tiny\color{colNumber},			% line number format
	breaklines=true,
	rulecolor=\color{chambray},							
	breakatwhitespace=true,						
	tabsize=3,									% size of tabulation (in chars)
	upquote=true,                               % straight quote character (' instead of ’)
    literate=%
		{à}{{\`a}}1
        {À}{{\`A}}1
        {á}{{\'a}}1
        {Á}{{\'A}}1
		{â}{{\^a}}1
        {Â}{{\^A}}1
        {ä}{{\"a}}1
        {Ä}{{\"A}}1
        {å}{{\r a}}1
        {Å}{{\r A}}1
        {æ}{{\ae}}1
        {Æ}{{\AE}}1
		{ç}{{\c{c}}}1
        {Ç}{{\c{C}}}1
		{é}{{\'e}}1
        {É}{{\'E}}1
		{è}{{\`e}}1
        {È}{{\`E}}1
		{ë}{{\"e}}1
        {Ë}{{\"E}}1
		{ê}{{\^e}}1
        {Ê}{{\^E}}1
        {í}{{\'i}}1
        {Í}{{\'I}}1
        {ì}{{\`i}}1
        {Ì}{{\`I}}1
		{ï}{{\"i}}1
        {Ï}{{\"I}}1
		{î}{{\^i}}1
        {Î}{{\^I}}1
        {ñ}{{\~n}}1
        {Ñ}{{\~N}}1
        {ó}{{\'o}}1
        {Ó}{{\'O}}1
        {ò}{{\`o}}1
        {Ò}{{\`O}}1
		{ö}{{\"o}}1
        {Ö}{{\"O}}1
		{ô}{{\^o}}1
        {Ö}{{\^O}}1
        {ő}{{\H{o}}}1
        {Ő}{{\H{O}}}1
        {ø}{{\o}}1
        {œ}{{\oe}}1
        {Œ}{{\OE}}1
        {ß}{{\ss}}1
        {ú}{{\'u}}1
        {Ú}{{\'U}}1
		{ù}{{\`u}}1
        {Ù}{{\`U}}1
		{ü}{{\"u}}1
        {Ü}{{\"U}}1
		{û}{{\^u}}1
        {Û}{{\^U}}1
        {ű}{{\H{u}}}1
        {Ű}{{\H{U}}}1
        {€}{{\euro}}1 
        {£}{{\pounds}}1 
        {«}{{\guillemotleft}}1
        {»}{{\guillemotright}}1 
        {¿}{{?`}}1
}
% this is just to be able to mention the listings environments... in latex listings environments
\lstnewenvironment{TeXlstlisting}{\lstset{language=Java,numbers=none}}{}
\RequirePackage{ceri/sty/lstcustom}
\lstdefinestyle{DOS}
{
    backgroundcolor=\color{white!90!gray},
    basicstyle=\scriptsize\color{gray1},
	keywordstyle=\color{blue},
	stringstyle=\color{gray1},
	rulecolor=\color{gray},	
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% typewriter-type environments
\RequirePackage{framed}
\pgfkeys{
 /filetext/.is family, /filetext,
 caption/.estore in = \filetextCaption,
 label/.estore in = \filetextLabel,
}
\makeatletter
\newenvironment{filetext}[1][]
{	\def\tmp{#1}%
    \pgfkeys{/filetext,#1}
    \setlength{\OuterFrameSep}{0pt}						% no frame around the text
	\setlength{\FrameSep}{1mm}							% just a bit of colored space around the text
    \colorlet{shadecolor}{fgVeryLightRed}               % background color to display files
	\begin{shaded}\begin{raggedright}\captionsetup{type=fileText}\small\ttfamily}
{\end{raggedright}\end{shaded}\par%
%\ifx\tmp\@nnil{\relax}\else{\vspace{-0.25cm}\captionof{fileText}{\filetextCaption}\vspace{0.25cm}\label{\filetextLabel}}\fi
\ifthenelse{\equal{\tmp}{}}{}{\vspace{-0.25cm}\captionof{fileText}{\filetextCaption}\vspace{0.25cm}\label{\filetextLabel}}
    
}
\makeatother
\pgfkeys{
 /consoletext/.is family, /consoletext,
 caption/.estore in = \consoletextCaption,
 label/.estore in = \consoletextLabel,
}
\makeatletter
\newenvironment{consoletext}[1][]
{	\def\tmp{#1}%
    \pgfkeys{/consoletext,#1}
    \setlength{\OuterFrameSep}{0pt}						% no frame around the text
	\setlength{\FrameSep}{1mm}							% just a bit of colored space around the text
    \colorlet{shadecolor}{fgDarkerRed}                % background color to display console
	\begin{shaded}\begin{raggedright}\captionsetup{type=consoleText}\small\ttfamily\color{fgVeryLightRed}}
{\end{raggedright}\end{shaded}\par%
%\ifx\tmp\@nnil{\relax}\else{\vspace{-0.25cm}\captionof{consoleText}{\consoletextCaption}\vspace{0.25cm}\label{\consoletextLabel}}\fi
\ifthenelse{\equal{\tmp}{}}{}{\vspace{-0.25cm}\captionof{consoleText}{\consoletextCaption}\vspace{0.25cm}\label{\consoletextLabel}}
}
\makeatother
\RequirePackage{textcomp}                               % for the \textquotesingle command (straight single quotes in \texttt)




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% names of the specialized tables of content
\newcommand{\tocName}{Sommaire}									% define TOC header
\addto\captionsfrench{\renewcommand{\contentsname}{\tocName}}	% change TOC header
\newcommand{\lofName}{Liste des figures}						% define LOF header
%\renewcommand{\listfigurename}{\lofName}						% change LOF header (1)
\addto\captionsfrench{\renewcommand{\listfigurename}{\lofName}}	% change LOF header (2)
\newcommand{\lotName}{Liste des tables}							% define LOT header
%\renewcommand{\listtablename}{\lotName}						% change LOT header (1)
\addto\captionsfrench{\renewcommand{\listtablename}{\lotName}}	% change LOT header (2)
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% specialized tables of content
\newcommand{\MyToc}{
	\phantomsection
	\addcontentsline{toc}{section}{\tocName}	% add the TOC in the TOC (yes! for PDF bookmarks)
	\tableofcontents							% insert TOC
	%\thispagestyle{fancy}						% force header/footer
	\newpage
}
\newcommand{\MyLof}{
	\phantomsection
	\addcontentsline{toc}{section}{\lofName}	% add the LOF in the TOC
	\listoffigures								% insert LOF
	\newpage
}
\newcommand{\MyLot}{
	\phantomsection
	\addcontentsline{toc}{section}{\lotName}	% add the LOT in the TOC
	\listoftables								% insert LOT
	\newpage
}		


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{pdfpages}
\usetikzlibrary{trees, shadows.blur}
% regular title page
\newcommand{\maketitleZ}{
	% setup PDF doc info
	\hypersetup{
    	pdftitle={\ifdefined\MyTitle \MyTitle \else \fi},
	   	pdfauthor={\ifdefined\MyAuthor \MyAuthor \else \fi}
	}
	
	% custom headers and footers
	\pageStyleA
	%\includepdf[pages={1}]{images/cover-pfe@07112021.pdf}
	%\thispagestyle{fancy}	% force header/footer
	\newpage
		\include{cover}
	    \include{avant-propos}
		\include{remerciements}	
		%\include{resume}
		%\include{abstract}
		
	% insert ToC
	\MyToc
	
}
\renewcommand{\maketitle}{\maketitleZ}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% handles the "full" option
\DeclareOption{full}{%
	\renewcommand{\maketitle}
	{	\maketitleZ
    	% Insert list of figures
		\MyLof
		% Insert list of tables
		\MyLot
	}
}

\ProcessOptions
