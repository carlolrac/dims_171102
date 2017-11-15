#!/usr/local/bin/perl -w
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

my (@input,@daten,@werte,$i,$z,$input,$k,$woher,@woher,$l,$m,@datum,$datum);
my ($ordner)="/opt/app-root/src/daten/BCRS12";

$k=0;
$woher=param('woher');
@datum = localtime(time);
$datum[0] <=9 and $datum[0]="0".$datum[0];
$datum[1] <=9 and $datum[1]="0".$datum[1];
$datum[2] <=9 and $datum[2]="0".$datum[2];
$datum[3] <=9 and $datum[3]="0".$datum[3];
$datum[4] = $datum[4]+1;
$datum[4] <=9 and $datum[4]="0".$datum[4];
$datum[5] = $datum[5]+1900;
$datum=$datum[3]."\.".$datum[4]."\.".$datum[5]."\.".$datum[2]."\.".$datum[1]."\.".$datum[0];

@input=(param('aufruf'),param('kw'));
foreach (@input)  { s/^\s+//; s/\s+$//;  }

chdir ($ordner);
open(STAT,"stat01.txt");
@daten = <STAT>;
close STAT;

if($daten[0]) {
	chomp $daten[0];
	@woher = split(/\t/,$daten[0]);
	}

$l=0;
if($daten[0]) {
	for ($k=0; $k<=$#woher; $k++)  {
		chomp($woher[$k]);
		$woher eq $woher[$k] and  $l=$k+1;
		}
	}
if (not($daten[0]))  {
	$daten[0]=$woher;
	$l=$#woher+6;
	}
elsif ($l==0) {
	$daten[0]=$daten[0]."\t".$woher;
	$l=$#woher+6;
	}
else  { 
	$l=$l+4; 
	}
$k=$k+4;
$i=0;
for ($z=1; $z<=$#daten; $z++)  {
	$daten[$z] and @werte = split(/\t/, $daten[$z]);
	for ($m=5; $m<=$k; $m++)  {
		$werte[$m] and chomp($werte[$m]);
		$werte[$m] ||="0";
		}
	if ($werte[0] eq $input[0] && $werte[1] eq $input[1]) {
		$i++;
		$werte[4]++;
		$werte[$l]++;
		$werte[3]=$datum;
		}
	$werte[0] ||= 0;
	$werte[1] ||= 0;
	$werte[2] ||= 0;
	$werte[3] ||= 0;
	$werte[4] ||= 0;
	$werte[0] and $daten[$z]=join("\t", @werte);
	}

if ($i==0)  {
	$input[4]="1";
	$input[2]=$datum;
	$input[3]=$datum;
	for ($m=5; $m<$k; $m++)  {
		$input[$m] and chomp($input[$m]);
		$input[$m] ||="0";
		}
	$input[$l]="1";
	$input = join("\t",@input);
	push(@daten, $input);
	}

chomp (@daten);
open(STAT,">stat01.txt");
foreach (@daten)  { print STAT "$_\n"; }
close STAT;
		
print <<"JAVA";
Content-type: text/html\n\n
<html>
<head>
<title>Statistik, die erste</title>

<meta name="description"    	  content="TBRSE2 Database">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@assystem-germany.com, lofant\@web.de">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  content="Markus Fritz, Markus.Fritz\@airbus.com">
<meta name="DC.Date.Create" 	  content="2004-11-17T13:44+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2008">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilung TBRSE22, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2008-05-15T18:53+0:00">
<meta name="Version"   	 	  content="1">

<script type="text/javascript">
<!--
function closeIt1() {
  window.setTimeout("closeIt2();", 500);
  }
function closeIt2() {
  window.close();
  }
// -->
</script>
</head>
<body onLoad="closeIt1()">
<p>&nbsp;</p>
</body>
</html>
JAVA
