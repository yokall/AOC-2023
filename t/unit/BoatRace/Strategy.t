#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use BoatRace::Strategy;

subtest 'calculate_strategies' => sub {
    subtest 'should return 4 strategies for time 7 and distance 9' => sub {
        my $time     = 7;
        my $distance = 9;

        my $strategies = BoatRace::Strategy::calculate_strategies( $time, $distance );

        my $expected_strategies = [ 2 .. 5 ];

        is( $strategies, $expected_strategies, 'strategies as expected' );
    };

    subtest 'should return 8 strategies for time 15 and distance 40' => sub {
        my $time     = 15;
        my $distance = 40;

        my $strategies = BoatRace::Strategy::calculate_strategies( $time, $distance );

        my $expected_strategies = [ 4 .. 11 ];

        is( $strategies, $expected_strategies, 'strategies as expected' );
    };

    subtest 'should return 9 strategies for time 30 and distance 200' => sub {
        my $time     = 30;
        my $distance = 200;

        my $strategies = BoatRace::Strategy::calculate_strategies( $time, $distance );

        my $expected_strategies = [ 11 .. 19 ];

        is( $strategies, $expected_strategies, 'strategies as expected' );
    };
};

done_testing();
