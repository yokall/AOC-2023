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

subtest 'sort_hands - joker rules' => sub {
    my $hands = [
        CamelCards::Hand->new('32T3K 765'), CamelCards::Hand->new('KK677 28'), CamelCards::Hand->new('T55J5 684'), CamelCards::Hand->new('QQQJA 483'),
        CamelCards::Hand->new('KTJJT 220'),
    ];

    my $sorted_hands = CamelCards::SortHands::sort_hands( $hands, 1 );

    is( $sorted_hands->[0]->hand, '32T3K', 'one pair is the weakest' );
    is( $sorted_hands->[1]->hand, 'KTJJT', 'two pair, KT is weaker than KK' );
    is( $sorted_hands->[2]->hand, 'KK677', 'two pair, KK is stronger than KT' );
    is( $sorted_hands->[3]->hand, 'T55J5', 'three of a kind, T is weaker than Q' );
    is( $sorted_hands->[4]->hand, 'QQQJA', 'three of a kind, Q is stronger than T' );
};

subtest 'sort_hands - remaining hand strengths' => sub {
    my $hands
        = [ CamelCards::Hand->new('23456 765'), CamelCards::Hand->new('23332 28'), CamelCards::Hand->new('AA8AA 684'), CamelCards::Hand->new('AAAAA 483') ];

    my $sorted_hands = CamelCards::SortHands::sort_hands($hands);

    is( $sorted_hands->[0]->hand, '23456', 'high card' );
    is( $sorted_hands->[1]->hand, '23332', 'full house' );
    is( $sorted_hands->[2]->hand, 'AA8AA', 'four of a kind' );
    is( $sorted_hands->[3]->hand, 'AAAAA', 'five of a kind' );
};

subtest 'convert_to_number' => sub {
    is( CamelCards::SortHands::convert_to_number('A'),      14, 'should return 14 for A' );
    is( CamelCards::SortHands::convert_to_number('K'),      13, 'should return 13 for K' );
    is( CamelCards::SortHands::convert_to_number('Q'),      12, 'should return 12 for Q' );
    is( CamelCards::SortHands::convert_to_number('J'),      11, 'should return 11 for J' );
    is( CamelCards::SortHands::convert_to_number( 'J', 1 ), 1,  'should return 1 for J with joker rules' );
    is( CamelCards::SortHands::convert_to_number('T'),      10, 'should return 10 for T' );
    is( CamelCards::SortHands::convert_to_number('4'),      4,  'should return the name number for a number' );
};

done_testing();
