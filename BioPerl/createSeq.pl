#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq;

# add Comment
my $seq_obj = Bio::Seq->new(
	-seq      => "aaaatgggggggggggccccgtt",
	-alphabet => 'dna'
);

print( $seq_obj->seq, "\n" );
