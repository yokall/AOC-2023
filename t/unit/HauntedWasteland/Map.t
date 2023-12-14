#!/usr/bin/perl

use strict;
use warnings;

use FindBin;
use Test2::V0;

use lib "$FindBin::Bin/../../lib";

use HauntedWasteland::Map;

subtest 'new' => sub {
    my $instructions = 'RL';
    my $map_description
        = [ 'AAA = (BBB, CCC)', 'BBB = (DDD, EEE)', 'CCC = (ZZZ, GGG)', 'DDD = (DDD, DDD)', 'EEE = (EEE, EEE)', 'GGG = (GGG, GGG)', 'ZZZ = (ZZZ, ZZZ)', ];

    my $map = HauntedWasteland::Map->new( $instructions, $map_description );

    my $expected_network = {
        AAA => { L => 'BBB', R => 'CCC' },
        BBB => { L => 'DDD', R => 'EEE' },
        CCC => { L => 'ZZZ', R => 'GGG' },
        DDD => { L => 'DDD', R => 'DDD' },
        EEE => { L => 'EEE', R => 'EEE' },
        GGG => { L => 'GGG', R => 'GGG' },
        ZZZ => { L => 'ZZZ', R => 'ZZZ' },
    };

    is( $map->network, $expected_network, 'should build a network from the map description' );
};

subtest 'follow_instructions' => sub {
    my $instructions = 'RL';
    my $map_description
        = [ 'AAA = (BBB, CCC)', 'BBB = (DDD, EEE)', 'CCC = (ZZZ, GGG)', 'DDD = (DDD, DDD)', 'EEE = (EEE, EEE)', 'GGG = (GGG, GGG)', 'ZZZ = (ZZZ, ZZZ)', ];

    my $map = HauntedWasteland::Map->new( $instructions, $map_description );

    my $number_of_steps = $map->follow_instructions();

    is( $number_of_steps, 2, 'should return the number of steps to find ZZZ' );

    $instructions    = 'LLR';
    $map_description = [ 'AAA = (BBB, BBB)', 'BBB = (AAA, ZZZ)', 'ZZZ = (ZZZ, ZZZ)', ];

    $map = HauntedWasteland::Map->new( $instructions, $map_description );

    $number_of_steps = $map->follow_instructions();

    is( $number_of_steps, 6, 'should return the number of steps to find ZZZ' );
};

done_testing();
