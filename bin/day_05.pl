#!/usr/bin/perl

use strict;
use warnings;

use Clone 'clone';
use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use Almanac::Map;

my $puzzle_input = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/05_puzzle_input.txt' );

# my $puzzle_input = [
#     'seeds: 79 14 55 13',
#     '',
#     'seed-to-soil map:',
#     '50 98 2',
#     '52 50 48',
#     '',
#     'soil-to-fertilizer map:',
#     '0 15 37',
#     '37 52 2',
#     '39 0 15',
#     '',
#     'fertilizer-to-water map:',
#     '49 53 8',
#     '0 11 42',
#     '42 0 7',
#     '57 7 4',
#     '',
#     'water-to-light map:',
#     '88 18 7',
#     '18 25 70',
#     '',
#     'light-to-temperature map:',
#     '45 77 23',
#     '81 45 19',
#     '68 64 13',
#     '',
#     'temperature-to-humidity map:',
#     '0 69 1',
#     '1 0 69',
#     '',
#     'humidity-to-location map:',
#     '60 56 37',
#     '56 93 4',
# ];

my $seeds_string = shift @{$puzzle_input};

my @seed_numbers = $seeds_string =~ /(\d+)/g;

my %maps;
my $current_map;
my @map_description;
foreach my $line ( @{$puzzle_input} ) {
    if ( $line eq '' ) {
        if ( scalar @map_description ) {
            my $current_map = Almanac::Map::build_map( \@map_description );
            my $copy        = clone($current_map);

            $maps{ $current_map->{source} } = $copy;

            @map_description = ();
        }
        next;
    }

    push @map_description, $line;
}

$current_map = Almanac::Map::build_map( \@map_description );
$maps{ $current_map->{source} } = Almanac::Map::build_map( \@map_description );

my $closest_location;
foreach my $seed_number (@seed_numbers) {
    my $location = Almanac::Map::get_location_from_seed( \%maps, $seed_number );

    $closest_location = $location if !defined $closest_location || $location < $closest_location;
}

print 'Part 1 answer: ' . $closest_location . "\n";

my @ranges;
while ( scalar @seed_numbers ) {
    my $start = shift @seed_numbers;
    my $range = shift @seed_numbers;

    push @ranges, { start => $start, end => $start + $range - 1 };
}

$closest_location = undef;
my %location_cache;
foreach my $range (@ranges) {
    foreach my $seed_number ( $range->{start} .. $range->{end} ) {
        my $location = exists $location_cache{$seed_number} ? $location_cache{$seed_number} : Almanac::Map::get_location_from_seed( \%maps, $seed_number );

        $location_cache{$seed_number} = $location;

        $closest_location = $location if !defined $closest_location || $location < $closest_location;
    }
}

print 'Part 2 answer: ' . $closest_location . "\n";
