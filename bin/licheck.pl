#!/usr/local/bin/perl -w
use strict;
use warnings;
use FindBin;
#use lib $FindBin::Bin;
#use zug8;

use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

my (@daten);
my $i=0;
my ($ordner)="/opt/app-root/src/daten";
my ($a,$b,$c,$t);

$a = param('a');
$b = param('b');
#$c = param('c');
$t = time;

$a ||="";
$b ||="";


my $log = join("\t",($a,$b,$ENV{REMOTE_ADDR},time))."\n";

chdir ($ordner);
open(LOG,">>log.txt");
print LOG $log;
close LOG;

print <<"HTML";
Content-type: text/html\n\n
<html>
<head>
<title> Logon3 </title>
<meta name="description"    	  content="DIMS">
<meta name="robots"         	  content="no index">
<meta name="keywords"         	  content="">
<meta name="author"         	  content="Conny Schmidt, C.Schmidt\@IConStructLtd.com">
<meta http-equiv="content-type"   content="text/html; charset=ISO-8859-1">
<meta name="DC.Contributor" 	  content="Jörn Hering, joern.hering\@airbus.com">
<meta name="DC.Date.Create" 	  content="2005-12-04T00:09+0:00">
<meta name="DC.Language"    	  content="de">
<meta name="DC.Rights"	  	  content="Rights of ideas and sourcecode are owned by the author,2003-2013">
<meta name="DC.Warranty"          content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
				           Inhalte sind Eigentum der Abteilungen ECRS11 und ECRS12, Airbus Hamburg">
<meta name="DC.LastChange"  	  content="2013-06-18T2:29+0:00">
<meta name="Version"   	 	  content="1">

<script type="text/Javascript">
<!--

function Wohin(a,b) {
//alert("hierL");

HTML

#required time to define the subroutine
#for (my $i = 0; $i<=1000000; $i++) {
#	my $ii = sqrt($i);
#	}

my $g = $a;
my $h = $b;
my $w;
$w = Zug8($g,$h);

if ($w) {
	print "W = 'access';\n\n";
	}
else {
	print "W = 'no';\n\n";
	}

print <<"HTML";

  var Loc;
  var fn;
  var ver;
  var W;

  //alert("hierL");

  for (var i = 0; i <= 20; i++) {
    if (top.frames["main"].frames[i] && top.frames["main"].frames[i].v2 == "on") {
      fn = i;
      ver = 1;
//alert("a");
      }
    else if (parent.parent.frames["main"].frames[i] && parent.parent.frames["main"].frames[i].v2 == "on") {
      fn = i;
      ver = 2;
//alert("b");
      }
    //else { alert(parent.parent.frames["main"].frames[i].v2); }
    }

//alert("hier2");

alert(fn);
 alert(parent.parent.frames["main"].frames[fn].v2);
 alert(top.frames["main"].frames[fn].v2);

  if (top.frames["main"].frames[fn] && top.frames["main"].frames[fn].v2 == "on" && ver == 1) { 
    if (top.frames["main"].frames[fn]) {
      //works for parameters
      Loc = top.frames["main"].frames[fn];		
      }
    else {
      Loc = top.frames["main"];
      }
    }
//  else if (top.frames["main"].frames[fn] && parent.parent.frames["main"].frames[fn].v2 == "on" && ver == 2) { 
//    if (top.frames["main"].frames[fn]) {
//      //works for parameters
//      Loc = parent.parent.frames["main"].frames[fn];		
//      }
//    else {
//      Loc = parent.parent.frames["main"];
//      }
//    }
  else { 
    Loc = top.frames["main"];
    }

//alert(Loc.test);

  var acc = Loc.acc;
  if (acc) {
    //alert(acc);
    //alert(W);
    if (W == "access") {
      Loc.acc = 13;
      }
    }
  else {
    Loc.test = "cancel";
    var w = Loc.w;
    var x = Loc.document.URL;

    //alert("test:"+Loc.test);
    //alert("w:"+w);
    //alert("x:"+x);
    var y = x.replace(/pl.+/, "pl");
HTML

print "y = y.replace(\/\\w+\.pl\$\/,w);\n\n";

print <<"HTML";
    document.getElementById("a").value = a;
    document.getElementById("b").value = b;

  //alert(a);
  //alert(b);

    if (Loc.ident) { document.getElementById("ident").value = Loc.ident; }
    if (Loc.sheetid) { document.getElementById("sheetid").value = Loc.sheetid; }
    if (Loc.pass) { document.getElementById("pass").value = Loc.pass; }

    var tmp = w.match(".html");
    if (tmp) y = y.replace("cgi-bin","html");

 //   alert(y);

    if (!tmp) {
      document.getElementById("Logon").target = "main";
      document.getElementById("Logon").action = y;
      document.getElementById("Logon").submit();
      }
    else {
      y = y+'?a='+a+'&b='+b;
      Loc.document.location.href = y;
      }
    }
  this.document.location.href = "../html/empty.html";
  }

//-->
</script>
</head>

<body  bgcolor="#99FF99" onLoad="Wohin('$ENV{REMOTE_ADDR}',$t)">
<form id="Logon" method="post" target="">
<input type="hidden" name="a" id="a" value="">
<input type="hidden" name="b" id="b" value="">
<input type="hidden" name="ident" id="ident" value="">
<input type="hidden" name="sheetid" id="sheetid" value="">  
<input type="hidden" name="pass" id="pass" value=""> 
</form>
</body>
</html>
HTML

