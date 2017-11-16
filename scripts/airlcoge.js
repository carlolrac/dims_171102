// Kontrolle der Zugriffsrechte ECRS12
// author:Carl Schmidt, C.Schmidt@Schmidt.com

<!--
var Log;
var w="";
var ident;
var pass;
var test = "a";
var v1 = "off";
var v2 = "off";

function LogInp(a,b,c) {
  var Utest = parent.U;

//alert(Utest);

  if (Utest) {
    Utest = Utest.replace("off_", "");
    v1 = "on";
    }
  else {
    Utest = parent.parent.U
    Utest = Utest.replace("off_", "");
    v2 = "on";
    }

alert(Utest);
//alert("v1:" + v1);
//alert("v2:" + v2);


  w = a;
  if (b) ident=b;
  if (c) pass=c;

  if (Utest) {
    Y = Utest;
    if (v1 == "on") {
      parent.frames["login"].document.location.href = "file:///C:/users/"+Y+"/bcrs_db/lic.html";
      }
    else if (v2 == "on") {
     //alert("file:///C:/users/"+Y+"/bcrs_db/lic.html");
      parent.parent.frames["login"].document.location.href = "file:///C:/users/"+Y+"/bcrs_db/lic.html";
      }
    }
  window.setTimeout("GoOn();",5000);
  }


function GoOn() {
  if (test != "cancel") {
    //if (Log) Log.close();

    if (v1 == "on") {
      parent.frames["login"].document.location.href = "../html/empty.html";
      v1 = "off";
      }
    else if (v2 == "on") {
      parent.parent.frames["login"].document.location.href = "../html/empty.html";
      v2 = "off";
      }

    var target = document.URL;
    target = target.replace(/pl.+/, "pl");
    target = target.replace(/\w+\.pl/, w);
    var tmp = w.match(".html");
    if (tmp) target = target.replace("bin", "html");
    if (tmp) target = target+"?a=abc&b=def";
    if (!tmp) parent.document.location.href =(target);
    if (tmp)  document.location.href =(target);
    }
  }
//-->

