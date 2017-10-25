#!/bin/perl
use warnings;
use strict;

# filehandle for input
open( SP_TO_GO, "<", "spToGo.tsv" ) or die    #!;

  # hash to store swiss prot IDs and Go-Terms
  my %spToGo;

# Loop through input to get swissprot and GO terms
while (<SP_TO_GO>) {
	chomp;
	my ( $swissProt, $go ) = split( "\t", $_ );
	$spToGo{$swissProt}{$go}++;
}

# New filehandle for trinity data
open( SP, "<", "aipSwissProt.tsv" ) or die $!;

while (<SP>) {
	chomp;

	# print trinity data with protein description, protein name, and GO Term
	my ( $trinity, $swissProt, $description, $eValue ) =
	  split( "\t", $_ );
	if ( defined $spToGo{$swissProt} ) {
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {
			print join( "\t", $trinity, $description, $swissProt, $go ), "\n";
		}
	}
}
