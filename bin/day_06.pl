#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use BoatRace::Strategy;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/06_puzzle_input.txt' );

# $puzzle_input = [ 'Time:      7  15   30', 'Distance:  9  40  200' ];

my @times     = $puzzle_input->[0] =~ /(\d+)/g;
my @distances = $puzzle_input->[1] =~ /(\d+)/g;

my $total = 1;
for my $i ( 0 .. $#times ) {
    my $time     = $times[$i];
    my $distance = $distances[$i];

    my $strategies = BoatRace::Strategy::calculate_strategies( $time, $distance );

    $total *= scalar @{$strategies};
}

print 'Part 1 answer: ' . $total . "\n";

my $time     = join '', @times;
my $distance = join '', @distances;

my $strategies = BoatRace::Strategy::calculate_strategies( $time, $distance );

print 'Part 2 answer: ' . scalar @{$strategies} . "\n";
