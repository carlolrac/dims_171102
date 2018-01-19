<?php
//author:Conny Schmidt, C.Schmidt@IConStructLtd.com
//IConStruct Limited, all rights reserved, 2003-indefinitely

$mp40 = $_REQUEST["M1"];
$mp404 = $_REQUEST["M2"];
$mp403 = $_REQUEST["M3"];
$tbt = $_REQUEST["TBT"];
$tvw = $_REQUEST["TVW"];
$gi1 = $_REQUEST["G1"];
$gi2 = $_REQUEST["G2"];
$glp = $_REQUEST["GLP"];
$st = $_REQUEST["ST"];

$poidsMax = ini_get('post_max_size'); 
echo $poidsMax;

echo strlen($M1)."<br>";
echo strlen($M2)."<br>";
echo strlen($M3)."<br>";
echo strlen($tbt)."<br>";
echo strlen($tvw)."<br>";
echo strlen($gi1)."<br>";
echo strlen($gi2)."<br>";
echo strlen($glp)."<br>";
echo strlen($st)."<br><br><br>";

if ($mp40) {
	$MPtmp = explode('abcba',chop($mp40));
	$File = "/mnt/daten/GLP/MP_40M.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($MPtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}

if ($mp404) {
	$MPtmp = explode('abcba',chop($mp404));
	$File = "/mnt/daten/GLP/MP_40M4.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($MPtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}

if ($mp403) {
	$MPtmp = explode('abcba',chop($mp403));
	$File = "/mnt/daten/GLP/MP_40M4.TXT";
	$fh = fopen($File, 'a') or die("can't open file");
	foreach ($MPtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	}

if ($tbt) {
	$TBTtmp = explode('abcba',chop($tbt));
	$File = "/mnt/daten/GLP/TBT.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($TBTtmp as $item) {
		if ($item != "" && !preg_match ("/\.\s\s\s\s\.\s\s\.\s\s\s\s\s\s\s\./", $item)) { fwrite($fh, $item."\n"); }
		}
	fclose($fh);
	chmod($File, 0777);
	}


if ($tvw) {
	$TVWtmp = explode('abcba',chop($tvw));
	$File = "/mnt/daten/GLP/TEILEVW.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($TVWtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}


if ($gi1) {
	$GItmp = explode('abcba',chop($gi1));
	$File = "/mnt/daten/GLP/GIPFEL.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($GItmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}


if ($gi2) {
	$GItmp = explode('abcba',chop($gi2));
	$File = "/mnt/daten/GLP/GIPFEL2.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($GItmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}


if ($glp) {
	$GLPtmp = explode('abcba',chop($glp));
	$File = "/mnt/daten/GLP/GLP.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($GLPtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}


if ($st) {
	$STtmp = explode('abcba',chop($st));
	$File = "/mnt/daten/GLP/STUELI.TXT";
	$fh = fopen($File, 'w') or die("can't open file");
	foreach ($STtmp as $item) {
		fwrite($fh, $item."\n");
		}
	fclose($fh);
	chmod($File, 0777);
	}

?>
