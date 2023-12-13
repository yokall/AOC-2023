#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use CamelCards::Hand;

subtest 'new' => sub {
    subtest 'should create a hand object from a hand description' => sub {
        my $hand = CamelCards::Hand->new('32T3K 765');

        is( $hand->hand, '32T3K', 'the hand field is set correctly' );
        is( $hand->bid,  '765',   'the hand field is set correctly' );
    };

    subtest 'should calculate the hand strength' => sub {
        my $hand = CamelCards::Hand->new('AAAAA 765');

        is( $hand->strength, 7, 'Five of a kind' );

        $hand = CamelCards::Hand->new('AA8AA 765');

        is( $hand->strength, 6, 'Four of a kind' );

        $hand = CamelCards::Hand->new('23332 765');

        is( $hand->strength, 5, 'Full house' );

        $hand = CamelCards::Hand->new('TTT98 765');

        is( $hand->strength, 4, 'Three of a kind' );

        $hand = CamelCards::Hand->new('23432 765');

        is( $hand->strength, 3, 'Two pair' );

        $hand = CamelCards::Hand->new('A23A4 765');

        is( $hand->strength, 2, 'One pair' );

        $hand = CamelCards::Hand->new('23456 765');

        is( $hand->strength, 1, 'High card' );
    };

    subtest 'should calculate the hand strength with joker rules' => sub {
        my $hand = CamelCards::Hand->new( 'AAAAA 765', 1 );

        is( $hand->strength, 7, 'Five of a kind' );

        $hand = CamelCards::Hand->new( 'AAJAA 765', 1 );

        is( $hand->strength, 7, 'Four of a kind' );

        $hand = CamelCards::Hand->new( 'J333J 765', 1 );

        is( $hand->strength, 7, 'Full house' );

        $hand = CamelCards::Hand->new( 'TTT9J 765', 1 );

        is( $hand->strength, 6, 'Three of a kind' );

        $hand = CamelCards::Hand->new( '23J32 765', 1 );

        is( $hand->strength, 4, 'Two pair' );

        $hand = CamelCards::Hand->new( 'A23AJ 765', 1 );

        is( $hand->strength, 4, 'One pair' );

        $hand = CamelCards::Hand->new( '2J456 765', 1 );

        is( $hand->strength, 2, 'High card' );
    };
};

done_testing();
