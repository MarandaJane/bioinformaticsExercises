#!/usr/bin/perl

use warnings;
use strict;
use Bio::Phylo::IO;
use Bio::Phylo::Treedrawer;

open( SVG, ">", 'tree.svg' ) or die$!;

open( NEWICK, "<", 'myoosin.fasta.tree' );

my $newickString = '';

while (<NEWICK>) {
	chomp;
	$newickString .= $_;
}
	$newickStrink .= ';';

my $forest = Bio::Phylo::IO->parse (
	-format => 'newick',
	-string => $newickString
);
my $tree = $forest->first;

my $treedrawer = Bio::Phylo::Treedrawer->new(
	-width => 1920,
	-height => 1280,
	-shape => 'CURVY', #curvogram
	-mode => 'PHYLO', #phylogram
	-format => 'SVG'
);

$treedrawer->set_scale_options(
	-width => '100%',
	-major => '10%', #major cross hatch interval
	-minor => '2%', #minor cross hatch interval
	-label => 'MYA',
);

$treedrawer->set_tree($tree);
print SVG $treedrawer->draw;