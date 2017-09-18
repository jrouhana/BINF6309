#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Bio::SeqIO;           # Import export files
use Bio::Seq::Quality;    # Create sequence read objects

# Loop reads in left and right, each one by one, into variables.
# Each gets trimmed and made to clear Phred range of 20. The descriptions
# are retrieved, and an alternating left-right output is written.

fastqReadSequences();

# Subroutine to read in left and right fastq sequences
sub fastqReadSequences {

	my $leftFile = "Sample.R1.fastq";
	my $rightFile = "Sample.R2.fastq";

	# Read in left sequences
	my $left = Bio::SeqIO->new(
		-file   => $leftFile,
		-format => 'fastq'
	);

	# Read in right sequences
	my $right = Bio::SeqIO->new(
		-file   => $rightFile,
		-format => 'fastq'
	);
	alternateSequences($left,$right);
}

# Subroutine to write left and right sequences in alternating order
sub alternateSequences {
	my ($left, $right) = @_;
	# Object to write interleaved output
	my $interleavedOutput = Bio::SeqIO->new(
		-file   => ">Interleaved.fastq",
		-format => 'fastq'
	);

	while ( my ( $leftFastq, $rightFastq ) =
		( $left->next_seq(), $right->next_seq() ) )
	{
		# Put through each Fastq sequence that clears a Phred range of 20
		my $leftTrimmed = $leftFastq->get_clear_range(20);
		$leftTrimmed->desc( $leftFastq->desc() );    # Retrieve left description 
		# Same for right
		my $rightTrimmed = $rightFastq->get_clear_range(20);
		$rightTrimmed->desc( $rightFastq->desc() ); # Retrieve right description

		# Write output
		$interleavedOutput->write_seq($leftTrimmed);
		$interleavedOutput->write_seq($rightTrimmed);
	}
}
