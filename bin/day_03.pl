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

# $total = 0;
# foreach my $line ( @{$puzzle_input} ) {
#     my $game = CubeGame::GameAnalyser::parse_record($line);

#     my $required_cube_count = CubeGame::GameAnalyser::get_required_cube_count($game);

#     my $power = 1;
#     $power = $power * $_ foreach values %{$required_cube_count};

#     $total += $power;
# }

# print 'Part 2 answer: ' . $total . "\n";
