#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use MirageMaintenance::HistoryAnalyser;

subtest 'find_step_differences' => sub {
    my $actual = MirageMaintenance::HistoryAnalyser::find_step_differences( [ 0, 3, 6, 9, 12, 15 ] );

    my $expected = [ 3, 3, 3, 3, 3 ];

    is( $actual, $expected, 'should return the difference between each step of a history' );
};

subtest 'fully_analyse_history' => sub {
    my $actual = MirageMaintenance::HistoryAnalyser::fully_analyse_history( [ 0, 3, 6, 9, 12, 15 ] );

    my $expected = [ [ 0, 3, 6, 9, 12, 15 ], [ 3, 3, 3, 3, 3 ], [ 0, 0, 0, 0 ] ];

    is( $actual, $expected, 'should return the difference between each step of a range' );
};

subtest 'extrapolate_next_step' => sub {
    subtest 'should return the next value in a history based on analysed history' => sub {
        my $actual = MirageMaintenance::HistoryAnalyser::extrapolate_next_step( [ [ 0, 3, 6, 9, 12, 15 ], [ 3, 3, 3, 3, 3 ], [ 0, 0, 0, 0 ] ] );

        my $expected = 18;

        is( $actual, $expected );

        $actual = MirageMaintenance::HistoryAnalyser::extrapolate_next_step(
            [ [ 10, 13, 16, 21, 30, 45 ], [ 3, 3, 5, 9, 15 ], [ 0, 2, 4, 6 ], [ 2, 2, 2 ], [ 0, 0 ] ] );

        $expected = 68;

        is( $actual, $expected );
    };
};

done_testing();
