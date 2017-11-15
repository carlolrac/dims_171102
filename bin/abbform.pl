#!/usr/local/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

print <<"HTML";
Content-type: text/html\n\n
<html>
<head>
<title>abbreviations-Suchformular</title>
<meta name="description"    	  content="TBRSE2 Database">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	content="Markus Fritz, Markus.Fritz\@airbus.com">
<meta name="DC.Date.Create" 	content="2003-09-24T12:34+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2008-05-15T17:43+0:00">
<meta name="Version"   	 	  content="1">
<link rel="stylesheet" type="text/css" href="../css/form1.css">
<script src="../scripts/airlcoge.js" type="text/javascript"></script>
</head>
<body bgcolor="#E0E0E0">

<form action="../bin/abbrev.pl" target="result" method="get">

<!--Eingabeformular für Abkürzung-->
<div style="position:absolute; top:10px; left:10px;">
<p class="abk"> Abk&uuml;rzung: <input size="8" name="abbrev"><br></p>
</div>

<div style="position:absolute; top:70px; left:10px;">
<input type="submit" class="but6" value="Suchen"><br>
</div>

<div style="position:absolute; top:105px; left:10px;">
<input type="submit" class="but5" name="alle" value="Alle anzeigen"><br>
</div>

</form>

<div style="position:absolute; top:410px; left:10px;">
<input type="button" class="but5" value="Neuer Eintrag" onClick="LogInp('abbrinp.pl')"><br>
</div>

<!--div style="position:absolute; top:530px; left:10px;">
<!--p style=\"font-family:Arial; font-size:11px; font-weight:bold;\"><nobr><a href="../download/AP2080_Module_3.pdf" target="result">weitere Abk&uuml;rzungen</a></nobr></p>
<!--/div//-->

</body>
</html>

HTML
