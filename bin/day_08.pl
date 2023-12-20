#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use HauntedWasteland::Map;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/08_puzzle_input.txt' );

my $instructions    = $puzzle_input->[0];
my @map_description = @{$puzzle_input}[ 2 .. ( scalar @{$puzzle_input} - 1 ) ];

my $map = HauntedWasteland::Map->new( $instructions, \@map_description );

my $number_of_steps = $map->follow_instructions();

print 'Part 1 answer: ' . $number_of_steps . "\n";

$number_of_steps = $map->follow_multiple_paths();

print 'Part 2 answer: ' . $number_of_steps . "\n";
