#!/usr/local/bin/perl -w
package zugmstrd;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(ZugMstrD);

#print <<"HTML";
#<!--meta name="description"      content="DIMS">
#<meta name="robots"         	  content="no index">
#<meta name="keywords"         	  content="">
#<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@iconstructltd.com">
#<meta http-equiv="content-type"  content="text/html; charset=ISO-8859-1">
#<meta name="DC.Contributor" 	  content="Falkmar Platz, Falkmar.Platz\@airbus.com">
#<meta name="DC.Date.Create" 	  content="2006-03-21T01:05+0:00">
#<meta name="DC.Language"    	  content="de">
#<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2011">
#<meta name="DC.Warranty"         content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#				           Inhalte sind Eigentum der Abteilung TBCES11, Airbus Hamburg">
#<meta name="DC.LastChange"  	  content="2011-09-02T19:37+0:00">
#<meta name="Version"   	  content="1"//-->
#HTML

sub ZugMstrD  {

	my $g=shift;
	my $h=shift;
	not($g) || $g eq "1" and $g="";
	not($h) || $h eq "1" and $h="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS12";

	chdir ($ordner);
	open(ACC,"accmstrd.txt");
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
			if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ )  {
				for ($i=1; $i<=$#daten; $i++)  {
					$daten[$i] =~ s/\s+$//;
					$tmp2=$_;
					$tmp2 =~ s/\s/\|/;
					$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					}
				}
			last if ($g && $h && $_ =~ /$g/ && $_ =~ /$h/ );
			}
		}

	if (not($w)) {
	}
	
return $w;
}

1;

