package CubeGame::GameAnalyser;

use strict;
use warnings;

sub parse_record {
    my $game_record = shift;

    my ( $game_id, $game_sets_string ) = split /:/, $game_record;

    $game_id = ( split / /, $game_id )[1];

    my @game_sets;
    foreach my $game_set_string ( split /;/, $game_sets_string ) {
        my %game_set;
        foreach my $colour_count ( split /,/, $game_set_string ) {
            $colour_count = _trim($colour_count);

            my ( $count, $colour ) = split / /, $colour_count;

            $game_set{$colour} = $count;
        }

        push @game_sets, \%game_set;
    }

    return {
        game_id   => $game_id,
        game_sets => \@game_sets
    };
}

sub _trim {
    my $string = shift;

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;

    return $string;
}

sub game_is_possible {
    my $game_game_sets    = shift;
    my $bag_configuration = shift;

    foreach my $game_set ( @{$game_game_sets} ) {
        foreach my $colour ( keys %{$game_set} ) {
            if ( $game_set->{$colour} > $bag_configuration->{$colour} ) {
                return 0;
            }
        }
    }

    return 1;
}

sub get_required_cube_count {
    my $game = shift;

    my %cube_count;

    foreach my $game_set ( @{ $game->{game_sets} } ) {
        foreach my $colour ( keys %{$game_set} ) {
            if ( !exists( $cube_count{$colour} ) || $cube_count{$colour} < $game_set->{$colour} ) {
                $cube_count{$colour} = $game_set->{$colour};
            }
        }
    }

    return \%cube_count;
}

1;
