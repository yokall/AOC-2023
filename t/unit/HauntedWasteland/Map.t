#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

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

done_testing();
