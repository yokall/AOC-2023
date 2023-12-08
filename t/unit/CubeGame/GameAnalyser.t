#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use CubeGame::GameAnalyser;

subtest 'parse_record' => sub {
    my $game_record = 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green';

    my $game = CubeGame::GameAnalyser::parse_record($game_record);

    my $expected_game = {
        game_id   => 1,
        game_sets => [ { blue => 3, red => 4 }, { red => 1, green => 2, blue => 6 }, { green => 2 } ]
    };

    is( $game, $expected_game, 'should parse the string into a game hash containing the game ID and sets' );
};

subtest 'game_is_possible' => sub {
    my $bag_configuration = { blue => 14, red => 12, green => 13 };

    my $game_sets = [ { blue => 3, red => 4 }, { red => 1, green => 2 }, { blue => 6, green => 2 } ];
    my $result    = CubeGame::GameAnalyser::game_is_possible( $game_sets, $bag_configuration );

    is( $result, 1, 'should return true if the counts in the game rounds are possible given the bag configuration' );

    $game_sets = [ { green => 8, blue => 6, red => 20 }, { blue => 5, red => 4, green => 13 }, { green => 5, red => 1 } ];
    $result    = CubeGame::GameAnalyser::game_is_possible( $game_sets, $bag_configuration );

    is( $result, 0, 'should return false if the counts in the game rounds are not possible given the bag configuration' );
};

subtest 'get_required_cube_count' => sub {
    my $game = {
        'game_sets' => [
            {   'blue' => '3',
                'red'  => '4'
            },
            {   'green' => '2',
                'blue'  => '6',
                'red'   => '1'
            },
            { 'green' => '2' }
        ],
        'game_id' => '1'
    };

    my $required_cube_count = CubeGame::GameAnalyser::get_required_cube_count($game);

    my $expected_cube_count = {
        'green' => '2',
        'blue'  => '6',
        'red'   => '4'
    };

    is( $required_cube_count, $expected_cube_count, 'should return the lowest required cube count for the game' );

};

done_testing();
