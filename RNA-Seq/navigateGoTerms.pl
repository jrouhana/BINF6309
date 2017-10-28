#!/usr/bin/perl
use warnings;
use strict;

use Bio::OntologyIO;

my $out_file = "bioProcess.tsv";

# Input .obo file for input
my $parser = Bio::OntologyIO->new(
	-format => "obo",
	-file   => "go-basic.obo"
);

# Loop through ontology to return top-level terms
#while ( my $ont = $parser->next_ontology() ) {
#	print "read ontology", $ont->name(), "with",
#	  scalar( $ont->get_root_terms ), "root terms, and ",
#	  scalar( $ont->get_leaf_terms ), "leaf terms\n";

#}
open( BIO_PROCESS, ">", $out_file ) or die $!;

while ( my $ont = $parser->next_ontology() ) {

	# For Aptasia, the most useful GO terms are the
	# biological process terms. Iterate over them and
	# print name and identifier
	if ( $ont->name() eq "biological_process" ) {
		foreach my $leaf ( $ont->get_leaf_terms ) {
			my $go_name = $leaf->name();
			my $go_id   = $leaf->identifier();
			print BIO_PROCESS join( "\t", $go_id, $go_name ), "\n";
		}
	}
}
