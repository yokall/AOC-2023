package CamelCards::Hand;

use strict;
use warnings;

use List::MoreUtils qw(any);

sub new {
    my ( $class, $hand_description, $joker_rules ) = @_;

    my ( $hand, $bid ) = split / /, $hand_description;

    my $self = bless {
        hand     => $hand,
        bid      => $bid,
        strength => calculate_hand_strength( $hand, $joker_rules )
    }, $class;

    return $self;
}

sub hand {
    my $self = shift;

    return $self->{hand};
}

sub bid {
    my $self = shift;

    return $self->{bid};
}

sub strength {
    my $self = shift;

    return $self->{strength};
}

sub calculate_hand_strength {
    my $hand        = shift;
    my $joker_rules = shift;

    my @card_values = split //, $hand;

    my %card_value_groups;
    foreach my $card_value (@card_values) {
        $card_value_groups{$card_value}++;
    }

    return 7 if keys %card_value_groups == 1;

    if ( keys %card_value_groups == 2 ) {
        if ( $joker_rules && exists $card_value_groups{'J'} ) {
            return 7;
        }

        if ( any { $_ == 4 } values %card_value_groups ) {
            return 6;
        }

        return 5;
    }
    elsif ( keys %card_value_groups == 3 ) {
        if ( any { $_ == 3 } values %card_value_groups ) {
            if ( $joker_rules && exists $card_value_groups{'J'} ) {
                return 6;
            }

            return 4;
        }

        if ( $joker_rules && exists $card_value_groups{'J'} ) {
            if ( $card_value_groups{'J'} == 2 ) {
                return 6;
            }

            return 5;
        }

        return 3;
    }
    elsif ( keys %card_value_groups == 4 ) {
        if ( $joker_rules && exists $card_value_groups{'J'} ) {
            return 4;
        }

        return 2;
    }

    if ( $joker_rules && exists $card_value_groups{'J'} ) {
        return 2;
    }

    return 1;
}

1;
