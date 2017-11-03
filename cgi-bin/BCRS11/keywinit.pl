#!/usr/cgi-bin/env perl
use strict;
use CGI::Carp qw(fatalsToBrowser);
use CGI ('param');

#<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
#       "http://www.w3.org/TR/html4/loose.dtd">
#<html>
#<head>
#<title>Datenbank BSOE32 </title>
#<meta name="description"    	 content="BCRS11 Databench">
#<meta name="robots"         	 content="no index">
#<meta name="author"         	 content="Conny Schmidt, C.Schmidt@ski-team.com, lofant@web.de">
#<meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
#<meta name="DC.Contributor" 	 content="Falkmar Platz, Falkmar.Platz@airbus.com">
#<meta name="DC.Date.Create" 	 content="2003-09-11T18:17+0:00">
#<meta name="DC.Language"    	 content="de">
#<meta name="DC.Rights"	  	 content="Rights of ideas and sourcecode are owned by the author,2003-2007">
#<meta name="DC.Warranty"        content="keine Gewähr für Richtigkeit der Daten seitens des Autors; 
#				          Inhalte sind Eigentum der Abteilung BCRS, Airbus Hamburg ">
#<meta name="DC.LastChange"  	 content="2007-01-27T0:45+0:00">
#<meta name="Version"   	 content="1">

print <<"HTML";
Content-type: text/html\n\n
<html><head><title>Keyword_Search</title>
<script type="text/javascript">
<!--
function Greet() {
  //alert(a+"\\n"+b+"\\n"+c);
  window.open('../html/greet.html',"Greet","width=400,height=660,left=310,top=25,scrollbars=no,status=no");
  //parent.frames[4].location.href =('stat01.pl?kw='+a+'&aufruf='+b+'&woher='+c);
}
function KS() {
  document.getElementById("KS").submit();
  //alert(a+"\\n"+b+"\\n"+c);
  //window.open('../html/greet.html',"Greet","width=400,height=660,left=310,top=25,scrollbars=no,status=no");
  //parent.frames[4].location.href =('stat01.pl?kw='+a+'&aufruf='+b+'&woher='+c);
}
// -->
</script>

</head>
<body bgcolor="#000000" text="#00FF00" link="#00FF00" vlink="#FF0000" alink="#FF0000">
</--onload="Greet()"//-->

<div align= "center" style="position:relative; left:10px;">
HTML

my @keylett = ('A'..'Z','Main');
foreach (@keylett) {
	$_ ne "Main" and print "<a href=\"../../cgi-bin/BCRS11/keysearch.pl?keylett=$_\" target=\"main\">$_</a> &nbsp;&nbsp;&nbsp;";
	$_ eq "Main" and print "&nbsp;&nbsp;&nbsp;&nbsp;<a href=\"../../index.html\" target=\"_parent\">$_</a>";
	}

print <<"HTML";
</div>
<!--div style="position:absolute; left:5px; top:15px;"//-->
<!--a href="../BCRStest.html" target="_parent">Main</a//-->
<!--a href="../../index.HTML" target="_parent">Main</a>
</div//-->

<div style="position:absolute; right:5px; top:5px;">
<img src="../../images/titgal07.jpg" target="_parent">
</div>

<!--div align= "left" style="position:relative; left:47px; top:-20px; width:100px;"//-->
<div align= "left" style="position:relative; left:0px; top:-20px; width:100px;">
<form id="KS" name="KS" target="main" action="keysearch.pl">
<input type="text" style="font-family:Arial; font-size:10px; line-height:13px; width:100px; border:0px;" name="ksearch"><br>
<input type="button" style="cursor:pointer; font-family:Arial; font-size:11px; height:14px; margin-top:5px; padding:0px; border:0px; font-weight:bold;" name="ksgo" value="search" onClick="javascript: this.form.submit()";>
</div>

</body>
</html>
HTML
