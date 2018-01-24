#!/usr/local/bin/perl -w
package zug13;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(Zug13);

#print <<"HTML";
#<!--meta name="description"	  content="DIMS">
#<meta name="robots"         	  content="no index">
#<meta name="keywords"         	  content="">
#<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@IConStructLtd.com">
#<meta http-equiv="content-type"  content="text/html; charset=ISO-8859-1">
#<meta name="DC.Contributor" 	  content="Falkmar Platz, Falkmar.Platz\@airbus.com">
#<meta name="DC.Date.Create" 	  content="2006-03-21T01:05+0:00">
#<meta name="DC.Language"    	  content="de">
#<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-indefinitely">
#<meta name="DC.Warranty"         content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#				           Inhalte sind Eigentum der Abteilung ECG1D, Airbus Hamburg">
#<meta name="DC.LastChange"  	  content="2015-09-16T19:37+0:00">
#<meta name="Version"   	  content="1"//-->
#HTML

sub Zug13  {
	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS13";
	
	chdir ($ordner);
	open(ACC,"access13.txt");
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
					$daten[$i] =~ s/\s+$//;
					$tmp2=$_;
					$tmp2 =~ s/\s/\|/;
					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			}
		}

	if (not($w)) {
		print <<HTML
		<div align="center">
		<br><br><br><br><br>
		<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilung <span style=\"color:red\">ECG1D</span> zur Verf&uuml;gung !</h3><br><br>
		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
		</div>
HTML
	}
	
return $w;
}

1;

