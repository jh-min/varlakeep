{smcl}
{* *! version 1.2  5August2019}{...}

{title:Title}

{phang}{bf:varlakeep} {hline 2} Program to keep specified variables and corresponding value labels only


{marker syntax}{...}
{title:Syntax}

{p 8 17 2}
	{cmd:varlakeep} {varlist}
	[{cmd:,} {it:options}]


{synoptset 20 tabbed}{...}
{synopthdr}
{synoptline}
{syntab:Main}
{synopt:{opth m:issing(#)}}drop variables and corresponding value labels whose all observations are equal to {it:#}; can be combined with {opt up} or {opt down}{p_end}
{synopt:{opt up}}drop variables and corresponding value labels whose all observations are greater than or equal to the number assigned by {opth missing(#)}{p_end}
{synopt:{opt down}}drop variables and corresponding value labels whose all observations are less than or equal to the number assigned by {opth missing(#)}{p_end}
{synopt:{opth obs:ervation(exp)}}keep observations that satisfy the condition {it:{help exp}}; can be combined with {opt drop}{p_end}
{synopt:{opt d:rop}}drop observations that satisfy the condition specified by {opth obs(exp)}{p_end}
{synopt:{opt novar:iables}}apply {cmd:varlakeep} to just value labels not variables{p_end}
{synoptline}
{p2colreset}{...}
{p 4 6 2}
{opth missing(#)}, {opt up} or {opt down} may not be combined with {opt novariables}.{p_end}
{p 4 6 2}
{opt up} may not be combined with {opt down}.{p_end}
{p 4 6 2}
If {opt novariables} is not set, {cmd:varlakeep} drops variables and value labels whose all observations are equal to missing (.) regardless of {opth missing(#)}.{p_end}


{marker description}{...}
{title:Description}

{pstd}
	{cmd:varlakeep} provides a convenient way to {cmd:keep} variables and corresponding value labels when variable names are specified by {varlist}.
	{cmd:varlakeep} applies to variables and value labels the same way that the {cmd:keep} command applies to variables.
	Also, it is possible to apply {cmd:varlakeep} to just value labels not variables by the option {opt novariables} (in this case, you should still specify the variable name that corresponds to the value label that you want to keep).

{pstd}
	If the option {opt novariables} is not set, i.e., by default, {cmd:varlakeep} can interpret specific value or interval as missing (.) as well.
	For example, suppose variables in your data were coded as follows: {it:INAPPLICABLE} as {it:-1} and {it:DK} as {it:-8}.
	If you want to drop variables and corresponding value labels whose all observations are equal to either -1 or -8,
	just type: {cmd:varlakeep varlist} , {opt m(-1)} {opt down}.
	Then {cmd:varlakeep} drops all variables and corresponding value labels whose all observations are less than or equal to {it:-1}.
	The option {opt up} combined with option {opth missing(#)} works similarly.
	Also, {cmd:varlakeep} drops variables and corresponding value labels whose all observations are equal to missing (.) whether or not you set the option {opth missing(#)}.

{pstd}
	Moreover, {cmd:varlakeep} can keep or drop observations that satisfy specified condition.
	The option {opth obs(exp)} specifies the condition under which observations are to be kept or dropped.
	The default is to keep observations that satisfy the condition specified by {opth obs(exp)},
	and to drop observations that satisfy the same condition when the option {opt drop} is set.


{marker examples}{...}
{title:Examples}

{phang}{cmd:. varlakeep varlist , novar}{p_end}

{phang}{cmd:. varlakeep varlist}{p_end}

{phang}{cmd:. varlakeep varlist , obs(YEAR==2016)}{p_end}

{phang}{cmd:. varlakeep varlist , m(-1) down}{p_end}

{phang}{cmd:. varlakeep varlist , m(-1) down obs(YEAR!=2016) d}{p_end}


{marker author}{...}
{title:Author}

{pstd}
	{browse "https://jhmin.weebly.com":JeongHoon Min}, Sogang University, plus1@sogang.ac.kr

