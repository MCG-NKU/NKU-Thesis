% -*- coding: utf-8 -*-

\NeedsTeXFormat{LaTeX2e}

\ProvidesPackage{NKThesis}[2016/10/12]

\LoadClass[12pt,openright]{book}


\RequirePackage{silence}
\hbadness=10000 \vbadness=10000 \vfuzz=30pt \hfuzz=30pt
\WarningFilter{latexfont}{Some font}
\WarningFilter{hyperref}{Token not}


\def\cleardoublepage{
\clearpage
\if@twoside
  \ifodd\c@page
  \else
    \hbox{}
    \thispagestyle{empty}
    \newpage
    \if@twocolumn
      \hbox{}
      \thispagestyle{empty}
      \newpage
    \fi
  \fi
\fi}

\newif\if@NKT@English
\DeclareOption{English}{\@NKT@Englishtrue}

\ProcessOptions\relax

\def\jiacu{\special{pdf: literal direct q 0.2 w 2 Tr}\aftergroup\jiacuu}
\def\jiacuu{\special{pdf: literal 0 Tr}}

\newcommand{\myPara}[1]{\vspace{.2in} \noindent\textbf{#1}\quad}

\RequirePackage[unicode,bookmarksnumbered,colorlinks=true,linkcolor=black]{hyperref}


\ifxetex
  \RequirePackage{xeCJK}
  \edef\CJK@UnicodeEnc{UTF8}
  %\def\CJKaddEncHook#1#2{\expandafter\def\csname xeCJK@enc@#1\endcsname{#2}}
  \def\Unicode#1#2{\@tempcnta#1\relax
    \multiply\@tempcnta 256\relax
    \advance\@tempcnta#2\relax
    \char\@tempcnta}
  \RequirePackage{CJKnumb}
  \csname xeCJK@enc@UTF8\endcsname
  \def\CJK@tenthousand{万}
  \RequirePackage{graphicx}
  \RequirePackage{xpatch}
  \ExplSyntaxOn
  \xpatchcmd \fontspec_new_script:nn
    { \__fontspec_warning:nxx }
    { \__fontspec_info:nxx }
    {}{\fail}
    \newfontscript{CJK}{hani} % redeclare
  \ExplSyntaxOff
\else
  \RequirePackage{CJK,CJKnumb}
  \RequirePackage{uniGBK}
%  \RequirePackage{CJKpunct}\RequirePackage{CJKspace}
  \AtBeginDocument{\begin{CJK*}{UTF8}{rm}}
  \AtEndDocument{\newpage\end{CJK*}}
  %\usepackage[pdftex]{graphicx}
  \RequirePackage{graphicx}
  \def\jiacu{\pdfliteral{q 0.2 w 2 Tr}\aftergroup\jiacuu}
  \def\jiacuu{\pdfliteral{0 Tr}}
  \CJK@makeActive
  \DeclareRobustCommand\rmfamily
    {\not@math@alphabet\rmfamily\mathrm
     \fontfamily\rmdefault\CJKfamily{rm}\selectfont}

  \DeclareRobustCommand\sffamily
    {\not@math@alphabet\sffamily\mathsf
     \fontfamily\sfdefault\CJKfamily{sf}\selectfont}

  \DeclareRobustCommand\ttfamily
    {\not@math@alphabet\ttfamily\mathtt
     \fontfamily\ttdefault\CJKfamily{tt}\selectfont}
  \input{zhwinfonts.tex}
\fi

\if@NKT@English
  \def\chaptername{Chapter \arabic{chapter}}
  \def\thesection{\arabic{chapter}.\arabic{section}}
  \def\thesubsection{\arabic{chapter}.\arabic{section}.\arabic{subsection}}
  \def\contentsname{CONTENTS}
  \def\appendixnamenonumber{Appendix}
  \renewcommand{\bibname}{References}
  \def\tablename{Table}
  \def\figurename{Figure}
  \def\NKT@proof{Proof}
\else
  \def\chaptername{第\CJKnumber{\arabic{chapter}}章}
  %\def\chaptername{第\arabic{chapter}章}
  %\def\thesection{第\CJKnumber{\arabic{section}}节}
  \def\thesection{\arabic{chapter}.\arabic{section}}
  \def\thesubsection{\arabic{chapter}.\arabic{section}.\arabic{subsection}}
  \def\contentsname{目录}
  \def\appendixnamenonumber{附录}
  \renewcommand{\bibname}{参考文献}
  \def\tablename{表}
  \def\figurename{图}
  \def\NKT@proof{证明}
\fi

\RequirePackage{silence}
\hbadness=10000 \vbadness=10000 \vfuzz=30pt \hfuzz=30pt
\WarningFilter{latexfont}{Font shape}

\RequirePackage{mathptmx}
\DeclareMathAlphabet{\mathcal}{OMS}{cmsy}{m}{n}

\def\songti{\rmfamily\upshape}
\def\heiti{\bfseries}
\def\kaiti{\itshape}
\def\fangsong{\ttfamily}
\let\kai\kaiti
\let\song\songti
\let\hei\heiti
\let\fs\fangsong
\punctstyle{quanjiao}

\endlinechar \m@ne
\newif\if@tocline
\@toclinetrue

\newif\if@firstappendix
\@firstappendixtrue

\newdimen\NKTtemp@dim@a

\def\theequation{\arabic{chapter}.\arabic{equation}}
\@addtoreset{equation}{chapter}

\def\@sect#1#2#3#4#5#6[#7]#8{%
  \ifnum #2>\c@secnumdepth
    \let\@svsec\@empty
  \else
    \refstepcounter{#1}%
    \protected@edef\@svsec{\@seccntformat{#1}\relax}%
  \fi
  \@tempskipa #5\relax
  \ifdim \@tempskipa>\z@
    \begingroup
     #6{%
       \@hangfrom{\csname #1special\endcsname\hskip #3\relax\@svsec}%
          \interlinepenalty \@M \csname #1special\endcsname#8\@@par}%
    \endgroup
    \csname #1mark\endcsname{#7}%
    \addcontentsline{toc}{#1}{%
      \ifnum #2>\c@secnumdepth \else
        \protect\numberline{\csname the#1\endcsname}%
      \fi
      #7}%
  \else
    \def\@svsechd{%
      #6{\hskip #3\relax
      \@svsec #8}%
      \csname #1mark\endcsname{#7}%
      \addcontentsline{toc}{#1}{%
        \ifnum #2>\c@secnumdepth \else
          \protect\numberline{\csname the#1\endcsname}%
        \fi
        #7}}%
  \fi
  \@xsect{#5}}

\def\@seccntformat#1{\csname the#1\endcsname\quad}

\def\section{
  \@startsection{section}{1}{\z@}{24pt}{6pt}{\sectionformat} }

\def\subsection{
  \@startsection{subsection}{2}{\z@}{12pt}{6pt}{\subsectionformat}}

\def\subsubsection{
  \@startsection{subsubsection}{3}{\z@}{12pt}{6pt}{\subsubsectionformat}}

\def\sectionspecial{\jiacu}
%\def\partformat{\centering\huge\bfseries}
\def\chapterformat{\centering\fontsize{16}{19}\bfseries\jiacu}
%\def\chapterformat{\fontsize{16}{19}\bfseries\jiacu}
\def\sectionformat{\bfseries\zihaosi}
\def\subsectionformat{\bfseries\fontsize{13}{15}\selectfont}
\def\subsubsectionformat{\bfseries\zihaowu}


\def\chapter{
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \global\@topnum\z@
  \secdef\@chapter\@schapter}

\newif\if@NKT@firstchatper
\@NKT@firstchatpertrue

\def\@chapter[#1]#2{%
  \if@NKT@firstchatper
    \arabicpagenumber
    \@NKT@firstchatperfalse
  \fi
  \ifnum \c@secnumdepth >\m@ne
    \if@mainmatter
      \refstepcounter{chapter}%
      \if@NKT@English\else
        \protected@edef\@currentlabel
          {\csname p@chapter\endcsname\chaptername}%
      \fi
      \typeout{\@chapapp\space\thechapter.}%
      \addcontentsline{toc}{chapter}%
      {\protect\numberline{\chaptername}#1}% By Wenchang Sun
    \else
      \addcontentsline{toc}{chapter}{#1}%
    \fi
  \else
    \addcontentsline{toc}{chapter}{#1}%
  \fi
  \chaptermark{#1}%
  \addtocontents{lof}{\protect\addvspace{10\p@}}%
  \addtocontents{lot}{\protect\addvspace{10\p@}}%
  \if@twocolumn
    \@topnewpage[\@makechapterhead{#2}]%
  \else
    \@makechapterhead{#2}%
    \@afterheading
    \@nobreakfalse
  \fi}

\def\@makechapterhead#1{%
  \vspace*{\overchapterspace}%
  \vbox to \chpaterheaderheight{%
    \vss{\parindent \z@ \raggedright \normalfont
      \ifnum \c@secnumdepth >\m@ne
        \if@mainmatter
          \chapterformat %\@chapapp\space \thechapter
          \chaptername \hskip\chapternamesep
          %\par\nobreak
          %\vskip 20\p@
        \fi
      \fi
      \interlinepenalty\@M
      \chapterformat #1\par\nobreak}%
    \vss}%
  \vspace*{\belowchapterspace}}

\def\@schapter#1{%
  \if@twocolumn
    \@topnewpage[\@makeschapterhead{#1}]%
  \else
    \@makeschapterhead{#1}%
    \@afterheading
    \@nobreakfalse
  \fi
  \if@tocline
    \addcontentsline{toc}{chapter}{\protect\numberline{#1}{}}%
  \fi
  \markboth{#1}{#1}}

\def\@makeschapterhead#1{%
  \vspace*{\overchapterspace}%
  \vbox to \chpaterheaderheight{
    \vss{\parindent \z@ \raggedright
      \normalfont
      \interlinepenalty\@M
      \chapterformat  #1\par\nobreak}
    \vss}
  \vspace*{\belowchapterspace}}

%   table of contents
%
%
\renewcommand\tableofcontents{%
  \NKTtemp@dim@a\baselineskip
  \if@twocolumn
    \@restonecoltrue\onecolumn
  \else
    \@restonecolfalse
  \fi
  {\@toclinefalse\chapter*{\contentsname}}
  \@starttoc{toc}%
  \if@restonecol
    \twocolumn
  \fi
  \baselineskip\NKTtemp@dim@a}

\newdimen\npnumwidth
 \newdimen\tocchaptertitlewidth
 \newdimen\tocsectiontitlewidth
 \newdimen\tocsubsectiontitlewidth

\if@NKT@English
  \tocchaptertitlewidth 60pt
  \tocsectiontitlewidth 36pt
  \tocsubsectiontitlewidth 60pt
\else
  \tocchaptertitlewidth 42pt
  \tocsectiontitlewidth 42pt
  \tocsubsectiontitlewidth 60pt
\fi

\def\l@part#1#2{
  \addpenalty{\@secpenalty}
  \addvspace{\csname NKT@toc@over@part\endcsname}%
  \@tempdima 1.5em\begingroup%
  \hfil\tocpartfonts #1\hfil
  \par\endgroup
  \addvspace{\csname NKT@toc@below@part\endcsname}}


\def\l@subsection{\NKT@dottedline{subsection}}
\def\l@section{\NKT@dottedline{section}}
\def\l@chapter{\NKT@dottedline{chapter}}

\def\NKT@dottedline#1#2#3{
 {\addpenalty{\@secpenalty}
  \addvspace{\csname NKT@toc@over@#1\endcsname}%
  \begingroup
    \csname toc#1fonts\endcsname
    \parindent \csname toc#1indent\endcsname
    \rightskip \@pnumwidth
    \parfillskip -\@pnumwidth
    \leavevmode
    \leftskip\csname toc#1indent\endcsname
    \advance\leftskip\csname toc#1titlewidth\endcsname
    \advance\leftskip\toctitlesep
    \hskip -\leftskip
    \setnewwidth{#1}{#2}\nobreak\hfil\settowidth\npnumwidth{#3}%
    \nobreak\leaders\hbox{\tocleaders}%
    \hfill\nobreak\settowidth\npnumwidth{#3}%
    \hbox to\npnumwidth{\hfil #3}%
    \par
  \endgroup
  \addvspace{\csname NKT@toc@below@#1\endcsname}}}



\newdimen\NKT@tempdim

\def\setnewwidth#1{
  \def\numberline{\csname NKT#1numberline\endcsname}}

\def\NKTchapternumberline#1{
  \NKT@settoctitlewidth{chapter}{#1}
  \hbox to \NKT@tempdim{#1\hfil}\hskip \toctitlesep}

\def\NKTsectionnumberline#1{
  \NKT@settoctitlewidth{section}{#1}
  \hbox to \NKT@tempdim{\hfil #1}\hskip \toctitlesep}

\def\NKTsubsectionnumberline#1{
  \NKT@settoctitlewidth{subsection}{#1}
  \hbox to \NKT@tempdim{\hfil #1}\hskip \toctitlesep}

\def\NKT@settoctitlewidth#1#2{
  \settowidth\NKT@tempdim{#2}
  \ifdim\NKT@tempdim<\csname toc#1titlewidth\endcsname
    \NKT@tempdim =\csname toc#1titlewidth\endcsname
  \fi}

\def\tocdepth#1{
  \ifcase #1
      \def\tableofcontents{}
      \renewcommand{\l@chapter}[2]{}
      \renewcommand{\l@section}[2]{}
      \renewcommand{\l@subsection}[2]{}
  \or \renewcommand{\l@section}[2]{}
      \renewcommand{\l@subsection}[2]{}
  \or \renewcommand{\l@subsection}[2]{}
  \fi}



% page style
%
%
\def\sethead#1{
  \def\@oddhead{#1}
  \if@twoside
    \def\@evenhead{#1}
  \fi}

\if@twoside
  \def\ps@centerheadings{
    \let\@mkboth\markboth
    \def\@oddfoot{{\small\hfil  \thepage \hfil}}
    \def\@evenfoot{{\small\hfil  \thepage \hfil}}
    \def\setevenhead{\def\@evenhead{\protect\rule[-5pt]{\textwidth}{0.5pt}\hspace{-\textwidth}
     \headingfonts\hfil  \leftmark\hfil}}
    \sethead{\protect\rule[-5pt]{\textwidth}{0.5pt}\hspace{-\textwidth}
    \headingfonts \hfil \rightmark \hfil }
    \def\chaptermark##1{
      \markboth{\chaptername \ \  ##1}{\chaptername \ \  ##1}}
    \def\sectionmark##1{}}

    \def\ps@plain{
      \let\@mkboth\markboth
      \def\@oddfoot{{\small\hfil $\cdot$\, \thepage \, $\cdot$\hfil}}
      \def\@evenfoot{{\small\hfil $\cdot$\, \thepage \, $\cdot$\hfil}}
      \sethead{}}
\else
  \def\ps@centerheadings{
    \let\@mkboth\markboth
    \def\@oddfoot{{\small\hfil $\cdot$\, \thepage \, $\cdot$\hfil}}
    \sethead{\protect\rule[-5pt]{\textwidth}{0.5pt}\hspace{-\textwidth}
    \headingfonts \hfil\rightmark\hfil  }
     \def\chaptermark##1{
     \markright{
       \ifnum \c@secnumdepth >\m@ne
         \if@mainmatter
           \chaptername \ \ %
         \fi
       \fi
       ##1}}
    \def\sectionmark##1{}
    \def\subsectionmark##1{}}

  \def\ps@plain{
     \let\@mkboth\markboth
     \def\@oddfoot{{\small\hfil $\cdot$\, \thepage \, $\cdot$\hfil}}
     \def\@evenfoot{{\small\hfil $\cdot$\, \thepage \, $\cdot$\hfil}}
     \def\@evenhead{}
     \sethead{}}
\fi

\def\headingfonts{\rmfamily\zihaowu}
\def\thesisname{}

\def\thefigure{\thechapter.\arabic{figure}}
\def\thetable{\thechapter.\arabic{table}}
\@addtoreset{figure}{chapter}
\@addtoreset{table}{chapter}

\long\def\@caption#1[#2]#3{%
  \par
  \addcontentsline{\csname ext@#1\endcsname}{#1}%
    {\protect\numberline{\csname the#1\endcsname}{\ignorespaces #2}}%
  \begingroup
    \@parboxrestore
    \if@minipage
      \@setminipage
    \fi
    \normalsize
    \@makecaption[#1]{\csname fnum@#1\endcsname}{\ignorespaces #3}\par
  \endgroup}

\long\def\@makecaption[#1]#2#3{%
  \vskip\abovecaptionskip
  \sbox\@tempboxa{\zihaowu #2\hskip\NK@captionsep #3}%
  \ifdim \wd\@tempboxa >\hsize
    {\zihaowu #2\hskip\NK@captionsep #3}\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\csname belowcaptionskip@#1\endcsname}

\def\c@sihao@pt{14}
\def\c@xiaosihao@pt{12}
\def\c@wuhao@pt{10.5}
\def\c@xiaowuhao@pt{9}
\def\c@liuhao@pt{7.5}

\def\NKT@definezihao#1#2#3{
  \def#1{\fontsize{#2}{#3}\selectfont}}

\NKT@definezihao{\zihaochu}{42}{50}
\NKT@definezihao{\zihaoxiaochu}{36}{44}
\NKT@definezihao{\zihaoyi}{28}{34}
\NKT@definezihao{\zihaoer}{22}{26}
\NKT@definezihao{\zihaoxiaoer}{18}{22}
\NKT@definezihao{\zihaosan}{15.7}{19}
\NKT@definezihao{\zihaosi}{14}{17}
\NKT@definezihao{\zihaoxiaosi}{12}{14}
\NKT@definezihao{\zihaowu}{10.5}{12}
\NKT@definezihao{\zihaoxiaowu}{9}{11}
\NKT@definezihao{\zihaoliu}{7.875}{9}
\NKT@definezihao{\zihaoqi}{5.25}{6}

\def\figurenote#1{\zihaoxiaowu #1}

\renewenvironment{thebibliography}[1]{
  \chapter*{\bibname}%
  \list{\@biblabel{\@arabic\c@enumiv}}%
       {\settowidth\labelwidth{\@biblabel{#1}}%
        \leftmargin\labelwidth
        \advance\leftmargin\labelsep
        \@openbib@code
        \usecounter{enumiv}%
        \let\p@enumiv\@empty
        \renewcommand\theenumiv{\@arabic\c@enumiv}}%
  \sloppy
  \clubpenalty4000
  \@clubpenalty \clubpenalty
  \widowpenalty4000%
  \sfcode`\.\@m}
  {\def\@noitemerr{
     \@latex@warning{Empty `thebibliography' environment}}%
   \endlist}

\def\appendix{
  \if@firstappendix
     \setcounter{chapter}{0}%
     \setcounter{section}{0}%
     \renewcommand\@chapapp{Appendix}
     \typeout{....\AppendicesTotal...}
     \ifnum\AppendicesTotal=1
         \renewcommand\chaptername{\appendixnamenonumber}
     \else
         \renewcommand\chaptername{\appendixname}
     \fi
     \@firstappendixfalse
  \fi
  \chapter}%

\def\AppendicesTotal{0}

\def\AppendicesNumber#1{\gdef\AppendicesTotal{#1}}

\AtEndDocument{
  \if@firstappendix
  \else
    \immediate\write\@auxout{\string\AppendicesNumber{\thechapter}}
  \fi}

\def\arabicpagenumber{
  \setcounter{page}{1}
  \def\thepage{\arabic{page}}}

\def\thepage{\Roman{page}}

\def\sectionname{\thesection}
\def\subsectionname{\thesubsection}


\newcount\NKT@itemcnt
\NKT@itemcnt=0

\def\standardpageset{
  \paperwidth 210mm
  \paperheight 297mm
  \textheight 220mm
  \textwidth 146mm
  \oddsidemargin 32mm
  \advance\oddsidemargin -1in
  \evensidemargin \oddsidemargin
  \topmargin 38mm
  \advance \topmargin -1in
  \advance \topmargin -\headsep
  \advance \topmargin -\headheight
  \relax}
\standardpageset

\def\overchapterspace{24pt}
\def\belowchapterspace{18pt}

\def\chapternamesep{5mm}
\def\chpaterheaderheight{16pt}

\def\tocpartfonts{\rmfamily\zihaosi}
\def\tocchapterfonts{\rmfamily\zihaosi}
\def\tocsectionfonts{\rmfamily\zihaoxiaosi}
\def\tocsubsectionfonts{\rmfamily\zihaowu}
\def\tocleaders{$\cdot\!\cdot\!\cdot\ $}
\def\tocchapterindent{0em}
\def\tocsectionindent{2em}
\def\tocsubsectionindent{2em}
\def\toctitlesep{12pt}
\def\NKT@toc@over@part{12pt}
\def\NKT@toc@below@part{6pt}
\def\NKT@toc@over@chapter{6pt}
\def\NKT@toc@below@chapter{0pt}
\def\NKT@toc@over@section{6pt}
\def\NKT@toc@below@section{0pt}
\def\NKT@toc@over@subsection{6pt}
\def\NKT@toc@below@subsection{0pt}

\def\NK@captionsep{1em}

\setlength\abovecaptionskip{6\p@}
\setlength\belowcaptionskip{\p@}

\def\abovecaptionskip@figure{0\p@}
\def\belowcaptionskip@table{6\p@}
\def\belowcaptionskip@figure{12\p@}

\AtBeginDocument{
  \fontsize{12}{20}\selectfont
%  \baselineskip 20pt %
  \parindent 2em}

%
%  论文基本信息
%
\def\NKT@definekey#1#2{
  \define@key{NKT}{#1}{
    \expandafter\def\csname NKT@key@#2\endcsname{##1}}}

\csname CJK@makeInactive\endcsname
\def\NKT@string@boshi{博士}
\def\NKT@string@xuelishuoshi{硕士}
\def\NKT@string@zhuanyeshuoshi{专业硕士}
\def\NKT@string@zhuanyeboshi{专业博士}
\def\NKT@string@benke{本科}

\NKT@definekey{论文题目(中文)}      {lunwentimuzh}
\NKT@definekey{副标题}              {fubiaoti}
\NKT@definekey{论文题目(英文)}      {lunwentimuy}
\NKT@definekey{论文作者}            {lunwenzuozhe}
\NKT@definekey{学号}                {xuehao}
\NKT@definekey{指导教师}            {zhidaojiaoshi}
\NKT@definekey{申请学位}            {shenqingxuewei}
\NKT@definekey{培养单位}            {peiyangdanwei}
\NKT@definekey{学科专业}            {xuekezhuanye}
\NKT@definekey{研究方向}            {yanjiufangxiang}
\NKT@definekey{中图分类号}          {zhongtufenleihao}
\NKT@definekey{UDC}                 {UDC}
\NKT@definekey{学校代码}            {xuexiaodaima}
\NKT@definekey{密级}                {miji}
\NKT@definekey{保密期限}            {baomiqixian}
\NKT@definekey{审批表编号}          {shenpibiaobianhao}
\NKT@definekey{评阅人}             {pingyueren}
\NKT@definekey{答辩委员会主席}       {zhuxi}
\NKT@definekey{批准日期}            {pizhunriqi}
\NKT@definekey{论文完成时间}        {lunwenwanchengshijian}
\NKT@definekey{答辩日期}            {dabianriqi}
\NKT@definekey{论文类别}            {lunwenleibie}
%\NKT@definekey{学院(单位)}            {yuanxisuo}
\NKT@definekey{专业}                {zhuanye}
\NKT@definekey{联系电话}            {lianxidianhua}
\NKT@definekey{Email}               {Email}
\NKT@definekey{通讯地址(邮编)}      {tongxundizhi}
\NKT@definekey{备注}                {beizhu}
\NKT@definekey{是否批准为非公开论文}{shifougongkai}

\csname CJK@makeActive\endcsname


\def\NKT@disableCJK{%
  \ifnum\the\catcode "81=\active
    \csname CJK@makeInactive\endcsname
    \def\NKT@restoreCJK{%
      \csname CJK@makeActive\endcsname}
  \else
    \let\NKT@restoreCJK\relax
  \fi}

\def\NKTsetup{%
  \NKT@disableCJK
  \NKT@jibenxinxi}%

\endlinechar `\^^M

\def\NKT@jibenxinxi#1{%
  \bgroup
    \setkeys{NKT}{#1}%
    \NKT@restoreCJK
    \pagestyle{empty}
    \@twosidefalse
    \NKTtitlepage
    \NKTdeclaration
    \NKTauthorization    
    \clearpage
    \ifx\NKT@key@lunwenleibie\NKT@string@boshi
      \global\@twosidetrue
      \global\@mparswitchtrue
    \else
      \global\@twosidefalse
      \global\@mparswitchfalse
    \fi
  \egroup
  \setcounter{page}{1}
  \pagestyle{centerheadings}}

\def\NKT@keyvalue#1{%
  \edef\NKT@temp{\csname NKT@key@#1\endcsname}%
  \scantokens\expandafter{\NKT@temp}}

%%%%%%%%%%%%%%%%% NKThesis.cfg %%%%%%%%%%%%%%


\tocdepth{2}
\def\NKT@lunwenleibie{论文类别}
\newcommand{\proof}[1][\NKT@proof]{\par\textbf{#1.}\,\, }
\def\endproof{\hfill{\usefont{U}{msa}{m}{n}\char"03}}

\def\zhaiyao{
  \clearpage
  \vspace*{24pt}
  \centerline{\zihaoxiaoer\rmfamily\bfseries\jiacu 摘要}
  \addcontentsline{toc}{chapter}{\protect\numberline{摘要}{}}
  \markboth{摘要}{摘要} 
  \vspace*{18pt}
  \fontsize{12}{20}\selectfont}
\let\endzhaiyao\relax

\def\abstract{
  \clearpage
  \vspace*{24pt}
  \centerline{\zihaoxiaoer\usefont{OT1}{phv}{bx}{n}Abstract}
  \addcontentsline{toc}{chapter}{\protect\numberline{Abstract}{}}  
  \markboth{Abstract}{Abstract}
  \vspace*{18pt}
  \fontsize{12}{20}\selectfont}
\let\endabstract\relax


\def\symbList{
  \clearpage
  \vspace*{24pt}
  \centerline{\zihaoxiaoer\rmfamily\bfseries\jiacu 摘要}
  \addcontentsline{toc}{chapter}{\protect\numberline{摘要}{}}
  \markboth{摘要}{摘要} 
  \vspace*{18pt}
  \fontsize{12}{20}\selectfont}
\let\endsymbList\relax

\long\def\guanjianci{\par{\rmfamily\jiacu 关键词：}}
\let\endguanjianci\relax

\long\def\keywords{\par{\rmfamily\bfseries Key Words: }}
\let\endkeywords\relax


\endlinechar `\^^M

\def\NKT@declaration{
本人郑重声明：所呈交的学位论文，是本人在导师指导下进行研究工作所
取得的研究成果。除文中已经注明引用的内容外，本学位论文的研究成果不包
含任何他人创作的、已公开发表或者没有公开发表的作品的内容。对本论文所
涉及的研究工作做出贡献的其他个人和集体，均已在文中以明确方式标明。本
学位论文原创性声明的法律责任由本人承担。
}

\long\def\NKT@authorization{
本人完全了解《南开大学关于研究生学位论文收藏和利用管理办法》关于南开大学(简称“学校”)研究生学位论文收藏和利用的管理规定，同意向南开大学提交本人的学位论文电子版及相应的纸质本。

本人了解南开大学拥有在《中华人民共和国著作权法》规定范围内的学位论文使用权，同意在以下几方面向学校授权。即：

1. 学校将学位论文编入《南开大学博硕士学位论文全文数据库》，并作为资料在学校图书馆等场所提供阅览，在校园网上提供论文目录检索、文摘及前16页的浏览等信息服务；

2. 学校可以采用影印、缩印或其他复制手段保存学位论文；学校根据规定向教育部指定的收藏和存档单位提交学位论文；

3. 非公开学位论文在解密后的使用权同公开论文。 



本人承诺：本人的学位论文是在南开大学学习期间创作完成的作品，并已通过论文答辩；提交的学位论文电子版与纸质本论文的内容一致，如因不同造成不良后果由本人自负。

本人签署本授权书一份（此授权书为论文中一页），交图书馆留存。}
 

\long\def\NKTtitlepage{
  \clearpage
  \bgroup
  \parindent 0em
  \thispagestyle{empty}
  \zihaowu
  \def\arraystretch{1.5}
  \begin{tabular}{rlrl}
  中图分类号:&\hbox to 75mm{\NKT@keyvalue{zhongtufenleihao}\hfil} &学校代码:&\NKT@keyvalue{xuexiaodaima}\\
  UDC:&\NKT@keyvalue{UDC}&密级: &\NKT@keyvalue{miji}
  \end{tabular}

  \vskip 10mm
  \hskip 53mm\hbox{\includegraphics[viewport=0 0 2984 969,width=40mm]{nankaidaxue.pdf}}
  \vskip -10mm
  \begin{center}
  {\def\CJKglue{\hskip 0.5em}\zihaoer\jiacu 
     \ifx\NKT@key@lunwenleibie\NKT@string@boshi 
       博士学位论文%
     \fi
     \ifx\NKT@key@lunwenleibie\NKT@string@zhuanyeboshi 
       专业博士学位论文%
     \fi
     \ifx\NKT@key@lunwenleibie\NKT@string@xuelishuoshi 
       硕士学位论文%
     \fi
     \ifx\NKT@key@lunwenleibie\NKT@string@zhuanyeshuoshi 
       专业硕士学位论文%
     \fi
     \ifx\NKT@key@lunwenleibie\NKT@string@benke 
       本科学位论文%
     \fi
  }

  \vskip 15mm
  \zihaosan
  \baselineskip 30pt
  \vbox to 70mm{
  \NKT@keyvalue{lunwentimuzh}

  \NKT@keyvalue{fubiaoti}

  \NKT@keyvalue{lunwentimuy}
  \vss}

  \vskip 10mm
  \zihaosi
  \def\arraystretch{2}
  \tabcolsep 0.1em
  \begin{tabular}{lcl}
  \NKT@tp@item{论文作者}{lunwenzuozhe}  & \hbox to 10mm{} & \NKT@tp@item{指导教师}{zhidaojiaoshi}  \\
  \NKT@tp@item{申请学位}{shenqingxuewei}&                 & \NKT@tp@item{培养单位}{peiyangdanwei}  \\
  \NKT@tp@item{学科专业}{xuekezhuanye}  &                 & \NKT@tp@item{研究方向}{yanjiufangxiang}\\
  \NKT@tpp@item{答辩委员会主席}{zhuxi}  &                 & \NKT@tppp@item{评\hskip 0.5em 阅\hskip 0.5em人}{pingyueren}\\
 \end{tabular}

  \vskip 10mm
  \zihaosi\baselineskip 2.2em

  南开大学研究生院

  \NKT@keyvalue{lunwenwanchengshijian}
  \end{center}
  \egroup}

\def\NKT@tp@item#1#2{%
  #1%
  \hskip 0.5em%
  \underline{\hbox to 40mm{\hfil\NKT@keyvalue{#2}\hfil}}}

\def\NKT@tpp@item#1#2{%
  #1%
  \hskip 0.5em%
  \underline{\hbox to 25mm{\hfil\NKT@keyvalue{#2}\hfil}}}

\def\NKT@tppp@item#1#2{%
  #1%
  \hskip 0.5em%
  \underline{\hbox to 40mm{\hfil\NKT@keyvalue{#2}\hfil}}}

\long\def\NKTauthorization{
  \clearpage
  \@makeschapterhead{南开大学学位论文使用授权书}

  \zihaowu
  \baselineskip 19pt
  \parindent 2em
  \NKT@authorization

  \hfill 学位论文作者暨授权人(亲笔)签字：\underline{\hbox to 30mm{}}\hbox to 4em{}

  \hfill 20\qquad  年\qquad 月\qquad  日 \hbox to 2.6em{}

  \vskip 5mm

  \centerline{\zihaoxiaosi\bfseries 南开大学研究生学位论文作者信息}

  \fontsize{10.5}{10.5}\selectfont
  \def\NKT@au@item##1##2{%
    ##1%
    \edef\NKT@temp{\csname NKT@string@##2\endcsname}%
    \ifx\NKT@key@lunwenleibie\NKT@temp
      \makebox[0pt][l]{$\square$}\raisebox{.15ex}{\hspace{0.1em}$\checkmark$}%
    \else
      \makebox[10pt][l]{$\square$}\raisebox{.15ex}%
    \fi}
  \hbox to 140mm{%
  \def\arraystretch{1.8}
  \tabcolsep 0pt
  \hskip -8mm
  \begin{tabular}{|l|}
  \hline
  \hbox to 22mm{\def\CJKglue{\hskip .5em}\hss 论文题目\hss}\vrule
  \hbox to 135.7mm{\hss\NKT@keyvalue{lunwentimuzh}\hss}\\
  \hline
  \hbox to 22mm{\hss 姓\hskip 3.5em 名\hss}\vrule
  \hbox to 25mm{\hss \NKT@keyvalue{lunwenzuozhe}\hss}\vrule
  \hbox to 12mm{\hss 学号\hss}\vrule
  \hbox to 33mm{\hss \NKT@keyvalue{xuehao}\hss}\vrule
  \hbox to 22mm{\hss 答辩日期\hss}\vrule
  \hbox to 38mm{\hss \NKT@keyvalue{dabianriqi}\hss}\hss\\
  \hline
  \hbox to 22mm{\def\CJKglue{\hskip .5em}\hss 论文类别\hss}\vrule
  \hbox to 133.7mm{\hss\quad\NKT@au@item{博士}{boshi}\quad
  \NKT@au@item{硕士}{xuelishuoshi}\quad
  \NKT@au@item{专业硕士}{zhuanyeshuoshi}\quad
  \NKT@au@item{专业博士}{zhuanyeboshi}\quad
  \NKT@au@item{本科}{benke}\quad 划$\checkmark$选择\hss}\\
  \hline
  \hbox to 22mm{\def\CJKglue{\hskip .4em}\hss 学院(单位)\hss}\vrule
  \hbox to 47mm{\hss\NKT@keyvalue{peiyangdanwei}\hss}\vrule
  \hbox to 44mm{\hss 学科/专业(专业学位)名称\hss}\vrule
  \hbox to 41.5mm{\hss\NKT@keyvalue{zhuanye}\hss}\\
  \hline
  \hbox to 22mm{\def\CJKglue{\hskip .5em}\hss 联系电话\hss}\vrule
  \hbox to 47mm{\hss\NKT@keyvalue{lianxidianhua}\hss}\vrule
  \hbox to 16.5mm{\hss 电子邮箱\hss}\vrule
  \hbox to 69mm{\hss\NKT@keyvalue{Email}\hss}\\
  \hline
  \,通讯地址(邮编)：\NKT@keyvalue{tongxundizhi}\\
  \hline
  \hbox to 27mm{\hss 非公开论文编号\hss}\vrule
  \hbox to 42mm{\hss\NKT@keyvalue{shenpibiaobianhao}\hss}\vrule
  \hbox to 16.5mm{\def\CJKglue{\hskip .5em}\hss 备注\hss}\vrule
  \hbox to 40mm{\hss\NKT@keyvalue{beizhu}\hss}\\
  \hline  
  \end{tabular}\hss}

  \hbox to 140mm{%
  \fontsize{10.5}{10.5}\selectfont 
  \def\arraystretch{1.8}
  \tabcolsep 0pt
  \hskip -8mm
  \bfseries
  \begin{tabular}{ll}
  \zihaoxiaowu
   注：&\zihaoxiaowu 本授权书适用我校授予的所有博士、硕士的学位论文。如已批准为非公开学位论文，须向图书馆提供批准通过的\\
       &\zihaoxiaowu 《南开大学研究生申请非公开学位论文审批表》复印件和“非公开学位论文标注说明”页原件。
  \end{tabular}\hss}}

\long\def\NKTdeclaration{
  \clearpage
  \@makeschapterhead{南开大学学位论文原创性声明}
%  \vskip 24pt

  \fontsize{12}{24}\selectfont
  \NKT@declaration

  \vskip 5mm
  学位论文作者签名：\hskip .5em\underline{\hbox to 40mm{}}
  \hfill 年\hskip 2em 月\hskip 2em 日\hbox to 1em{}
  \setlength{\parskip}{0em}
  \noindent
  {\setlength\unitlength{1mm}
  \begin{picture}(145,1)(0,0)
  \multiput(0,0)(2,0){72}{\line(1,0){1}}
  \end{picture}}

  \centerline{\heiti\zihaosan 非公开学位论文标注说明}
  \centerline{({\kaiti\zihaoxiaosi 本页表中填写内容须打印})}
  \setlength{\parskip}{0em}
  根据南开大学有关规定，非公开学位论文须经指导教师同意、作者本人申
  请和相关部门批准方能标注。未经批准的均为公开学位论文，公开学位论文本
  说明为空白。

  \vskip 12pt
  \bgroup
  \tabcolsep 0pt
  \fontsize{12}{12}\selectfont
  \def\arraystretch{2.5}
  \noindent
  \hbox to 140mm{%
  \hskip -3mm
  \begin{tabular}{|c|l|}
  \hline
  \vbox to 10mm{\vskip 4mm\hbox to 31mm{\hfil\heiti 论文题目\hfil}\vss}
    &\hbox to 121mm{}\\
  \hline
  \heiti 申请密级 &\quad □限制(≤2年)\qquad □秘密(≤10 年)\qquad □机密(≤20年)\\
  \hline
  \heiti 保密期限 & \qquad 20\hskip 12mm 年\qquad 月 \qquad 日至20 \hskip 12mm 年\qquad 月\qquad 日\\
  \hline
  \heiti 审批表编号&\hbox to 42mm{}\vline\hbox to 24mm{\hss \heiti 批准日期\hss}\vline
    \qquad 20\qquad  年\qquad 月\qquad 日\\
  \hline
  \end{tabular}\hss}

  \vskip .5em
  \fontsize{12}{24}\selectfont
  \hfill {\heiti 南开大学学位评定委员会办公室盖章(有效)\hskip 0.5em}

  \noindent\zihaowu
  注：限制$\bigstar$ 2年(可少于2年);秘密$\bigstar$ 10年(可少于10年);机密$\bigstar$ 20年(可少于20年)
  \egroup}


%%%%%%%%%%%%%%%%% NKThesis.cfg %%%%%%%%%%%%%%



\newcommand\setpaperdimen[2]{
  \pdfpagewidth=#1 true mm
  \pdfpageheight=#2 true mm
  \relax}

\setpaperdimen{210}{297}

\let\makeschapterhead\@makeschapterhead

\def\XeLaTeX{X\kern-.1667em\lower.5ex\hbox{\reflectbox{E}}\kern-.1667em\LaTeX}

\def\XeTeX{X\kern-.1667em\lower.5ex\hbox{\reflectbox{E}}\kern-.1667em\TeX}

%
%  删除列表项之间的间隔.
\def\@listi{%
  \leftmargin\leftmargini
  \parsep 0pt%
  \topsep \parsep
  \itemsep \parsep}
\let\@listI\@listi
\@listi
\def\@listii{%
  \leftmargin\leftmarginii
  \labelwidth\leftmarginii
  \advance\labelwidth-\labelsep
  \parsep 0pt%
  \topsep \parsep
  \itemsep \parsep}
\def\@listiii{%
  \leftmargin\leftmarginiii
  \labelwidth\leftmarginiii
  \advance\labelwidth-\labelsep
  \parsep 0pt%
  \topsep \parsep
  \itemsep \parsep
  \partopsep \p@ \@plus\z@ \@minus\p@}

\def\tablecaption#1{%
  \refstepcounter{table}%
  {\zihaowu \tablename\nobreakspace\thetable\hskip\NK@captionsep #1}
  \nopagebreak
  \vskip\csname belowcaptionskip@table\endcsname
  \nopagebreak}

\def\figurecaption#1{%
  \refstepcounter{figure}%
  \nopagebreak
  \vskip\abovecaptionskip@figure
  \nopagebreak
  {\zihaowu \figurename\nobreakspace\thefigure\hskip\NK@captionsep #1}
  \vskip\belowcaptionskip@figure}

\renewcommand\enumerate[1][M]{%
  \ifnum \@enumdepth >3 %
    \@toodeep
  \else
    \advance\@enumdepth\@ne
    \edef\@enumctr{%
      enum\romannumeral\the\@enumdepth}%
    \list{%
      \csname label\@enumctr\endcsname\,}%
      {\settowidth\labelwidth{#1}%
       \leftmargin\labelwidth
       \advance\leftmargin\labelsep
       \ifnum\@enumdepth=1 %
         \advance\leftmargin\parindent
       \fi
       \usecounter{\@enumctr} %
       \listparindent\parindent
       \itemsep\z@
%       \def\makelabel##1{%
%         \mbox{##1}\hfil}%
       \def\makelabel##1{\hss\llap{##1}}}%
    \def\newblock{%
      \hskip .11em plus .33em minus .07em}%
    \sloppy\clubpenalty4000 %
    \widowpenalty4000 %
    \sfcode`\.=1000\relax
  \fi}
\let\endenumerate=\endlist


% 模板出现未知bug导致目录显示英文，以下两行为补救
\renewcommand*\contentsname{目录}
\def\chaptername{第\CJKnumber{\arabic{chapter}}章}
\renewcommand\bibname{参考文献}

\endinput
