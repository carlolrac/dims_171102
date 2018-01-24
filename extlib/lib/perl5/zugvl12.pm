#!/usr/local/bin/perl -w
package zugvl12;
use strict;
use vars qw(@ISA @EXPORT $VERSION);
use Exporter;
$VERSION = 1.00;
@ISA     = qw(Exporter);
@EXPORT  = qw(ZugVL12);

sub ZugVL12  {

	my $g=shift;
	my $h=shift;
	$g ||="";
	$h ||="";
	my (@daten,@log,$w,$check,$i,$tmp,$tmp2);
	my ($ordner)="/mnt/daten/BCRS12";
	
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
					my $tmp3 = substr($daten[$i],0,23);
					$tmp3 and $tmp3=$tmp3."|".$g."|".$h;
					$tmp2=$_;
					chomp($tmp2);
					$tmp2 =~ s/\s/\|/g;
					$tmp3 && $tmp2 eq $tmp3 and $w="access";
					}
				}
			}
		}

	if (not($w)) {

	}
	
return $w;
}

1;

