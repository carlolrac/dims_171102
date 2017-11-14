#!/usr/local/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

my ($land,$telvw,@daten,$i,$landlett);
my $z=0;
my ($ordner)="../daten";

print <<"HTML";
Content-type: text/html\n\n
<html>
<head>
<title> internationale Telefonvorwahlen </title>

<meta name="description"    	  content="TBRSE2 Database">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz\@airbus.com">
<meta name="DC.Date.Create" 	  content="2004-01-21T14:58+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2008-05-15T17:24+0:00">
<meta name="Version"   	 	  content="1">

</head>
<body  bgcolor="#99FF99">
<table align="center" border="1" width="50%" bordercolor="#000000" cellspacing="0" cellpadding="5">
<tr><td width="15" bgcolor=\"#C0C0C0\"><br>
HTML

foreach $i("A".."M") {
	 print"<b><a href=\"../bin/telvwint.pl?landlett=$i\">$i</a></b><br><br>";
	}
print "</td><td bgcolor=\"#AAAAAA\">";

$landlett=param('landlett');

chdir ($ordner);
open(TELVW,"telvwint.txt");
@daten=<TELVW>;
close TELVW;

if ($landlett)  {
	foreach (@daten)  {
		if (uc($landlett) eq uc(substr($_,0,1))) {
			($land,$telvw) = split(/\t/,$_);
			chomp($telvw);
			if ($telvw)  {
				$z++;
				print "<table align=\"center\" border=\"0\" width=\"300\" cellspacing=\"0\" cellpadding=\"0\">";
			        print "<colgroup><col width=\"200\"><col width=\"50\"></colgroup>";
				if ($z%2==0) {
					print"<tr><td bgcolor=\"#C0C0C0\">&nbsp;$land</td>";
					print"<td align=\"right\" bgcolor=\"#C0C0C0\">+$telvw&nbsp;</td></tr>"
					}
				else  {
					print"<tr><td bgcolor=\"#E0E0E0\">&nbsp;$land</td>";
					print"<td align=\"right\" bgcolor=\"#E0E0E0\">+$telvw&nbsp;</td></tr>"
					}
				}
			}
		}
	}
elsif (not($landlett))  {
	print "<table align=\"center\" border=\"0\" width=\"700\" cellspacing=\"0\" cellpadding=\"0\">";
	print "<tr><td><h1 align=\"center\"> Liste der internationalen Telefonvorwahlen </h1><br><br>";
	print "<h3 align=\"center\">+++ an den Seiten auf entsprechenden Anfangsbuchstaben klicken +++";
	print "<br><br> <b><span style=\"color:red\">Achtung:</span></b> Die Länder sind in englischer Sprache 
		verzeichnet <br>(z.B.: Hungary anstatt Ungarn) </h3></td></tr>";
	} 

print"</table></td><td width=\"15\" bgcolor=\"#C0C0C0\"><br>";
foreach $i("N".."Z") {
	($i ne "X") and print"<b><a href=\"../bin/telvwint.pl?landlett=$i\">$i</a></b><br><br>";
	}

print <<"END";
</td></tr>
</table>
</body>
</html>
END
