#!/bin/perl
use warnings;
use strict;

# filehandle for input
open ( SP_TO_GO, "<", "spToGo.tsv" ) or die #!;

# hash to store swiss prot IDs and Go-Terms
my %spToGo;

# Loop through input to get swissprot and GO terms
while (<SP_TO_GO>) {
	chomp;
	my ( $swissProt, $go ) = split( "\t", $_);
	$spToGo{$swissProt}{$go}++;
}

# testing hash so far
foreach my $swissProt ( sort keys %spToGo ) {
	foreach my $go (sort keys %{$spToGo{$swissProt}}){
		print join ( "\t", $swissProt, $go), "\n";
	}
}