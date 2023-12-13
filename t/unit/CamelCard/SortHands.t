#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use CamelCards::Hand;
use CamelCards::SortHands;

subtest 'sort_hands' => sub {
    my $hands = [
        CamelCards::Hand->new('32T3K 765'), CamelCards::Hand->new('T55J5 684'), CamelCards::Hand->new('KK677 28'), CamelCards::Hand->new('KTJJT 220'),
        CamelCards::Hand->new('QQQJA 483'),
    ];

    my $sorted_hands = CamelCards::SortHands::sort_hands($hands);

    is( $sorted_hands->[0]->hand, '32T3K', 'one pair is the weakest' );
    is( $sorted_hands->[1]->hand, 'KTJJT', 'two pair, KT is weaker than KK' );
    is( $sorted_hands->[2]->hand, 'KK677', 'two pair, KK is stronger than KT' );
    is( $sorted_hands->[3]->hand, 'T55J5', 'three of a kind, T is weaker than Q' );
    is( $sorted_hands->[4]->hand, 'QQQJA', 'three of a kind, Q is stronger than T' );
};

done_testing();
