#!/usr/bin/perl
use Bio::SearchIO;

my $blastXml = Bio::SearchIO->new(
	-file =>"Trinity-GG.blastp.xml",
	-format => "blastxml"
);

while ( my $result = $blastXml->next_result() ) {
	print $result, "\n";
}