#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Bio::Seq; #BioSeq to create fasta objects
use Bio::SeqIO; #BioSeqIO to read and write

# Pass FASTA objects individually to be turned to 21-mers ending in GG from 
# dmel-all-chromosome.r6.02.fasta. Hash will store them together with last 12 positions 
# of the 21-mers serving as the keys. Create a second hash to count how many times each
# 12-mer occurs in the genome. # For each 12-mer that only occurs ONCE, the 
# corresponding 21-mer is a potential CRISPR. Print the crisprs.fasta



printCrisprs();

# Subroutine to read in FASTA Objects and write output
sub printCrisprs {

	# Use Bio::SeqIO to read in FASTA file
	my $fastaObjects = Bio::SeqIO->new(
		-file   => "dmel-all-chromosome-r6.17.fasta",
		-format => 'fasta'
	);

	# Use Bio::SeqIO to write to FASTA file
	my $outputObject = Bio::SeqIO->new(
		-file   => ">crisprs.fasta",
		-format => "fasta"
	);
	my ( $kMerHash, $last12Counts ) = processSequence($fastaObjects);

	#Initialize the CRISPR count to zero
	my $crisprCount = 1;

	#Loop through the hash of last 12 counts
	for my $last12Seq ( sort ( keys %$last12Counts ) ) {

		#Check if count == 1 for this sequence
		if ( $$last12Counts{$last12Seq} == 1 ) {
			my $seq_obj = Bio::Seq->new(
				-seq        => $$kMerHash{$last12Seq},
				-desc       => "CRISPR",
				-display_id => "crispr_$crisprCount",
				-alphabet   => "dna"
			);

			#The last 12 seq of this CRISPR is unique in the genome.
			#Increment the CRISPR count.
			$crisprCount++;

			#Print the CRISPR in FASTA format.
			$outputObject->write_seq($seq_obj);
		}
	}
}


# Subroutine to evaluate each sequence in a sliding window
sub processSequence {
	my ($fastaObjects) = @_;

	#hash to store kmers
	my %kMerHash = ();

	#hash to store occurrences of last 12 positions
	my %last12Counts = ();

	# For each Fasta Object, send fasta sequence for processing
	while ( my $fastaObject = $fastaObjects->next_seq ) {
		my $objectSequence = $fastaObject->seq();

		#Set the size of the sliding window
		my $windowSize = 21;

		#Set the step size
		my $stepSize  = 1;
		my $seqLength = length($objectSequence);

#for loop to increment the starting position of the sliding window
#starts at position zero; doesn't move past end of file; advance the window by step size
		for (
			my $windowStart = 0 ;
			$windowStart <= ( $seqLength - $windowSize ) ;
			$windowStart += $stepSize
		  )
		{
	   #Get a 21-mer substring from sequenceRef (two $ to deference reference to
	   #sequence string) starting at the window start for length $windowStart
			my $crisprSeq =
			  substr( $objectSequence, $windowStart, $windowSize );

#if the 21-mer ends in GG, create a hash with key=last 12 of k-mer and value is 21-mer
#Regex where $1 is the crispr, and $2 contains the last 12 of crispr.
			if ( $crisprSeq =~ /([ATGC]{9}([ATGC]{10}GG))$/ ) {

			  #Put the crispr in the hash with last 12 as key, full 21 as value.
				$kMerHash{$2} = $1;
				$last12Counts{$2}++;
			}
		}
	}
	return ( \%kMerHash, \%last12Counts );
}

