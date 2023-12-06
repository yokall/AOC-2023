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
        my @numbers = @{ extract_numbers_in_order_from_string($line) };

        my $first_digit = $numbers[0];
        my $last_digit  = $numbers[-1];

        print $first_digit . $last_digit . "\n";

        $total += $first_digit . $last_digit;
    }

    return $total;
}

sub extract_numbers_in_order_from_string {
    my $string = shift;

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

    my @number_names = qw(one two three four five six seven eight nine);

    my $pattern = join '|', @number_names;

    my @chars = split //, $string;
    my @numbers;
    for ( my $i = 0; $i < scalar @chars; $i++ ) {
        if ( $chars[$i] =~ /(\d)/ ) {
            push( @numbers, $chars[$i] );
            next;
        }

        my $substring = substr $string, $i;

        my $number_name;
        if ( ($number_name) = $substring =~ /^($pattern)/ ) {
            push( @numbers, $word_to_number{$number_name} );
        }
    }

    for ( my $i = 0; $i < scalar @numbers; $i++ ) {
        if ( exists( $word_to_number{ $numbers[$i] } ) ) {
            $numbers[$i] = $word_to_number{ $numbers[$i] };
        }
    }

    return \@numbers;
}

1;
