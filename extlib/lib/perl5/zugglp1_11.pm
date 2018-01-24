#!/usr/local/bin/perl -w
package zugglp1;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(ZugGlp1);

#!<meta name="description"    	  content="TBRSE2 Database">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt@assystem-germany.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Dörte Jebens, doerte.jebens@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2006-11-16T21:49+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2008-04-07T12:55+0:00">
#!<meta name="Version"   	  content="1">

sub ZugGlp1  {

	my $g=shift;
	my $h=shift;
	not($g) || $g eq "1" and $g="";
	not($h) || $h eq "1" and $h="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS11";

	chdir ($ordner);
	open(ACC,"accglp1.txt");
	@daten=<ACC>;
	close ACC;

	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;
	@log=reverse(@log);

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);

	if ($daten[0] && $daten[0] =~ /$check/)  {
		foreach (@log) {
			if ($_ && $g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				for ($i=1; $i<=$#daten; $i++)  {
					chomp($daten[$i]);
					$tmp2=$_;
					$tmp2 =~ s/\s/\|/;
					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			last if ($_ && $g && $h && $_ =~ /$g/ && $_ =~ /$h/ );
			}
		}

	if (not($w)) {
	#	print <<HTML
	#	<body bgcolor="#C0C0C0">
	#	<div align="center">
	#	<br><br><br><br><br>
	#	<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilung BCRS12 zur Verf&uuml;gung !</h3><br><br>
	#	<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
	#	<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
	#	</div></body>
#HTML
	}
	
return $w;
}

1;

