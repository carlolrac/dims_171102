#!/usr/local/bin/perl -w
use CGI::Carp qw(fatalsToBrowser);
use strict;
use CGI ('param');
use CGI;
use Env;

my ($logon,$th,$dep,$stamp,$date,$cgi1,$cgi2,$cgi3,$ksgo,$ksearch,$addkey);
my (@date,@stamp);
my ($keylett,$zeile,@daten,$keyword,$pathkey,@datensort,$kw,$woher,$aufruf);
my $i=1;
my $ordner = "/mnt/daten/BCRS12";

$keylett=param('keylett');
$keylett ||="0";
$ksgo = param('ksgo');
$ksearch = param('ksearch');
$ksearch ||= "";

print <<"HTML";
Content-type: text/html\n\n
<html><head>
<title>keywords of Initial keylett</title>
<meta name="description"	content="TBCES DIMS">
<meta name="robots"		content="no index">
<meta name="author"		content="Conny Schmidt, C.Schmidt\@IConStructLtd.com">
<meta http-equiv="content-type"	content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor"	content="Jörn hering, joern.hering\@airbus.com">
<meta name="DC.Date.Create"	content="2005-08-25T20:40+0:00">
<meta name="DC.Language"	content="de">
<meta name="DC.Rights"		content="Rights of ideas and sourcecode are owned by the author,2003-2011">
<meta name="DC.Warranty"	content="keine Gewähr für Richtigkeit der Daten seitens des Autors; Inhalte sind Eigentum der Abteilung TBCES12, Airbus Hamburg">
<meta name="DC.LastChange"	content="2012-03-14T12:47+0:00">
<meta name="Version"		content="3beta">

<script for="document" event="onkeydown()" language="JScript" src="../../scripts/hkey7.js" type="text/jscript"></script>

<script type="text/javascript">
<!--
var Log;
function Register() {
  //document.getElementById("login").filters.revealTrans.Apply();
  document.getElementById("login").style.visibility = "visible";
  //document.getElementById("login").filters.revealTrans.Play();
  document.getElementById("th").focus();
 }


function LogOn(a) {
  var exp = new Date();
  var at = new Date();
  var expmod = at.getTime() + (2592000000);
  at.toGMTString();
  exp.setTime(expmod);
  //alert(exp);
  //alert(exp.toGMTString);
  document.cookie = "th="+document.getElementById('th').value.toLowerCase()+"; expires="+exp.toGMTString()+";";
  document.cookie = "dep="+document.getElementById('dep').value.toUpperCase()+"; expires="+exp.toGMTString()+";";
  document.cookie = "lastin="+at+";expires="+exp.toGMTString()+";";
  var target = document.URL;
  var DST = new Date();
  var TST = DST.getTime();
  target = target.replace(/\.pl.+/, ".pl");
  target = target+"?logon=logon&keylett="+a+"&TST="+TST;
  document.location.href =(target);
  }


function ReLog(a,b,c,d) {
  var x = "";
  var exp = new Date();
  var at = new Date();
  var Mon = at.getMonth();
  var Year = at.getFullYear();
  var Day = at.getDate();
  var Monnam = new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
  var expmod = at.getTime() + (2592000000);
//alert(at);
//  at.toUTCString();
//alert(at);
  exp.setTime(expmod);
  var check1 = c.split(" ");
  if (!check1[5] || check1[5] == "undefined") { check1[5] = check1[4]; check1[3] = check1[2]; }
  if (check1[1] != Monnam[Mon] || check1[5] != Year || check1[3] != Day) { 
    alert('Bitte die Datumseinstellung des Rechners überprüfen !\\n\\nHeute ist der:  '+check1[3]+'.'+check1[1]+'.'+check1[5]);
    x = "stop";
    ReLog(a,b,c,d);
    alert("relogge");
    }
  document.cookie = "th="+a.toLowerCase()+"; expires="+exp.toGMTString()+";";
  document.cookie = "dep="+b.toUpperCase()+"; expires="+exp.toGMTString()+";";
  document.cookie = "lastin="+at+"; expires="+exp.toGMTString()+";";
  var target = document.URL;
  var DST = new Date();
  var TST = DST.getTime();
  target = target.replace(/\.pl.+/, ".pl");
  if (x != "stop") target = target+"?logon=logon&keylett="+d+"&TST="+TST;
  document.location.href =(target);
  }


