#!/usr/bin/perl
use warnings;
use strict;
use Bio::DB::EUtilities;
use Bio::SeqIO;
use Getopt::Long;
use Pod::Usage;

#GLOBALS
my $ACC = '';
my $usage = "\n\n$0 [options] \n
Options:

-acc Accession Number
-help Show this message
\n";

#check the flags
GetOptions(
	'acc=s' => \$ACC,
	help => sub { pod2usage($usage);},
)
or pod2usage(2);
	
my $factory = Bio::DB::EUtilities(-eutil => 'efetch',
				-db	=> 'protein',
				-rettype => 'fasta',
				-email => 'donaldson.m@husky.neu.edu'
				-id	=> 'NP_198044.2');
my $file = 'NP_198044.2.fasta';

$factory->get_Response(-file => $file);


