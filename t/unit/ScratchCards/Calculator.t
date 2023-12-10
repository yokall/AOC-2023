#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use Test2::V0;

use lib "$FindBin::Bin/../../lib";

use ScratchCards::Calculator;

subtest 'calculate_worth should calculate the worth of the scratch card' => sub {
    my $card = { winning_numbers => [ 41, 48, 83, 86, 17 ], numbers => [ 83, 86, 6, 31, 17, 9, 48, 53 ] };

    my $worth = ScratchCards::Calculator::calculate_worth($card);

    is( $worth, 8, 'when there are more than 2 matching numbers' );

    $card = { winning_numbers => [ 1, 21, 53, 59, 44 ], numbers => [ 69, 82, 63, 72, 16, 21, 14, 1 ] };

    $worth = ScratchCards::Calculator::calculate_worth($card);

    is( $worth, 2, 'when there are 2 matching numbers' );

    $card = { winning_numbers => [ 41, 92, 73, 84, 69 ], numbers => [ 59, 84, 76, 51, 58, 5, 54, 83 ] };

    $worth = ScratchCards::Calculator::calculate_worth($card);

    is( $worth, 1, 'when there is 1 matching number' );

    $card = { winning_numbers => [ 87, 83, 26, 28, 32 ], numbers => [ 88, 30, 70, 12, 93, 22, 82, 36 ] };

    $worth = ScratchCards::Calculator::calculate_worth($card);

    is( $worth, 0, 'when there are no matching numbers' );
};

subtest 'process' => sub {
    my $cards = [
        { winning_numbers => [ 41, 48, 83, 86, 17 ], numbers => [ 83, 86, 6,  31, 17, 9,  48, 53 ] },
        { winning_numbers => [ 13, 32, 20, 16, 61 ], numbers => [ 61, 30, 68, 82, 17, 32, 24, 19 ] },
        { winning_numbers => [ 1,  21, 53, 59, 44 ], numbers => [ 69, 82, 63, 72, 16, 21, 14, 1 ] },
        { winning_numbers => [ 41, 92, 73, 84, 69 ], numbers => [ 59, 84, 76, 51, 58, 5,  54, 83 ] },
        { winning_numbers => [ 87, 83, 26, 28, 32 ], numbers => [ 88, 30, 70, 12, 93, 22, 82, 36 ] },
        { winning_numbers => [ 31, 18, 13, 56, 72 ], numbers => [ 74, 77, 10, 23, 35, 67, 36, 11 ] },
    ];

    my $count = 0;
    foreach my $card_number ( 1 .. scalar( @{$cards} ) ) {
        $count += ScratchCards::Calculator::process_cards( $cards, $card_number );
    }

    is( $count, 30, 'should count the total number of cards including copies' );
};

done_testing();
