package BoatRace::Strategy;

use strict;
use warnings;

sub calculate_strategies {
    my ( $time, $record_distance ) = @_;

    my @winning_strategies;
    for my $hold_time ( 0 .. $time ) {
        my $race_time        = $time - $hold_time;
        my $speed            = $hold_time;
        my $attempt_distance = $race_time * $speed;

        push @winning_strategies, $hold_time if $attempt_distance > $record_distance;
    }

    return \@winning_strategies;
}

1;
