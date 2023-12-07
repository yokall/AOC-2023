#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum max/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use Trebuchet::Calibration;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/01_puzzle_input.txt' );

my $total = Trebuchet::Calibration::calculate_calibration_total($puzzle_input);

print 'Part 1 answer: ' . $total . "\n";

my $total = Trebuchet::Calibration::calculate_calibration_total_2($puzzle_input);

print 'Part 2 answer: ' . $total . "\n";
