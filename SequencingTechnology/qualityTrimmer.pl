#!/usr/bin/perl
use warnings;
use strict;
use diagnostics;
use Bio::SeqIO;           # Import export files
use Bio::Seq::Quality;    # Create sequence read objects
use Getopt::Long;         # For adding options
use Pod::Usage;           # For documentation

# Loop reads in left and right, each one by one, into variables.
# Each gets trimmed and made to clear Phred range of 20. The descriptions
# are retrieved, and an alternating left-right output is written.

# Assign default values if the files exist
my $defaultL = "Sample.R1.fastq";
my $leftFile = "";
if ( -e $defaultL ) {
	$leftFile = $defaultL;
}

my $defaultR  = "Sample.R2.fastq";
my $rightFile = "";
if ( -e $defaultR ) {
	$rightFile = "Sample.R2.fastq";
}

my $interleaved = 'Interleaved.fastq';
my $qual        = 20;

# Options
my $usage = "\n$0 [options] \n
Options: 
	-left	Right reads file name
	-right	Right reads file name
	-qual	Quality score necessary
	-help	Show the message you're reading";

# Check arguments
GetOptions(
	'left=s'        => \$leftFile,
	'right=s'       => \$rightFile,
	'interleaved=s' => \$interleaved,
	'qual=i'        => \$qual,
	'help'          => sub { pod2usaage($usage); },
) or pod2usage($usage);

# Check all arguments are valid
unless ( $leftFile and $rightFile and $qual and $interleaved ) {
	unless ($leftFile) {
		print "Left file read is either invalid or not specified\n";
	}

	unless ($rightFile) {
		print "Right file read is either invalid or not specified\n";
	}

	unless ($qual) {
		print "Specify an integer score for quality cut off\n";
	}

	unless ($interleaved) {
		print
"Specify a string name for interleaved file output, or leave default value\n";
	}
	die $usage;
}

fastqReadSequences();

# Subroutine to read in left and right fastq sequences
sub fastqReadSequences {

	# Read in left sequences
	my $left = Bio::SeqIO->new(
		-file   => "$leftFile",
		-format => 'fastq'
	);

	# Read in right sequences
	my $right = Bio::SeqIO->new(
		-file   => "$rightFile",
		-format => 'fastq'
	);
	alternateSequences( $left, $right );
}

# Subroutine to write left and right sequences in alternating order
sub alternateSequences {
	my ( $left, $right ) = @_;

	# Object to write interleaved output
	my $interleavedOutput = Bio::SeqIO->new(
		-file   => ">$interleaved",
		-format => 'fastq'
	);

	while ( my ( $leftFastq, $rightFastq ) =
		( $left->next_seq(), $right->next_seq() ) )
	{
		# Put through each Fastq sequence that clears a Phred range of 20
		my $leftTrimmed = $leftFastq->get_clear_range($qual);
		$leftTrimmed->desc( $leftFastq->desc() );    # Retrieve left description

		my $rightTrimmed = $rightFastq->get_clear_range($qual);
		$rightTrimmed->desc( $rightFastq->desc() ); # Retrieve right description

		# Write output
		$interleavedOutput->write_seq($leftTrimmed);
		$interleavedOutput->write_seq($rightTrimmed);
	}
}
