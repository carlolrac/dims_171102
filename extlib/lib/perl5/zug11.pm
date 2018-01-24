#!/usr/local/bin/perl -w
package zug11;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(Zug11);

#print <<"HTML";
#<!--meta name="description"    	  content="TBRSE2 Database">
#<meta name="robots"         	  content="no index">
#<meta name="keywords"         	  content="">
#<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
#<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
#<meta name="DC.Contributor" 	  content="Falkmar Platz, Falkmar.Platz\@airbus.com">
#<meta name="DC.Date.Create" 	  content="2006-03-21T01:05+0:00">
#<meta name="DC.Language"    	  content="de">
#<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
#<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#				           Inhalte sind Eigentum der Abteilung TBRSE21, Airbus Hamburg">
#<meta name="DC.LastChange"  	  content="2008-05-15T19:37+0:00">
#<meta name="Version"   	 	  content="1"//-->
#HTML

sub Zug11  {
	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS11";

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);
	
	chdir ($ordner);
	open(ACC,"access11.txt");
	@daten=<ACC>;
	close ACC;

	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;


	if ($daten[0] =~ m/$check/)  {
		foreach (@log) {
			if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				$tmp2=$_;
				$tmp2 =~ s/\s/\|/;
				$tmp2 =~ s/\s+$//;
				my $tmp3 = $tmp2;
				#chomp($tmp3);
				for ($i=1; $i<=$#daten; $i++)  {
					
					if ($daten[$i]) {
						$daten[$i] =~ s/\s+$//;
						#print "<script>alert('$daten[$i] - $tmp3')</script>";
						#$tmp2 =~ /$daten[$i]/ and print "<script>alert('$tmp3')</script>";
						if ($daten[$i] && $tmp2 =~ /$daten[$i]/) {
							$w="access";
							}
						#$tmp2 =~ /$daten[$i]/ and print "<script>alert('$tmp3')</script>";
						}
					}
				}
			#last if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ );
			}
		}

	if (not($w)) {
		print <<HTML
		<div align="center">
		<br><br><br><br><br>
		<h3>Dieser Bereich steht nur den Mitarbeitern der Abteilung <span style=\"color:red\">ECG4B</span> zur Verf&uuml;gung !</h3><br><br>
		<!--p><b><br>Passwort nicht korrekt !</b><br><br//-->
		<b><span style=\"color:red\">+ + + &nbsp;Zugang verweigert !&nbsp; + + +</span></b></p>
		</div>
HTML
	}
	
return $w;
}

1;