function Update(a) {
  var target = document.URL;
  var DST = new Date();
  var TST = DST.getTime();
  target = target.replace(/\.pl.+/, ".pl?keylett="+a+"&TST="+TST);
  document.location.href =(target);
  }


function Zugr(a,b,c) {
  a = encodeURIComponent(a);
  b = encodeURIComponent(b);
  c = encodeURIComponent(c);
  var DST = new Date();
  var TST = DST.getTime();
  var Stat = window.open('stat01.pl?kw='+a+'&aufruf='+b+'&woher='+c+'&TST='+TST,"Stat","width=10,height=10,left=2000,top=2000,scrollbars=yes");
}
</script>
</head>

<body bgcolor="#DDDDDD" text="#000000" link="#0000FF" vlink="#000000" alink="#0000FF">

<div  id="focus" style="position:absolute; top:0pt; left:0pt; margin:0pt; padding:0pt;"><input type="text" size="1" style="visibility:hidden;"></div>
<div  id="login" style="position:absolute; top:15pt; left:15pt; width:270; margin:0pt; padding:10pt; visibility:hidden; background-color:#ff0000; border:2pt solid #ffffff; filter:revealTrans(Duration=0.3,Transition=5)">
<h3>- Nicht registrierter Benutzer -</h3>
<p><b>F&uuml;r Zugriff bitte ausf&uuml;llen !</b></p>
<form name="Reglog">
<input type="hidden" id="KL" value="$keylett">
<table border="0" cellpadding="5" cellspacing="0" style="margin:0pt;">
<tr><td><b> th-user: </b></td><td colspan="2"> <input type="text" size="10" id="th" maxlength="7"> </tr>
<tr><td><b> Abteilung: </b></td><td> <input type="text" size="10" id="dep" maxlength="8"> </td>
<td> <input type="button" value="Login" onClick="LogOn('$keylett','$ksearch')"> </td></tr>
</table>
</form>
</div>
HTML

($cgi1,$cgi2,$cgi3) = (new CGI,new CGI,new CGI);

$date = localtime(time);
$stamp = $cgi1->cookie(-name=>'lastin');
$th = $cgi2->cookie(-name=>'th');
$dep = $cgi3->cookie(-name=>'dep');
$logon = param('logon');

if ($logon) {
	if (($th && $th =~ /[t|n][h|s|g][a-z0-9]{4,5}/i) && $dep && $stamp) {
		chdir($ordner);
		open (LOG, ">>login.txt");
		print LOG $th."\t".$dep."\t".$ENV{REMOTE_ADDR}."\t".$stamp."\n";
		close LOG;
		print "<script language=\"JavaScript\">Update('$keylett')</script>";
		}
	}

if (not($stamp) || not($th) || not($dep) || ($th && $th !~ /[t|n][h|s|g][a-zA-Z0-9]{4,5}/i))  { 
	print "<script language=\"JavaScript\">Register()</script>"; 
	}
