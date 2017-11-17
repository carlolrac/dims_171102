#!/usr/bin/env perl
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

#use FindBin;
#use lib $FindBin::Bin;
use zug7;

#!<meta name="description"    	  content="TBRSE2 Database">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt/@assystem-germany.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz/@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2003-09-24T15:51+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung TBRSE2, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2008-04-07T11:10+0:00">
#!<meta name="Version"   	  content="1">

my ($abbrev, $mean, $transrem, $zeile,$ok);

my ($ordner)="/opt/app-root/src/daten";
$abbrev=param('abbrev');
$mean=param('mean');
$transrem=param('transrem');

print <<"HTML";
Content-type: text/html\n\n
<html><head><title>Eingabe einer neuen Abkürzung</title></head>
<body bgcolor="#c0c0c0">
HTML

$abbrev and print "<script> alert('$abbrev');</script>";
$mean and print "<script> alert('$mean');</script>";
$transrem and print "<script> alert('$transrem');</script>";

print "<script> alert('hallo');";

my $g = param('a');
my $h = param('b');
#my ($w) = Zug7($g,$h);
my $w = "test";
if($w) {

print "<br><br><h1 align=\"center\"> Abk&uuml;rzungen - neue Eingabe </h1><br><br>";

if (not($abbrev)) {

	print <<"EOM";
	<table border="0"> <colgroup> <col width="30%"> </colgroup>
	<form method="post">
	<tr><td></td><td>
	<b>Abk&uuml;rzung:<br>
	<input name="abbrev" size="8"><br><br>
	Bedeutung:<br>
	<input name="mean" size="80"><br><br>
	Übersetzung/Anmerkung:</b><br>
	<input name="transrem" size="80"><br><br><br>
	<input type="hidden" name="a" value="$g">
	<input type="hidden" name="b" value="$h">
	<input type="submit" value="Speichern">
	</td></tr>
	</form>
	</table>
EOM
	}
else 	{
	chdir ($ordner);
	$ok=open(ABBREV,"<abbrev.txt");
	close ABBREV;
	if ($ok) {
		open(ABBREV,">>abbrev.txt");
		$zeile = ($abbrev)."\t".$mean."\t".$transrem."\n";
#		$zeile =~ s/ä/&auml;/g;
#		$zeile =~ s/ö/&ouml;/g;
#		$zeile =~ s/ü/&uuml;/g;
#		$zeile =~ s/Ä/&Auml;/g;
#		$zeile =~ s/Ö/&Ouml;/g;
#		$zeile =~ s/Ü/&Uuml;/g;
#		$zeile =~ s/ß/&szlig;/g;
		print ABBREV "$zeile";
		close ABBREV;
		print "<br><br><br><p align=\"center\"> <b>Die Eingabe wurde gespeichert und kann nun in der Datenbank abgerufen werden.</b> </p>\n";
		print '<div align="center">',"\n";
		print '<br><br><br><form action="../html/abbfram.html"> <input type="submit" value="zurück zur Suche"> </form>',"\n";
		print '</div>',"\n";
		}
	else   {
		print "<br><br><br><p align=\"center\"> <b>Datei nicht gefunden +++ Bitte eine email an 
			<a href=mailto:Markus.Fritz\@airbus.com> Markus </a> schicken.</b> </p>\n";
		print '<div align="center">',"\n";
		print '<br><br><br><form action="../html/abbfram.html"> <input type="submit" value="zurück zur Suche">'; 
		print "<input type=\"hidden\" name=\"a\" value=\"$g\">";
		print "<input type=\"hidden\" name=\"b\" value=\"$h\">";
		print "</form>";
		print '</div>',"\n";
		}
	}
}

print "</body></html>";
