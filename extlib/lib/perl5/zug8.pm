#!/usr/local/bin/perl -w
package zug8;
use strict;
use warnings;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(Zug8);

#!<meta name="description"    	  content="TBRSE2 Database">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt@assystem-germany.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2005-07-09T2:59+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung TBRSE2, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2008-04-07T11:21+0:00">
#!<meta name="Version"   	  content="1">

sub Zug8  {
	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten";
	
	chdir ($ordner);
	open(ACC,"access7.txt");
	@daten=<ACC>;
	close ACC;

	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;
	@log=reverse(@log);

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);

#print <<HTML
#print "<script>alert('hallo');</script>";
#print "$g -- $h -- $_<br>";
#HTML

	if ($daten[0] =~ /$check/)  {
		foreach (@log) {
#print "<script>alert('$g -- $h -- $_');</script>";
#print "$g -- $h -- $_<br>";
			if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				$tmp2=$_;
				$tmp2 =~ s/\s/\|/;
				for ($i=1; $i<=$#daten; $i++)  {
					#chomp($daten[$i]);
					$daten[$i] =~ s/\s+$//;

					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			last if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ );
			}
		}

	if (not($w)) {
#		print <<HTML
#		<div align="center">
#		<br><br><br><br><br>
#		<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilungen ECRS11 und ECRS12 zur Verf&uuml;gung !</h3><br><br>
#		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
#		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
#		</div>
#HTML
	}
	
return $w;
}

1;
