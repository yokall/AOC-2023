#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;
use List::Util qw/sum/;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use ScratchCards::Calculator;
use ScratchCards::Parser;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/04_puzzle_input.txt' );

my $cards = ScratchCards::Parser::parse($puzzle_input);

my $total = 0;
foreach my $card ( @{$cards} ) {
    $total += ScratchCards::Calculator::calculate_worth($card);
}

print 'Part 1 answer: ' . $total . "\n";

my $count = 0;
foreach my $card_number ( 1 .. scalar( @{$cards} ) ) {
    $count += ScratchCards::Calculator::process_cards( $cards, $card_number );
}

print 'Part 2 answer: ' . $count . "\n";
