#!/usr/bin/perl
use warnings;
use strict;
use Bio::Seq;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

# Check if default Fasta exists, and if so, use it
my $defaultFastaIn = "Trinity-GG.fasta.transdecoder.pep";
my $fastaIn        = "";
if ( -e $defaultFastaIn ) {
	$fastaIn = $defaultFastaIn;
}

# Default Fasta Out file
my $fastaOut = "sample.pep";

# Default integer- which n-th do you want to sample?
my $sampleRate = 1000;

# Options
my $usage = "\n$0 [options] \n
Options:
	-fastaIn	Fasta file to read in
	-fastaOut	Fasta file to read in. Default sample.pep
	-sampleRate	Which n-th do you want to sample? Defualt 1000th
	-help		Show the message that you are reading
";

# Input options
GetOptions(
	'fastaIn=s'    => \$fastaIn,
	'fastaOut=s'   => \$fastaOut,
	'sampleRate=i' => \$sampleRate,
	'help'         => sub { pod2usage($usage); },
) or pod2usage($usage);

# Check all arguments are valid and exist
unless ( -e $fastaIn and -w $fastaOut or !-e $fastaOut ) {
	unless ($fastaIn) {
		print "Read in file is either invalid or not specified\n";
	}

	unless ($fastaOut) {
		print "Write file is possibly read-only\n";
	}
	die $usage;
}

# Input file
my $input = Bio::SeqIO->new(
	-file   => $fastaIn,
	-format => 'fasta'
);

# Output file
my $output = Bio::SeqIO->new(
	-file   => ">$fastaOut",
	-format => 'fasta'
);

# Sampler. Adds multiples of sampleRate
my $seqCount = 0;
while ( my $seq = $input->next_seq ) {
	$seqCount++;
	if ( ( $seqCount % $sampleRate ) == 0 ) {
		$output->write_seq($seq);
	}
}
