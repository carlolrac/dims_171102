#!/usr/local/bin/perl -w

use strict;
use Archive::Zip;

my $ordner = "/opt/app-root/src/daten/backup";
my $ordner2 = "/opt/app-root/src/daten/GLP2";

my @DT = localtime(time);
my (@daten,@list,@lister,@lister1,@lister2,@lister3,@bkpsold,@bkpsoldGLP);
my ($DT,$DT1,$DT2,$DT3);

print <<"HTML";
Content-type: text/html\n\n
<html>
<head>
<title>Backups and Updates</title>
<meta name="description"    	  	content="DIMS">
<meta name="robots"         	  	content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  	content="Conny Schmidt, C.Schmidt\@IConStructLtd.com">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  	content="Falkmar Platz, falkmar.platz\@airbus.com">
<meta name="DC.Date.Create" 	  	content="2009-07-18T19:16+0:00">
<meta name="DC.Language"    	  	content="de">
<meta name="DC.Rights"	  	  		content="Rights of ideas and sourcecode are owned by the author,2003-indefinitely">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           												 Inhalte sind Eigentum der Abteilung TBRSE, Airbus Hamburg">
<meta name="DC.LastChange"  	  	content="2016-04-04T12:16+0:00">
<meta name="Version"   	 	  			content="1">

<script type="text/Javascript">
<!--
function GLPupd() {
  //alert('hier');
  //document.location.href = "file://carlo7/TBCES_DB/GLPupd01.htm";
   document.location.href = "file://sfs.corp/projects/ENGINEERING/SA_SAVE_LAYOUT/TBCES_DB/GLPupd01_OS2.htm";
  }
//-->
</script>
</head>
<body bgcolor="#ABCDEF">
HTML

#chmod(0777, "../daten/backup");

if (not(-e $ordner)) { mkdir($ordner,0777); chmod(0777, $ordner); }
if (not(-e $ordner2)) { mkdir($ordner,0777); chmod(0777, $ordner2); }

if (-e $ordner) { print "folder backup exists...<br><br>"; }
else { print "folder backup does not exist...<br><br>"; }

chdir ($ordner);
##chmod(0777, "bkplist.txt");
##chmod(0777, "bkplast.txt");

my $ok1 = open(BKPL,"bkplast.txt");
if ($ok1) {
	@daten = <BKPL>;
	close BKPL;
	}
else {
	close BKPL;
	open (BKPL,">bkplast.txt");
	chmod(0777, "bkplast.txt");
	print BKPL time;
	close BKPL;
	}

if (-e "bkplast.txt") { print "file bkplast.txt exists...<br><br>"; }
else { print "file bkplast.txt does not exist...<br><br>"; }

my $fh = "../GLP/GLP.TXT";
my @Infold = stat($fh);
my $GLP_TSo = $Infold[9];

my $ZR = 24 * 60 * 60;

$DT1 = $DT[5]+1900;
$DT1 = substr($DT1,-2);
$DT2 = $DT[4]+1;
$DT2 < 10 and $DT2 = "0".$DT2;
$DT3 = $DT[3];
$DT3 < 10 and $DT3 = "0".$DT3;
$DT = $DT1.$DT2.$DT3;

my $tmptmp = time;
my $tmptmp2 = $tmptmp-$daten[0];
#print "<script>alert('$tmptmp');</script>";
#print "<script>alert('$daten[0]');</script>";
#print "<script>alert('$ZR');</script>";
#print "<script>alert('$tmptmp2');</script>";

