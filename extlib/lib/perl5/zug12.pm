#!/usr/local/bin/perl -w
package zug12;					
use strict;
use vars qw(@ISA @EXPORT $VERSION);		
use Exporter;					
$VERSION = 1.00;				
@ISA     = qw(Exporter);			
@EXPORT  = qw(Zug12);				

#!<meta name="description"    	  content="TBRSE2 Database">
#!<meta name="robots"         	  content="no index">
#!<meta name="author"         	  content="Conny Schmidt, C.Schmidt@assystem-germany.com, lofant@web.de">
#!<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#!<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz@airbus.com">
#!<meta name="DC.Date.Create" 	  content="2005-07-09T2:59+0:00">
#!<meta name="DC.Language"    	  content="de">
#!<meta name="DC.Rights"	  	content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#!<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#!				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg  ">
#!<meta name="DC.LastChange"  	  content="2008-04-07T12:52+0:00">
#!<meta name="Version"   	  content="1">

sub Zug12  {

	my $g=shift;
	my $h=shift;
	not($g) || $g eq "1" and $g="";
	not($h) || $h == 1 and $h="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS12";

	$tmp=$ENV{REMOTE_ADDR};
	$check = substr($tmp,0,7);

	chdir ($ordner);
	open(ACC,"access12.txt");
	@daten=<ACC>;
	close ACC;

	#foreach (@daten) { s/^\s+//; s/\s+$//; }

	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;
	@log=reverse(@log);


	#$check = "172.17.";


	#if ($daten[0] =~ m/$check/)  {
		foreach (@log) {
			if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				$tmp2=$_;
				$tmp2 =~ s/\s/\|/;
				#my $tmp3 = $tmp2;
				#chomp($tmp3);
				for ($i=1; $i<=$#daten; $i++)  {
					#$daten[$i] && $tmp2 =~ /$daten[$i]/ and print "<script>alert('$tmp3')</script>";
					$daten[$i] =~ s/\s+$//;
					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			#last if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ );
			}
	#	}
	

	if (not($w)) {
		print <<HTML;
		<div align="center">
		<br><br><br><br><br>
		<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilung ECG5C zur Verf&uuml;gung !</h3><br><br>
		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
		</div>
HTML

		print "<script>alert('check: $check');</script>";
		my $tmp77 = $daten[0];
		$tmp77 =~ s/\s+$//;
		print "<script>alert('daten0: $tmp77');</script>";
		#print "<script>alert('daten1: $daten[1]');</script>";
		#print "<br>";
		#print "<script>alert('datenall: $#daten');</script>";
		#print "<br>";
		print "<script>alert('g: $g');</script>";
		print "<script>alert('h: $h');</script>";
		$tmp2 and print "<script>alert('tmp2: $tmp2');</script>";
		$tmp and print "<script>alert('tmp: $tmp');</script>";
		#print "<script>alert('$daten[1]');</script>";
		print "<script>alert('check: $check');</script>";


	}
	
return $w;
}

1;

