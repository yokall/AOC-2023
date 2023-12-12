#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use Almanac::Map;

subtest 'build_map' => sub {
    my $input = [ 'seed-to-soil map:', '50 98 2', '52 50 48', ];

    my $map = Almanac::Map::build_map($input);

    my $expected_map = {
        source                 => 'seed',
        destination            => 'soil',
        smallest_source_number => 50,
        mappings               => {
            98 => { destination_range_start => 50, range_length => 2 },
            50 => { destination_range_start => 52, range_length => 48 }
        }
    };

    is( $map, $expected_map, 'should build a map with the correct source, destination and number mapping' );
};

subtest 'get_destination_number' => sub {
    my $map = {
        source                 => 'seed',
        destination            => 'soil',
        smallest_source_number => 50,
        mappings               => {
            98 => { destination_range_start => 50, range_length => 2 },
            50 => { destination_range_start => 52, range_length => 48 }
        }
    };

    my $destination_number = Almanac::Map::get_destination_number( $map, 96 );

    is( $destination_number, 98, 'should return the destination number from the map' );

    $destination_number = Almanac::Map::get_destination_number( $map, 10 );

    is( $destination_number, 10, 'should return the same number if the source number is not in the map' );
};

subtest 'get_location_from_seed' => sub {
    my $maps = {
        'seed' => {
            'source'   => 'seed',
            'mappings' => {
                '98' => {
                    'range_length'            => '2',
                    'destination_range_start' => '50'
                },
                '50' => {
                    'range_length'            => '48',
                    'destination_range_start' => '52'
                }
            },
            'destination'            => 'soil',
            'smallest_source_number' => 50
        },
        'light' => {
            'smallest_source_number' => 45,
            'destination'            => 'temperature',
            'source'                 => 'light',
            'mappings'               => {
                '77' => {
                    'range_length'            => '23',
                    'destination_range_start' => '45'
                },
                '64' => {
                    'destination_range_start' => '68',
                    'range_length'            => '13'
                },
                '45' => {
                    'destination_range_start' => '81',
                    'range_length'            => '19'
                }
            }
        },
        'soil' => {
            'source'   => 'soil',
            'mappings' => {
                '52' => {
                    'destination_range_start' => '37',
                    'range_length'            => '2'
                },
                '15' => {
                    'range_length'            => '37',
                    'destination_range_start' => '0'
                },
                '0' => {
                    'destination_range_start' => '39',
                    'range_length'            => '15'
                }
            },
            'destination'            => 'fertilizer',
            'smallest_source_number' => 0
        },
        'temperature' => {
            'source'   => 'temperature',
            'mappings' => {
                '0' => {
                    'range_length'            => '69',
                    'destination_range_start' => '1'
                },
                '69' => {
                    'range_length'            => '1',
                    'destination_range_start' => '0'
                }
            },
            'destination'            => 'humidity',
            'smallest_source_number' => 0
        },
        'water' => {
            'source'   => 'water',
            'mappings' => {
                '18' => {
                    'destination_range_start' => '88',
                    'range_length'            => '7'
                },
                '25' => {
                    'destination_range_start' => '18',
                    'range_length'            => '70'
                }
            },
            'smallest_source_number' => 18,
            'destination'            => 'light'
        },
        'fertilizer' => {
            'destination'            => 'water',
            'smallest_source_number' => 0,
            'source'                 => 'fertilizer',
            'mappings'               => {
                '53' => {
                    'destination_range_start' => '49',
                    'range_length'            => '8'
                },
                '0' => {
                    'destination_range_start' => '42',
                    'range_length'            => '7'
                },
                '11' => {
                    'destination_range_start' => '0',
                    'range_length'            => '42'
                },
                '7' => {
                    'destination_range_start' => '57',
                    'range_length'            => '4'
                }
            }
        },
        'humidity' => {
            'mappings' => {
                '56' => {
                    'destination_range_start' => '60',
                    'range_length'            => '37'
                },
                '93' => {
                    'destination_range_start' => '56',
                    'range_length'            => '4'
                }
            },
            'source'                 => 'humidity',
            'destination'            => 'location',
            'smallest_source_number' => 56
        }
    };

    my $location = Almanac::Map::get_location_from_seed( $maps, 79 );

    is( $location, 82, 'should return 82 for seed 79' );

    $location = Almanac::Map::get_location_from_seed( $maps, 14 );

    is( $location, 43, 'should return 43 for seed 14' );

    $location = Almanac::Map::get_location_from_seed( $maps, 55 );

    is( $location, 86, 'should return 86 for seed 55' );

    $location = Almanac::Map::get_location_from_seed( $maps, 13 );

    is( $location, 35, 'should return 35 for seed 13' );
};

done_testing();
