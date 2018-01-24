#!/usr/local/bin/perl -w
package zugvl;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(ZugVL);

sub ZugVL  {
	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS11";
	
	chdir ($ordner);
	open(ACC,"accvl.txt");
	@daten=<ACC>;
	close ACC;

	open(LOG,"log.txt");
	@log=<LOG>;
	close LOG;
	@log=reverse(@log);

	$tmp=$ENV{REMOTE_ADDR};
	$check=substr($tmp,0,7);
	if ($daten[0] =~ /$check/)  {
		foreach (@log) {
			if ($g && $h && ($_ =~ /$g/ && $_ =~ /$h/) )  {
				for ($i=1; $i<=$#daten; $i++)  {
					chomp($daten[$i]);
					$tmp2=$_;
					chomp($tmp2);
					$tmp2 =~ s/\s/\|/g;
					$daten[$i] and $daten[$i]=$daten[$i]."|".$g."|".$h;
					#print "<script>alert('$daten[$i]--$tmp2');</script><br>";
					#$daten[$i] && $tmp2 =~ /$daten[$i]/ and $w="access";
					$daten[$i] && $tmp2 eq $daten[$i] and $w="access";
					}
				}
			}
		}

	if (not($w)) {

	}
	
return $w;
}

1;

