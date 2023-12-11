#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use Test2::V0;

use lib "$FindBin::Bin/../../lib";

use ScratchCards::Parser;

subtest 'parse' => sub {
    my $input = [
        'Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53',
        'Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19',
        'Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1',
        'Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83',
        'Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36',
        'Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11',
    ];

    my $expected_cards = [
        { winning_numbers => [ 41, 48, 83, 86, 17 ], numbers => [ 83, 86, 6,  31, 17, 9,  48, 53 ] },
        { winning_numbers => [ 13, 32, 20, 16, 61 ], numbers => [ 61, 30, 68, 82, 17, 32, 24, 19 ] },
        { winning_numbers => [ 1,  21, 53, 59, 44 ], numbers => [ 69, 82, 63, 72, 16, 21, 14, 1 ] },
        { winning_numbers => [ 41, 92, 73, 84, 69 ], numbers => [ 59, 84, 76, 51, 58, 5,  54, 83 ] },
        { winning_numbers => [ 87, 83, 26, 28, 32 ], numbers => [ 88, 30, 70, 12, 93, 22, 82, 36 ] },
        { winning_numbers => [ 31, 18, 13, 56, 72 ], numbers => [ 74, 77, 10, 23, 35, 67, 36, 11 ] },
    ];

    my $cards = ScratchCards::Parser::parse($input);

    is( $cards, $expected_cards, 'should return a list of hashes representing the scratchcards from the input' );
};

done_testing();
