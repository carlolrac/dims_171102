#!/usr/local/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

print <<"HTML";
Content-type: text/html\n\n
<html><head><title>Abkürzungen</title>

<meta name="description"    	  content="TBRSE2 Database">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz\@airbus.com">
<meta name="DC.Date.Create" 	  content="2003-09-24T12:40+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2008-04-18T13:43+0:00">
<meta name="Version"   	 	  content="1">

</head>
<body bgcolor=#66FF66>
<div align="center">
<br><h1 align="center"> Abk&uuml;rzungen </h1><br>
<table  border="1" bordercolor="#000000" cellspacing="0" cellpadding="5">
<colgroup><col width="10%"><col width="45%"><col width="45%"></colgroup>
HTML

my %datsort;

my $inhalt="xxx";
my ($abb,$alle,$zeilesort,@zeilesort,$i,$s,@daten,$data,@key,$key,$comp,$temp);
my ($zeile,$abbrev,$mean,$transrem,$abbrevtab,@zeile);
my $z=0;
my ($ordner)="/opt/app-root/src/daten";
$abbrev=param('abbrev');
$alle=param('alle');
not($alle) and $alle = "xxx";
chomp($abbrev);

$alle ne "xxx" and print "<tr><span style=\"font-weight:bold; font-size:15pt\"><th> Abk&uuml;rzung </th> <th> Bedeutung </th><th>
                          &Uuml;bersetzung/Anmerkung </th></span></tr>\n";

chdir ($ordner);
open(ABBREV,"abbrev.txt");
@daten = <ABBREV>;
close ABBREV;


@key = &alphasort(@daten);
$abbrev and $abbrev = &datbig($abbrev);
foreach $s (0..$#daten)  {
	$datsort{$key[$s]}=$daten[$s];
	}
@key = sort(@key);


foreach $inhalt (@key) {
	chomp($datsort{$inhalt});
	($abbrevtab, $mean, $transrem) = split(/\t/,$datsort{$inhalt});
	$mean ||="\&nbsp\;";
	$transrem ||="\&nbsp\;";
	$abbrevtab ||="\&nbsp\;";
	$abbrevtab = &vordruck($abbrevtab);
	$mean = &vordruck($mean);
	$transrem = &vordruck($transrem);
	($comp,$temp,$temp) = split(/\t/,$inhalt);
	if ($alle ne "xxx") {
		print "<tr><td> $abbrevtab </td> <td > $mean </td> <td> $transrem</td> </tr>\n";
		$z++;
		}
	elsif ($comp && $abbrev eq $comp)  {
		#$z == 1 and print '<tr><td colspan="2" style="height:5px"></td></tr>';
		print "<tr><td>Abkürzung: </td><td> <b> $abbrevtab </b></td><br>\n";
		print "<tr><td>Bedeutung: </td><td> <b> $mean </b></td><br>\n";
		print "<tr><td>&Uuml;bersetzung/Anmerkung: </td><td> <b> $transrem </b></td></tr></table><br>\n";
		print "<table  border=\"1\" bordercolor=\"#000000\" cellspacing=\"0\" cellpadding=\"5\">";
		print "<colgroup><col width=\"10%\"><col width=\"45%\"><col width=\"45%\"></colgroup>";	
		$z++;
		}
	}

print "</table></div>";	
if ($z==0)  {
	print "<br><br><br><p align=\"center\"><b>Leider kein Eintrag vorhanden<br><br>Sven hat ein Buch
		mit allen im Flugzeugbau &uuml;blichen Abk&uuml;rzungen<br><br>Bitte einen neuen Eintrag 
		anlegen <br><br><br><br>Eine vollst&auml;ndigere Liste von Abk&uuml;rzungen findet man im ";
	print "<a href=\"../download/AP2080_Module_3.pdf\">";
	print "Airbus-Abk&uuml;rzungshandbuch</a>.</b></p>";
	}
print "</body></html>\n";



sub alphasort
	{
	foreach $_ (@_) {
		$key = uc($_);
		$key =~ s/Ä/AE/g;
		$key =~ s/Ö/OE/g;
		$key =~ s/Ü/UE/g;  
		$key =~ s/ä/AE/g;
		$key =~ s/ö/OE/g;
		$key =~ s/ü/UE/g;
		$key =~ s/ß/SS/g;
		push @key, $key;
		}
	return @key;
	}


sub datbig
	{
	$key = uc($_[0]);
	$key =~ s/Ä/AE/g;
	$key =~ s/Ö/OE/g;
	$key =~ s/Ü/UE/g;  
	$key =~ s/ä/AE/g;
	$key =~ s/ö/OE/g;
	$key =~ s/ü/UE/g;
	$key =~ s/ß/SS/g;
	return $key;
	}


sub vordruck
	{
	$key = $_[0];
	$key =~ s/Ä/&Auml;/g;
	$key =~ s/Ö/&Ouml;/g;
	$key =~ s/Ü/&Uuml;/g;  
	$key =~ s/ä/&auml;/g;
	$key =~ s/ö/&ouml;/g;
	$key =~ s/ü/&uuml;/g;
	$key =~ s/ß/&szlig;/g;
	return $key;
	}
