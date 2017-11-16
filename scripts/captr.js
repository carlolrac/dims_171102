// javascript zum Capacity-Tracker
// rights of source code owned by the author, 2016-indefinitely
// author: Carl Schmidt, c.schmitd@schmidt.com

var Lock;
var Lock2;
var Pointer = "";
var aID;
var aID2;
var Ident;
var Schl;
var Code;
var Rank;
var Pos;
var Kind;


function PrepEntryPr(a) {
	var vals = new Array();
	vals = a.split("_");
	Pointer = "";
	Pointer = a;
	aID = a+"inp";
	//alert(aID);
	}

function PrepEntryM(a) {
	var vals = new Array();
	vals = a.split("_");
	Pointer = "";
	Pointer = a;
	aID = a+"inp";
	//alert(aID);
	}


function ValCha(a,b,c,d,e,f,g) {
//alert(c);
//alert(d);
//alert(e);
//alert(f);
Code=c;
Rank=d;
Pos=e;
Kind=f;
Ident=g;
  if (!Lock2 && !Lock) {
    Lock = "Lock";
    Pointer = "";
    Pointer = a;
    Lock = a;
    aID = a+"inp";
//    Schl = d;
  var Cont;
  document.getElementById(a).style.backgroundColor = "#c0c0c0";

//  alert(document.getElementById(a).parentElement.offsetWidth);
  var aIDw = document.getElementById(a).parentElement.offsetWidth-8;
  aIDw = aIDw+"px";
  if (document.getElementById(a).firstChild) { Cont = document.getElementById(a).firstChild.nodeValue; }
  if (!Cont && document.getElementById(aID)) Cont = document.getElementById(aID).value;
  if (document.getElementById(a).firstChild) document.getElementById(a).removeChild(document.getElementById(a).firstChild);
//alert('-'+Cont.charCodeAt(0)+'-');
  if(Cont && Cont != undefined && Cont.charCodeAt(0) != 160) {
    document.getElementById(a).innerHTML = "<input maxlength='"+c+"' class='"+b+"' id='"+aID+"' type='text' value='"+Cont+"' onBlur='ValFix()' onKeydown='CheckKey()'>";  	//<img style='position:relative; top:3px; left:5px; margin:0px; padding:0px;' src='../../images/save03.gif' onClick='ValFix()'>";
document.getElementById(aID).style.width=aIDw;
//document.getElementById(aID).style.backgroundColor="yellow";
    }
  else if(!Cont || Cont == " " || Cont == "" || Cont.charCodeAt(0) == 160) {
//    if (a == "mod") document.getElementById(a).innerHTML = "<input maxlength='"+c+"' class='"+b+"' id='"+aID+"' type='text' value='0'><img style='position:relative; top:3px; left:5px; margin:0px; padding:0px;' src='../../images/save03.gif' onClick='ValFix()'>";
//    if (a == "mp") document.getElementById(a).innerHTML = "<input maxlength='"+c+"' class='"+b+"' id='"+aID+"' type='text' value='K'><img style='position:relative; top:3px; left:5px; margin:0px; padding:0px;' src='../../images/save03.gif' onClick='ValFix()'>";
    if (a.match("rem")) document.getElementById(a).innerHTML = "<input maxlength='"+c+"' class='"+b+"' id='"+aID+"' type='text' value=' ' onBlur='ValFix()' onKeydown='CheckKey()'>"; 		//<img style='position:relative; top:3px; left:5px; margin:0px; padding:0px;' src='../../images/save03.gif' onClick='ValFix()'>";
document.getElementById(aID).style.width=aIDw;
//document.getElementById(aID).style.backgroundColor="yellow";
    }
  document.getElementById(aID).focus();
  document.getElementById(aID).select();
  }
}


