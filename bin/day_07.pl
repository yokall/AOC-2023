#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use CamelCards::Hand;
use CamelCards::SortHands;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/07_puzzle_input.txt' );

# $puzzle_input = [ '32T3K 765', 'T55J5 684', 'KK677 28', 'KTJJT 220', 'QQQJA 483 ', ];

my @hands;
foreach my $line ( @{$puzzle_input} ) {
    push @hands, CamelCards::Hand->new($line);
}

my $sorted_hands = CamelCards::SortHands::sort_hands( \@hands );

my $total = 0;
for my $i ( 1 .. scalar @{$sorted_hands} ) {
    $total += $sorted_hands->[ $i - 1 ]->bid * $i;
}

print 'Part 1 answer: ' . $total . "\n";

# print 'Part 2 answer: ' . scalar @{$strategies} . "\n";
