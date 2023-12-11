package ScratchCards::Parser;

use strict;
use warnings;

use Common::String;

sub parse {
    my $input = shift;

    my @cards;
    foreach my $line ( @{$input} ) {
        my ( $card_id, $all_numbers ) = split /:/, $line;

        my ( $winning_numbers_string, $numbers_string ) = split /[|]/, $all_numbers;

        $winning_numbers_string = Common::String::trim($winning_numbers_string);
        $numbers_string         = Common::String::trim($numbers_string);

        my @winning_numbers = split /\s+/, $winning_numbers_string;
        my @numbers         = split /\s+/, $numbers_string;

        push @cards, { winning_numbers => \@winning_numbers, numbers => \@numbers };
    }

    return \@cards;
}

1;
