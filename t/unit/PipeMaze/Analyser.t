#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use Test2::V0;

use lib "$FindBin::Bin/../lib";

use PipeMaze::Analyser;

my $puzzle_input
    = [ [ '7', '-', 'F', '7', '-' ], [ '.', 'F', 'J', '|', '7' ], [ 'S', 'J', 'L', 'L', '7' ], [ '|', 'F', '-', '-', 'J' ], [ 'L', 'J', '.', 'L', 'J' ], ];

subtest 'find_the_start' => sub {
    my $actual = PipeMaze::Analyser::find_the_start($puzzle_input);

    my $expected = [ 0, 2 ];

    is( $actual, $expected, 'should return the co-ordinates of the start' );
};

subtest 'find_joining_pipes_from_start' => sub {
    my $start_coordinates = [ 0, 2 ];

    my $actual = PipeMaze::Analyser::find_joining_pipes_from_start( $puzzle_input, $start_coordinates );

    my $expected = [ [ 1, 2 ], [ 0, 3 ] ];

    is( $actual, $expected, 'should return the co-ordinates of the pipes joined to the start' );
};

subtest 'find_next_pipe' => sub {
    my $previous_coordinates = [ 0, 2 ];
    my $pipe_coordinates     = [ 1, 2 ];

    my $actual = PipeMaze::Analyser::find_next_pipe( $puzzle_input, $pipe_coordinates, $previous_coordinates );

    my $expected = [ 1, 1 ];

    is( $actual, $expected, 'should return the co-ordinates of the pipes joined to the start' );
};

subtest 'trace_loop' => sub {
    my $actual = PipeMaze::Analyser::trace_loop($puzzle_input);

    my $expected = [
        [ 0, 2 ], [ 1, 2 ], [ 1, 1 ], [ 2, 1 ], [ 2, 0 ], [ 3, 0 ], [ 3, 1 ], [ 3, 2 ],
        [ 4, 2 ], [ 4, 3 ], [ 3, 3 ], [ 2, 3 ], [ 1, 3 ], [ 1, 4 ], [ 0, 4 ], [ 0, 3 ]
    ];

    is( $actual, $expected, 'should return the co-ordinates of the pipes joined to the start' );
};

done_testing();