else { 
	@date = split(/\s/, $date);
	@stamp = split(/\s/, $stamp);
        not($date[5]) || $date[5] !~ /\d{4}/ and ($date[5],$date[3]) = ($date[4],$date[2]);

#print "---$stamp[6]<br>";
#print "---$date[5]---$stamp[5]<br>";
#print "---$date[1]---$stamp[1]<br>";
#print "---$date[3]---$stamp[2]<br>";
#print "$ENV{'HTTP_USER_AGENT'}";

	if ($ENV{'HTTP_USER_AGENT'} =~ m/Mozilla\/4.0/ && ($stamp[6] && $date[5] != $stamp[6]) || (not($stamp[6]) && $date[5] != $stamp[5]) || ($date[1] ne $stamp[1]) || (($date[3] - $stamp[2]) >= 1) || (($date[3] - $stamp[2]) <= -1)) {
		print "<script language=\"JavaScript\">ReLog('$th','$dep','$date','$keylett')</script>"; 
		}
	elsif ($ENV{'HTTP_USER_AGENT'} =~ m/Mozilla\/5.0/ && ($stamp[3] && $date[5] != $stamp[3]) || (not($stamp[3]) && $date[5] != $stamp[5]) || ($date[1] ne $stamp[1]) || (($date[3] - $stamp[2]) >= 1) || (($date[3] - $stamp[2]) <= -1)) {
		print "<script language=\"JavaScript\">ReLog('$th','$dep','$date','$keylett')</script>"; 
		}
	else  {
		print "<div align=\"center\">";
		$keylett and print "<h1>$keylett</h1><br>";
		$ksearch and print "<h1>Result for search of &quot;$ksearch&quot;</h1><br>";
		print "<table border=\"0\">";

		chdir ($ordner);
		open(KEYWORD,"keywords.txt");
		@daten = <KEYWORD>;
		close KEYWORD;

		@datensort=sort(Lettersort @daten);

		foreach $zeile(@datensort) {
			($keyword, $pathkey, $addkey) = split(/\t/,$zeile);
			$addkey ||= "";
			$pathkey ||= "";
			$keyword ||= "";
			$keyword =~ s/^\s+//;
			$keyword =~ s/\s+$//;
			$keyword =~ s/\"//g ;
			$keyword =~ s/\'//g ;
			$pathkey =~ s/^\s+//;
			$pathkey =~ s/\s+$//;
			$pathkey =~ s/"//g ;
			my $z=-4;
			my $l = (length($pathkey)-4)*(-1);

			while (($l != 4 && substr($pathkey,$z,1) ne "\\" && substr($pathkey,$z,1) ne "/") && $z >= $l)  { $z--; }
			$aufruf=substr($pathkey,++$z);
			$aufruf =~ s/\\//g ;
			$aufruf =~ s/\///g ;
			$aufruf =~ s/\'//g ;
			$kw = $keyword;
			$kw =~ s/'//g;

			if ($keylett) {	
				$keyword =~ m/(\w)/;
				if (uc($keylett) eq uc($1)) {
					if (($pathkey !~/\\\./g) && ($pathkey =~/\\/g) && (substr($pathkey,-3,3) ne "htm" && substr($pathkey,-3,3) ne "pdf") && (substr($pathkey,-3,3) ne "oc ")) {
						#Achtung if-Anweisung kann raus für final application
						if ($pathkey eq "../../index.html")  { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"_top\"> $keyword </a></td></tr>\n"; }
						else { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"parent\"> $keyword </a></td></tr>\n"; }
						}
					else {
						#Achtung if-Anweisung kann raus für final application
						if ($pathkey eq "../../index.html")  { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"_top\"> $keyword </a></td></tr>\n"; }
						else { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"main\"> $keyword </a></td></tr>\n"; }
						}
					$i++;
					}
				}
			elsif ($ksearch) {
				if ($keyword =~ /$ksearch/i || $addkey =~ /$ksearch/i) {
					if (($pathkey !~/\\\./g) && ($pathkey =~/\\/g) && (substr($pathkey,-3,3) ne "htm" && substr($pathkey,-3,3) ne "pdf") && (substr($pathkey,-3,3) ne "oc ")) {
						#print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"parent\"> $keyword </a></td></tr>\n";
						if ($pathkey eq "../html/BCRStest.html")  { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"_top\"> $keyword </a></td></tr>\n"; }
						else { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"parent\"> $keyword </a></td></tr>\n"; }
						}
					else {
						#print"<tr><td><a onClick=\"Zugr('$kw','$aufruf','$th')\" href= \"$pathkey\" target=\"main\"> $keyword </a></td></tr>\n";
						if ($pathkey eq "../html/BCRStest.html")  { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"_top\"> $keyword </a></td></tr>\n"; }
						else { print"<tr><td><a href= \"$pathkey\" onClick=\"Zugr('$kw','$aufruf','$th')\" target=\"main\"> $keyword </a></td></tr>\n"; }
						}
					$i++;
					}
				}
			}
		print "</table>";
		($keylett && $i==1) and print"<tr><td>Leider noch keine Eintr&auml;ge vorhanden...</td></tr>\n";
		($ksearch && $i==1) and print"<tr><td>Es wurden keine zur Suche passenden Eintr&auml;ge gefunden...</td></tr>\n";
		print "</div>";
		}
 	}

#print "$date";

print <<"EndeHTML";
</body>
</html>
EndeHTML

no warnings 'redefine';
sub Lettersort {
 if(uc($a) lt uc($b))
  { return -1; }
 elsif(uc($a) eq uc($b))
  { return 0; }
 else
  { return 1; }
}

