#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use PipeMaze::Analyser;

my $puzzle_input = Common::FileReader::read_file_to_2d_array( dirname(__FILE__) . '/../files/10_puzzle_input.txt' );

# $puzzle_input
#     = [ [ '7', '-', 'F', '7', '-' ], [ '.', 'F', 'J', '|', '7' ], [ 'S', 'J', 'L', 'L', '7' ], [ '|', 'F', '-', '-', 'J' ], [ 'L', 'J', '.', 'L', 'J' ], ];

my $loop = PipeMaze::Analyser::trace_loop($puzzle_input);

print 'Part 1 answer: ' . scalar @{$loop} / 2 . "\n";

# print 'Part 2 answer: ' . $total . "\n";
