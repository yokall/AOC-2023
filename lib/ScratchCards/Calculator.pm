package ScratchCards::Calculator;

use strict;
use warnings;

my @matching_card_counts;

sub calculate_worth {
    my $card = shift;

    my @winning_numbers = @{ $card->{winning_numbers} };

    my $matching_number_count = _count_matching_numbers($card);

    if ( $matching_number_count == 1 ) {
        return 1;
    }
    elsif ( $matching_number_count == 2 ) {
        return 2;
    }
    elsif ( $matching_number_count > 2 ) {
        return 2**( $matching_number_count - 1 );
    }

    return 0;
}

sub _count_matching_numbers {
    my $card        = shift;
    my $card_number = shift;

    if ($card_number) {
        return $matching_card_counts[ $card_number - 1 ] if exists $matching_card_counts[ $card_number - 1 ];
    }

    my @winning_numbers = @{ $card->{winning_numbers} };

    my $matching_number_count = 0;
    foreach my $number ( @{ $card->{numbers} } ) {
        if ( grep( /^$number$/, @winning_numbers ) ) {
            $matching_number_count++;
        }
    }

    $matching_card_counts[ $card_number - 1 ] = $matching_number_count if $card_number;

    return $matching_number_count;
}

sub process_cards {
    my $cards               = shift;
    my $current_card_number = shift;

    my $card_count = 1;

    my $card = $cards->[ $current_card_number - 1 ];

    my $matching_number_count = _count_matching_numbers( $card, $current_card_number );

    if ( $matching_number_count > 0 ) {
        foreach my $card_number ( $current_card_number + 1 .. $current_card_number + $matching_number_count ) {
            $card_count += process_cards( $cards, $card_number );
        }
    }

    return $card_count;
}

1;
