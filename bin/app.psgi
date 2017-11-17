#!/usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/../lib";
#use Dancer2;
use zug7;
use zug8;

zug7->to_app;
zug8->to_app;
start;
