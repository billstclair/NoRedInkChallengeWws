----------------------------------------------------------------------
--
-- Stylesheet.elm
-- A CSS string for a page stylesheet
-- Copyright (c) 2017 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE.txt
--
----------------------------------------------------------------------

module Stylesheet exposing ( stylesheet )

stylesheet : String
stylesheet =
    """
body {
    margin: 5em auto 5em auto;
    width: 40em;
    height: 50em;
    border: 1px solid DeepSkyBlue;
    padding : 1em;
}
.centered {
        text-align: center;
}
h1 {
    margin-bottom: 0;
    text-align: center;
}
a {
    text-decoration: none;
}
h3 {
    margin-top: 0;
    text-align: center;
    font-style: italic;
}
a:link, a:visited {
    color: DeepSkyBlue;
}
a:hover {
    text-decoration: underline;
}
a:active {
    text-decoration: underline;
    color: LightSkyBlue;
}
table.page {
    width: 100%;
    border: 1px solid DeepSkyBlue;
    padding : 1em;
}
table td {
    vertical-align: top;
}
td.sidebar {
    width: 4em;
    padding-right: 0.5em;
    padding-top: 3em;
}
div.footer {
    margin-top: 1em;
    text-align: center;
}
iframe {
    width: 100%;
    height: 30em;
    margin: 0;
}
table.bordered {
    margin: 0em 0.5em 0.5em 0.5em;
    background: whitesmoke;
    border-collapse: collapse;
}
table.bordered th, table.bordered td {
    border: 1px silver solid;
    padding: 0.2em;
}
table.bordered td {
    text-align: center
}
table.bordered th {
    background: gainsboro;
    text-align: center;
}
table.bordered caption {
  margin-left: inherit;
  margin-right: inherit;
}
table.innertable th, table.innertable td {
  border: 0;
}
pre {
    width: 40em;
}
div.rendered {
    width: 32em;
}
pre, div.rendered {
    overflow: auto;
    margin-left: 0;
    padding: 0.5em;
    border: 1px solid black;
    background-color: GhostWhite;
}
    """
