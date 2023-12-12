package Almanac::Map;

use strict;
use warnings;

sub build_map {
    my $input_ref = shift;

    my @input = @{$input_ref};

    my $map_name = shift @input;

    my ( $source, $destination ) = $map_name =~ /(\w+)-to-(\w+) map/;

    my $smallest_source_number;
    my %mappings;
    foreach my $mapping (@input) {
        my ( $destination_range_start, $source_range_start, $range_length ) = split / /, $mapping;

        $smallest_source_number = $source_range_start if !defined $smallest_source_number || $source_range_start < $smallest_source_number;

        $mappings{$source_range_start} = { destination_range_start => $destination_range_start, range_length => $range_length };
    }

    return { source => $source, destination => $destination, smallest_source_number => $smallest_source_number, mappings => \%mappings };
}

sub get_destination_number {
    my ( $map, $source_number ) = @_;

    if ( $source_number >= $map->{smallest_source_number} ) {
        my @source_range_starts = sort { $a <=> $b } keys %{ $map->{mappings} };

        foreach my $source_range_start (@source_range_starts) {
            if ( $source_number >= $source_range_start && $source_number < ( $source_range_start + $map->{mappings}->{$source_range_start}->{range_length} ) ) {
                my $difference = $source_number - $source_range_start;

                return $map->{mappings}->{$source_range_start}->{destination_range_start} + $difference;
            }
        }
    }

    return $source_number;
}

sub get_location_from_seed {
    my ( $maps_ref, $seed_number ) = @_;

    my %maps = %{$maps_ref};

    my $source_number = $seed_number;
    my $source        = 'seed';

    do {
        $source_number = get_destination_number( $maps{$source}, $source_number );
        $source        = $maps{$source}->{destination};
    } while ( $source ne 'location' );

    return $source_number;
}

1;
