#!/usr/local/bin/perl -w
package zug11;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(Zug11);

#!<meta name="description"    	  content="TBRSE2 Database">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt@assystem-germany.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2005-12-03T2:23+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung TBRSE2, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2008-04-07T12:02+0:00">
#!<meta name="Version"   	  content="1">

sub Zug11  {
	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS12";
	
	chdir ($ordner);
	open(ACC,"accessad.txt");
	@daten=<ACC>;
	close ACC;

	#chdir ($ordner);
	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);
	if ($daten[0] =~ /$check/)  {
		foreach (@log) {

			if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				for ($i=1; $i<=$#daten; $i++)  {
					chomp($daten[$i]);
					$tmp2=$_;
					$tmp2 =~ s/\s/\|/;
					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			}
		}

	if (not($w)) {
		print <<HTML
		<body bgcolor="#C0C0C0">
		<div align="center">
		<br><br><br><br><br>
		<h3>Dieser Bereich steht nur den Administratoren der Datenbank (TBRSE2) zur Verf&uuml;gung !</h3><br><br>
		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
		</div></body>
HTML
	}
	
return $w;
}

1;

