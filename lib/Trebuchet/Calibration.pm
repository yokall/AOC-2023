package Trebuchet::Calibration;

use strict;
use warnings;

sub calculate_calibration_total {
    my $lines = shift;

    my $total = 0;
    foreach my $line ( @{$lines} ) {
        my ($first_digit) = $line =~ /(\d)/;
        my ($last_digit)  = $line =~ /(\d)\D*$/;

        $total += $first_digit . $last_digit;
    }

    return $total;
}

sub calculate_calibration_total_2 {
    my $lines = shift;

    my %word_to_number = (
        'one'   => 1,
        'two'   => 2,
        'three' => 3,
        'four'  => 4,
        'five'  => 5,
        'six'   => 6,
        'seven' => 7,
        'eight' => 8,
        'nine'  => 9,
    );

    my $total = 0;
    foreach my $line ( @{$lines} ) {
        my @match = $line =~ /one|two|three|four|five|six|seven|eight|nine|\d/smg;

        my $first_digit = $match[0];
        my $last_digit  = $match[-1];

        if ( exists( $word_to_number{$first_digit} ) ) {
            $first_digit = $word_to_number{$first_digit};
        }

        if ( exists( $word_to_number{$last_digit} ) ) {
            $last_digit = $word_to_number{$last_digit};
        }

        print $first_digit . $last_digit . "\n";

        $total += $first_digit . $last_digit;
    }

    return $total;
}

1;
