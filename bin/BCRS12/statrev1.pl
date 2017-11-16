#!/usr/local/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

my (@daten,$user,@user,$acc,@werte,$i);
my ($ordner)="/opt/app-root/src/daten/BCRS12";

chdir ($ordner);
open(STAT,"stat01.txt");
@daten=<STAT>;
close STAT;

chomp ($daten[1]);
@user = split(/\t/, $daten[0]);
$user = $#user+1;
$acc = 0;
for ($i=1; $i<=$#daten; $i++)  {
	@werte = split(/\t/, $daten[$i]);
	$werte[4] and $acc = $acc+$werte[4];
	}

print <<"HTML";
Content-type: text/html\n\n
<html>
<head>
<title>Statistik der Datenbank (Beginn 06.09.2005)</title>

<meta name="description"    	  content="TBRSE2 Database">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz\@airbus.com">
<meta name="DC.Date.Create" 	  content="2004-12-13T23:38+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2008-05-15T19:03+0:00">
<meta name="Version"   	 	  content="1">

</head>
<body bgcolor="#c0c0c0"><br>
<h1 align="center"> Statistik der Datenbank </h1>
<br><br>
<h3 align="center">aktuelle Z&auml;hlung (seit: 03.03.2009)</h3>
<br>
<table align="center" width="50%" border="1">
<tr><td><b>Anzahl der Zugriffe (auf ein Stichwort):</b></td><td align="right"> $acc </td></tr>
<tr><td><b>Anzahl der User:</b></td><td align="right"> $user </td></tr>
</table>
<br><br>

<h3 align="center">Serverumzug am 03.03.2009</h3>

<br><h3 align="center">(vom: 19.05.2008 bis zum: 02.03.2009)</h3>
<table align="center" width="50%" border="1">
<tr><td><b>Anzahl der Zugriffe (auf ein Stichwort):</b></td><td align="right"> 8250 </td></tr>
<tr><td><b>Anzahl der User:</b></td><td align="right"> 141 </td></tr>
</table>

<br>
<h3 align="center">(vom: 10.11.2007 bis zum: 18.05.2008)</h3>
<table align="center" width="50%" border="1">
<tr><td><b>Anzahl der Zugriffe (auf ein Stichwort):</b></td><td align="right"> 7736 </td></tr>
<tr><td><b>Anzahl der User:</b></td><td align="right"> 136 </td></tr>
</table>

<br>
<h3 align="center">(vom: 21.06.2006 bis zum: 09.11.2007)</h3>
<table align="center" width="50%" border="1">
<tr><td><b>Anzahl der Zugriffe (auf ein Stichwort):</b></td><td align="right"> 28507 </td></tr>
<tr><td><b>Anzahl der User:</b></td><td align="right"> 123 </td></tr>
</table>

<br>
<h3 align="center">(vom: 06.09.2005 bis zum: 20.03.2006)</h3>
<table align="center" width="50%" border="1">
<tr><td><b>Anzahl der Zugriffe (auf ein Stichwort):</b></td><td align="right"> 7800 </td></tr>
<tr><td><b>Anzahl der User:</b></td><td align="right"> 118 </td></tr>
</table>
</body>
</html>
HTML
