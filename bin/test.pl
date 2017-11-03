#!/usr/bin/env perl


#use Dancer2;
#use Plack::Runner;

## For some reason Apache SetEnv directives dont propagate
## correctly to the dispatchers, so forcing PSGI and env here 
## is safer.
#set apphandler => 'PSGI';
#set environment => 'production';

#my $psgi;
#$psgi = path($ENV{'DOCUMENT_ROOT'}, 'cgi-bin', 'BCRS11/keywinit.pl');
#die "Unable to read startup script: $psgi" unless -r $psgi;

#Plack::Runner->run($psgi);



use strict;
#use CGI::Carp qw(fatalsToBrowser);
#use CGI ('param');

print <<"HTML";
Content-type: text/html\n\n
<html><head><title>Test</title>
</head>
<body bgcolor=#66FF66>
<div align="center">
<br>
<h1 align="center"> TEST 2 </h1>
<br>
</div>
</body>

</html>
HTML

