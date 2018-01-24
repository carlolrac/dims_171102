#!/usr/local/bin/perl -w
package zug2;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(Zug2);
#sub Zug2 { };

#!<meta name="description"    	  content="BSOE32 Databench">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt/@ski-team.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz/@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2004-06-20T16:41+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  content="Rights of ideas and sourcecode are owned by the author,2003-2005">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung BSOE32, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2005-06-26T22:11+0:00">
#!<meta name="Version"   	  content="1">

sub Zug2  {
	my (@daten,$w,$pw,$pw1,$rev,$check,$i,$tmp);
	my ($ordner)="/mnt/daten";
	
	chdir ($ordner);
	open(ACC,"access4.txt");
	@daten=<ACC>;
	close ACC;

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);
	if ($daten[1] =~ /$check/)  {
		$pw = crypt(reverse($tmp),$daten[0]);
		#print $pw;
		foreach(@daten)  {
			chomp;
			$pw eq $_ and $w="access";
			} 
		}

	if (not($w)) {
		print <<HTML
		<body bgcolor="#C0C0C0">
		<div align="center">
		<br><br><br><br><br>
		<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilung BSOE32 zur Verf&uuml;gung !</h3><br><br>
		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
		</div></body>
HTML
	}
	
return $w;
}

1;

