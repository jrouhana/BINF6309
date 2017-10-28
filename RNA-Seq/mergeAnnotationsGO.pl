#!/bin/perl
use warnings;
use strict;

# filehandle to input swissprot and go terms
open( SP_TO_GO, "<", "spToGo.tsv" ) or die $!;

# filehandle for trinity data
open( SP, "<", "aipSwissProt.tsv" ) or die $!;

# filehandle for GO data
open( GO, "<", "bioProcess.tsv" ) or die $!;

# hash to store swiss prot IDs and Go-Terms
my %spToGo;

# Loop through input to get swissprot and GO terms
while (<SP_TO_GO>) {
	chomp;
	my ( $swissProt, $go ) = split( "\t", $_ );
	$spToGo{$swissProt}{$go}++;
}

# hash to store go ID and go name
my %goData;

# Loop through input to get go_ID and go_name
while (<GO>) {
	chomp;
	my ( $go_id, $go_name ) = split( "\t", $_ );
	$goData{$go_id} = $go_name;
}

while (<SP>) {
	chomp;

	# print trinity data with protein description, protein name, and GO Term
	my ( $trinity, $swissProt, $description, $eValue ) =
	  split( "\t", $_ );
	if ( defined $spToGo{$swissProt} ) {
		foreach my $go ( sort keys %{ $spToGo{$swissProt} } ) {
			if ( defined $goData{$go} ) {
				# Print, in this order: Trinity ID, SwissProt ID, swissProt description, GO ID, Go Description
				print join( "\t", $trinity, $swissProt, $description, $go, $goData{$go} ),
				  "\n";
			}
		}
	}
}
