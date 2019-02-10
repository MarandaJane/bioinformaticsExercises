#!/usr/bin/perl
use warnings;
use strict;
readGoDesc();

sub readGoDesc {
	my $goDescFile = "/scratch/go-basic.obo";

	# Open a filehandle for the GO_DESC file.
	open( GO_DESC, "<", $goDescFile ) or die $!;

	# Hash to store gene to GO term descriptions
	my %goDesc;
	local $/ = /[Term]|[Typedef]/;

	# Read the gene-to-description file line-by-line
	while (<GO_DESC>) {

		# Remove end-of-line characters
		chomp;

		# parse the record using a regular expression
		my $longGoDesc       = $_;
		#Regex to get id, name, namespace , and def. Use qr
		#as shown in Modern Perl. Use the modifier that allows whitespace and comments
		#in the regular expression. Use named captures. 
		#fill in the code                  #start the Regex with qr
		#fill in the code                  #get the id
		#fill in the code                  #get the name
		#fill in the code                  #get the namespace
		#fill in the code                  #get the def
		#fill in the code                  #These modifiers allow the ^ and $ anchors to match at any 
		                                   #newline embedded within the string and treats the source 
		                                   #string as a single line
		#Regex to get all is_a Go Terms
		my $findIsa = qr/
		^is_a:\s+(?<isa>.*?)\s+!
		/msx;
		#Regex to get all alt_id Go Terms
		my $findAltId = qr/
		^alt_id:\s+(?<alt_id>.*?)\s+
		/msx;

		if ( $longGoDesc =~ /$goDescParseRegex/ ) {
			print $+{id}, "\n", $+{name}, "\n", $+{namespace}, "\n". $+{def};
			print "\nalt_ids:\n";
			my @alt_ids = ();
			while ( $longGoDesc =~ /$findAltId/g ) {
				push( @alt_ids, $+{alt_id} ); #push the alt_id onto @alt_ids
			}
			if (@alt_ids) {
				print join( ",", @alt_ids ), "\n";
			}
			print "\nisa:\n";
			my @isas = ();
			while ( $longGoDesc =~ /$findIsa/g ) {
				push( @isas, $+{isa} );
			}
			print join( ",", @isas ), "\n\n";
		}
		else {
			print STDERR $longGoDesc, "\n";
		}
	}
	return \%goDesc;
}
