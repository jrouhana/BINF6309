#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq;

my $string = "stuff";

changeString();

sub changeString {
	$string = "notStuff";
}

print($string);