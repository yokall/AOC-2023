package CamelCards::Hand;

use strict;
use warnings;

sub new {
    my $class = shift;
    my ($hand_description) = @_;

    my ( $hand, $bid ) = split / /, $hand_description;

    my $self = bless {
        hand     => $hand,
        bid      => $bid,
        strength => calculate_hand_strength($hand)
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
    my $hand = shift;

    my @card_values = split //, $hand;

    my %card_value_groups;
    foreach my $card_value (@card_values) {
        $card_value_groups{$card_value}++;
    }

    return 7 if keys %card_value_groups == 1;

    return 6 if keys %card_value_groups == 2 && ( ( values %card_value_groups )[0] == 4 || ( values %card_value_groups )[1] == 4 );

    return 5 if keys %card_value_groups == 2 && ( ( values %card_value_groups )[0] == 3 || ( values %card_value_groups )[1] == 3 );

    return 4
        if keys %card_value_groups == 3
        && ( ( values %card_value_groups )[0] == 3 || ( values %card_value_groups )[1] == 3 || ( values %card_value_groups )[2] == 3 );

    return 3
        if keys %card_value_groups == 3
        && ( ( values %card_value_groups )[0] == 2 || ( values %card_value_groups )[1] == 2 || ( values %card_value_groups )[2] == 2 );

    return 2 if keys %card_value_groups == 4;

    return 1 if keys %card_value_groups == 5;
}

1;
