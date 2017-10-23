#!/usr/bin/perl
use strict;
use warnings;
use Bio::SearchIO;
use Bio::Search::Result::GenericResult;
use Data::Dumper;

# Read in XML
my $blastXml = Bio::SearchIO->new(
	-file   => "Trinity-GG.blastp.xml",
	-format => 'blastxml'
);

# open output or die
open( TAB_OUT, ">", 'aipSwissProt.tsv' ) or die $!;    

# Headers
print TAB_OUT "Trinity\tSwissProt\tSwissProtDesc\teVaue\n";

# Parse the XML file, output tab-delimited 
while ( my $result = $blastXml->next_result() ) {
	my $queryDesc = $result->query_description;
	if ( $queryDesc =~ /::(.*?)::/ ) {
		my $queryDescShort = $1;
		my $hit            = $result->next_hit;
		if ($hit) {
			print TAB_OUT $queryDescShort, "\t";
			print TAB_OUT $hit->accession, "\t";
			my $subjectDescription = $hit->description;
			if ( $subjectDescription =~ /Full=(.*?);/ ) {
				$subjectDescription = $1;
			}
			if ( $subjectDescription =~ /Full=(.*?)\[/ ) {
				$subjectDescription = $1;
			}
			print TAB_OUT $subjectDescription, "\t";
			print TAB_OUT $hit->significance, "\n";
		}
	}
}
