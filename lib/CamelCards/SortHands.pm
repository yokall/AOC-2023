package CamelCards::SortHands;

use strict;
use warnings;

sub sort_hands {
    my $hands       = shift;
    my $joker_rules = shift;

    my @five_of_a_kind;
    my @four_of_a_kind;
    my @full_house;
    my @three_of_a_kind;
    my @two_pair;
    my @one_pair;
    my @high_card;

    foreach my $hand ( @{$hands} ) {
        push @high_card,       $hand if $hand->strength == 1;
        push @one_pair,        $hand if $hand->strength == 2;
        push @two_pair,        $hand if $hand->strength == 3;
        push @three_of_a_kind, $hand if $hand->strength == 4;
        push @full_house,      $hand if $hand->strength == 5;
        push @four_of_a_kind,  $hand if $hand->strength == 6;
        push @five_of_a_kind,  $hand if $hand->strength == 7;
    }

    @high_card       = @{ sort_hand_type( \@high_card,       $joker_rules ) };
    @one_pair        = @{ sort_hand_type( \@one_pair,        $joker_rules ) };
    @two_pair        = @{ sort_hand_type( \@two_pair,        $joker_rules ) };
    @three_of_a_kind = @{ sort_hand_type( \@three_of_a_kind, $joker_rules ) };
    @full_house      = @{ sort_hand_type( \@full_house,      $joker_rules ) };
    @four_of_a_kind  = @{ sort_hand_type( \@four_of_a_kind,  $joker_rules ) };
    @five_of_a_kind  = @{ sort_hand_type( \@five_of_a_kind,  $joker_rules ) };

    my @sorted_hands;
    push @sorted_hands, @high_card;
    push @sorted_hands, @one_pair;
    push @sorted_hands, @two_pair;
    push @sorted_hands, @three_of_a_kind;
    push @sorted_hands, @full_house;
    push @sorted_hands, @four_of_a_kind;
    push @sorted_hands, @five_of_a_kind;

    return \@sorted_hands;
}

sub sort_hand_type {
    my $hands       = shift;
    my $joker_rules = shift;

    my $hands_count = scalar @{$hands};

    return $hands if $hands_count < 2;

    for my $i ( 0 .. $hands_count - 1 ) {
        for my $j ( 0 .. $hands_count - $i - 2 ) {
            my @hand_a = split //, $hands->[$j]->{hand};
            my @hand_b = split //, $hands->[ $j + 1 ]->{hand};

            foreach my $ci ( 0 .. $#hand_a ) {
                my $a = $hand_a[$ci];
                my $b = $hand_b[$ci];

                next if $a eq $b;

                if ( a_is_bigger_than_b( $a, $b, $joker_rules ) ) {
                    my $hand_a_obj = $hands->[$j];
                    my $hand_b_obj = $hands->[ $j + 1 ];

                    $hands->[$j] = $hand_b_obj;
                    $hands->[ $j + 1 ] = $hand_a_obj;
                }

                last;
            }
        }
    }

    return $hands;
}

sub a_is_bigger_than_b {
    my ( $a, $b, $joker_rules ) = @_;

    $a = convert_to_number( $a, $joker_rules );
    $b = convert_to_number( $b, $joker_rules );

    return ( $a > $b );
}

sub convert_to_number {
    my $char        = shift;
    my $joker_rules = shift;

    if ( $char eq 'A' ) {
        return 14;
    }
    elsif ( $char eq 'K' ) {
        return 13;
    }
    elsif ( $char eq 'Q' ) {
        return 12;
    }
    elsif ( $char eq 'J' ) {
        return 1 if $joker_rules;
        return 11;
    }
    elsif ( $char eq 'T' ) {
        return 10;
    }

    return $char;
}

1;
