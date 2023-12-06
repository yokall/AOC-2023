#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use CubeGame::GameAnalyser;

subtest 'game_is_possible' => sub {
    my $bag_configuration = { blue => 14, red => 12, green => 13 };

    my $game_sets = [ { blue => 3, red => 4 }, { red => 1, green => 2 }, { blue => 6, green => 2 } ];
    my $result    = CubeGame::GameAnalyser::game_is_possible( $game_sets, $bag_configuration );

    is( $result, 1, 'should return true if the counts in the game rounds are possible given the bag configuration' );

    $game_sets = [ { green => 8, blue => 6, red => 20 }, { blue => 5, red => 4, green => 13 }, { green => 5, red => 1 } ];
    $result    = CubeGame::GameAnalyser::game_is_possible( $game_sets, $bag_configuration );

    is( $result, 0, 'should return false if the counts in the game rounds are not possible given the bag configuration' );
};

done_testing();
