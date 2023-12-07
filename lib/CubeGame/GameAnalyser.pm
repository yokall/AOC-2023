package CubeGame::GameAnalyser;

use strict;
use warnings;

sub parse_record {
    my $record = shift;

    my ( $id, $sets_string ) = split( /:/, $record );

    $id = ( split( / /, $id ) )[1];

    my @sets;
    foreach my $set_string ( split( /;/, $sets_string ) ) {
        my %set;
        foreach my $colour_count ( split( /,/, $set_string ) ) {
            $colour_count = _trim($colour_count);

            my ( $count, $colour ) = split( / /, $colour_count );

            $set{$colour} = $count;
        }

        push( @sets, \%set );
    }

    return {
        id   => $id,
        sets => \@sets
    };
}

sub _trim {
    my $string = shift;

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;

    return $string;
}

sub game_is_possible {
    my $game_sets         = shift;
    my $bag_configuration = shift;

    foreach my $set ( @{$game_sets} ) {
        foreach my $colour ( keys %{$set} ) {
            if ( $set->{$colour} > $bag_configuration->{$colour} ) {
                return 0;
            }
        }
    }

    return 1;
}

sub get_required_cube_count {
    my $game = shift;

    my %cube_count;

    foreach my $set ( @{ $game->{sets} } ) {
        foreach my $colour ( keys %{$set} ) {
            if ( !exists( $cube_count{$colour} ) || $cube_count{$colour} < $set->{$colour} ) {
                $cube_count{$colour} = $set->{$colour};
            }
        }
    }

    return \%cube_count;
}

1;