function ValFix() {
  var aID = Pointer + "inp";
  var Val = document.getElementById(aID).value;
  Val = Val.replace(/^\s+/, "");
  Val = Val.replace(/\s+$/, "");

  document.getElementById(Pointer).removeChild(document.getElementById(Pointer).firstChild);
//  document.getElementById(Pointer).removeChild(document.getElementById(Pointer).firstChild);
  document.getElementById(Pointer).appendChild(document.createTextNode(Val));
//alert('--'+Val+'--');
//  var tmp = Val.match(/^\w+$/);
//  if (!tmp) document.getElementById(Pointer).firstChild.nodeValue = "a";
//  if (tmp) alert("yes");
//  if (tmp) var tmp2 = "yes";
//  alert('-'+Val+'-');
//  tmp1 = Val.match(/^0$/);
//  tmp2 = Val.match(/^K$/);

  if (!Val || Val == "" || Val == " " || Val.charCodeAt(0) == 160) { document.getElementById(Pointer).firstChild.nodeValue = ""; document.getElementById(Pointer).style.backgroundColor = "#d0d0d0"; document.getElementById(Pointer).style.border = "dashed 1px #a0a0a0"; }
  else { document.getElementById(Pointer).style.backgroundColor = "#d0d0d0"; document.getElementById(Pointer).style.border = "dashed 1px #a0a0a0";}
//  if (Schl.substr(0,6) == "551MTI") document.getElementById(Pointer).style.borderBottom = "1px solid red";
  Lock ="";
  var Wert = Val;
//  var Wert = Schl+Val;
//  ST[Schl.replace("xyzyx","")] = Val;
  SaveIt(Wert);
//    document.getElementById(Pointer).onclick = ValCha(Pointer); //maybe something as pointer senden, was die Ausführung der Function verhindert
  }

function SaveIt(a) {
a = a.replace(/\&/, "undnu");
//alert(parent.AccU);
//alert(parent.AccT);
//parent.frames[2].document.location.href = "../../cgi-bin/BCRS12/glpcha.pl?pass="+a+"&a="+parent.AccU+"&b="+parent.AccT;
//parent.frames[3].document.location.href = "speccha.pl?pass="+a+"&ident="+Ident+"&Position="+Position+"&a="+parent.AccU+"&b="+parent.AccT;
//LogInp('glpcha.pl',a);
  Lock2="";
  Lock="";
  parent.frames[3].document.location.href = "mstrsto.pl?a="+parent.AccU+"&b="+parent.AccT+"&value="+a+"&code="+Code+"&rank="+Rank+"&position="+Pos+"&kind="+Kind+"&ident="+Ident;

}



function ChooseMeet(a_opt,a_col) {
	//alert("hier");
	//alert(M_id);
	//alert(a_col);
	//alert(a_opt);
	//alert(document.getElementById(M_id).style.backgroundColor);
	document.getElementById(M_id).style.backgroundColor = a_col;
	//document.getElementById(M_id).style.borderLeft = "1px solid lightgrey";
	//document.getElementById(M_id).style.borderBottom = "1px solid lightgrey";
//alert("hier2");
	if (a_opt == "") { a_opt = "&nbsp;"; }
	document.getElementById(M_id).innerHTML = a_opt;
//alert("hier3");
	if (M_id.match("Meet_") && a_opt == "") {
//alert("hier4");
		M_id_pr = M_id.replace("Meet_","Prog_");
//alert("hier5");
		if (document.getElementById(M_id_pr)) { document.getElementById(M_id_pr).innerHTML = a_opt; }
//alert("hier6");
		}
//alert(M_id);
	document.getElementById("Details").style.display = "none";
	Lock = "";
//alert("hier7");
	SaveItKap(a_opt);
  }


function ChooseProg() {
	//alert(M_id);
	//alert(a_col);
	//alert(a_opt);
	//alert(document.getElementById(M_id).style.backgroundColor);
	document.getElementById(M_id).innerHTML = document.getElementById("code").value;
	document.getElementById("Details2").style.display = "none";
	Lock2 = "";
	//SaveItKap(a_opt);
	document.getElementById("ident").value = M_id;
	document.getElementById("MeetDet").submit();
  }


function SaveItKap(a) {
  //alert(a);
	a = a.replace(/\&nbsp\;/, "");
	a = a.replace(/\&/, "undnu");
	//alert(parent.AccU);
	//alert(parent.AccT);
//parent.frames[2].document.location.href = "../../cgi-bin/BCRS12/glpcha.pl?pass="+a+"&a="+parent.AccU+"&b="+parent.AccT;
//parent.frames[3].document.location.href = "speccha.pl?pass="+a+"&ident="+Ident+"&Position="+Position+"&a="+parent.AccU+"&b="+parent.AccT;
//LogInp('glpcha.pl',a);
  //Lock2="";

  parent.frames[3].document.location.href = "kapcalsto.pl?a="+parent.AccU+"&b="+parent.AccT+"&value="+a+"&ident="+M_id;
	M_id = "";
  Lock="";
  Lock2="";
	}