if (not($daten[0]) || (time-$daten[0]) > $ZR) {

#print "<script>alert('hallo');</script>";

	open (BKPL,">bkplast.txt");
	print BKPL time;
	close BKPL;

	my $zipName = "BK".$DT.".zip";
	my $zip = Archive::Zip->new();
	chmod(0777, "BK".$DT.".zip");

	my $ok2 = open(BKPLI,"bkplist.txt");
	if ($ok2) {
		@lister = <BKPLI>;
		close BKPLI;
		}
	else {
		close BKPLI;
		@lister = (map { glob } "../*.txt");	
		@lister1 = (map { glob } "../BCRS11/*.txt");
		@lister2 = (map { glob } "../BCRS12/*.txt");
		push(@lister, @lister1);
		push(@lister, @lister2);
		open (BKPLI,">bkplist.txt");
		chmod(0777, "bkplist.txt");
		foreach (@lister) {
			$_ !~ /\~/  && $_ !~ /alt/ && $_ !~ /copy/ and print BKPLI $_."\n";
			}
		close BKPLI;
		}

	-e "bkplist.txt" and print "file bkplist.txt exists...<br><br>";

	@bkpsold = glob("*.zip");
	$ZR = 24 * 60 * 60 * 14;
	foreach (@bkpsold) {
		my @Info = stat($_);
		if ((time-$Info[9]) > $ZR) {
			unlink($_);
			}
		}

	my $st;
	foreach (@lister) {
		#chomp; Note: replaced by the following two lines
		s/^\s+//;
		s/\s+$//;
		if (-d $_) {
			$zip->addTree( $_, $_ );
			}
		else {
			$zip->addFile( $_ ) or warn "Can't add file $_\n";
			}
		}

	my $status = $zip->writeToFileNamed($zipName);
	#exit $status;


	#my $num = 3;
	#while($num--){
    	#sleep(1);
	#}


	###GLP Update --> Test
	#chdir ($ordner2);

	my $zipNameGLP = "GLP_BK".$DT.".zip";
	my $zipGLP = Archive::Zip->new();
	chmod(0777, $zipNameGLP);

	my @glpfilsec = ("../GLP/MP_40M.TXT","../GLP/MP_40M4.TXT","../GLP/TBT.TXT","../GLP/TEILEVW.TXT","../GLP/GIPFEL.TXT","../GLP/GIPFEL2.TXT","../GLP/GLP.TXT","../GLP/STUELI.TXT");
	#my @glpfilsec = ("../GLP/MP_40M","MP_40M2","MP_40M3","../GLP/TBT","../GLP/TEILEVW","../GLP/GIPFEL","../GLP/GIPFEL2","../GLP/GLP","../GLP/STUELI");
	my $epoch_TS = (stat("../GLP/GLP.TXT"))[9];


	# only of interest, if a different folder is been used, otherwise the earlier routine deals with that as all *.zip files are included
	#@bkpsoldGLP = glob("*.zip");
	#$ZR = 24 * 60 * 60 * 14;
	#foreach (@bkpsoldGLP) {
	#	my @Info = stat($_);
	#	if ((time-$Info[9]) > $ZR) {
	#		unlink($_);
	#		}
	#	}

	foreach (@glpfilsec) {
		#chomp; Note: replaced by the following two lines
		s/^\s+//;
		s/\s+$//;
		if (-d $_) {
			$zipGLP->addTree( $_, $_ );
			}
		else {
			$zipGLP->addFile( $_ ) or warn "Can't add file $_\n";
			}
		}

	my $statusGLP = $zipGLP->writeToFileNamed($zipNameGLP);
	#exit $statusGLP;

	###turned off for admin:print "<script> GLPupd(); </script>";
	}

my @Infnew = stat($fh);
my $GLP_TSn = $Infnew[9];
#print "<script> alert('$GLP_TSn'); </script>";
#print "<script> alert('$GLP_TSo'); </script>";
my $tmp8 = (time-$GLP_TSo);
my $tmp9 = $ZR." vs ".$tmp8;
#print "<script> alert('$tmp9'); </script>";
if ($GLP_TSn == $GLP_TSo && (time - $GLP_TSo) > $ZR) {
	#print "<script> alert('yes'); </script>";
	###turned of for admin: print "<script> GLPupd(); </script>";
	}
#else {
	#print "<script> alert('no'); </script>";
#	}

print "</body></html>\n";

@bkpsoldGLP = glob("*.zip");
foreach (@bkpsoldGLP) {
	chmod(0777, $_);
	}

chdir ($ordner);
@bkpsold = glob("*.zip");
foreach (@bkpsold) {
	chmod(0777, $_);
	}
