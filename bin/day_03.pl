#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use GearRatios::PartNumberFinder;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/03_puzzle_input.txt' );

my $part_numbers = GearRatios::PartNumberFinder::find_part_numbers($puzzle_input);

my $sum = sum @{$part_numbers};

print 'Part 1 answer: ' . $sum . "\n";

my $gear_ratios = GearRatios::PartNumberFinder::find_gear_ratios($puzzle_input);

my $sum = sum @{$gear_ratios};

my $extra = 2;

print 'Part 2 answer: ' . $sum . "\n";
