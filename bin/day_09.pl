#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use MirageMaintenance::HistoryAnalyser;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/09_puzzle_input.txt' );

# my $puzzle_input = [ '0 3 6 9 12 15', '1 3 6 10 15 21', '10 13 16 21 30 45' ];

my $total = 0;
foreach my $line ( @{$puzzle_input} ) {
    my @sequence = split / /, $line;

    my $sequences = MirageMaintenance::HistoryAnalyser::fully_analyse_history( \@sequence );

    $total += MirageMaintenance::HistoryAnalyser::extrapolate_next_step($sequences);
}

print 'Part 1 answer: ' . $total . "\n";

$total = 0;
foreach my $line ( @{$puzzle_input} ) {
    my @sequence = split / /, $line;

    my $sequences = MirageMaintenance::HistoryAnalyser::fully_analyse_history( \@sequence );

    $total += MirageMaintenance::HistoryAnalyser::extrapolate_previous_step($sequences);
}

print 'Part 2 answer: ' . $total . "\n";
