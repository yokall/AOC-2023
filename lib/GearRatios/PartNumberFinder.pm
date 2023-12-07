package GearRatios::PartNumberFinder;

use strict;
use warnings;

sub find_part_numbers {
    my $schematic = shift;

    my @schematic_chars;
    foreach my $line ( @{$schematic} ) {
        my @chars = split( //, $line );
        push( @schematic_chars, \@chars );
    }

    my @numbers;
    my $current_number   = '';
    my $is_a_part_number = 0;
    for ( my $y = 0; $y < scalar @schematic_chars; $y++ ) {
        for ( my $x = 0; $x < scalar @{ $schematic_chars[0] }; $x++ ) {
            if ( is_a_number( $schematic_chars[$y]->[$x] ) ) {
                $current_number .= $schematic_chars[$y]->[$x];

                my @modifiers = ( -1, 0, 1 );
                foreach my $yy (@modifiers) {
                    foreach my $xx (@modifiers) {
                        my $my = $y + $yy;
                        my $mx = $x + $xx;
                        if (   $mx >= 0
                            && $mx < scalar @{ $schematic_chars[0] }
                            && $my >= 0
                            && $my < scalar @schematic_chars
                            && defined( $schematic_chars[$my]->[$mx] ) )
                        {
                            my $check_char = $schematic_chars[$my]->[$mx];
                            if ( is_a_symbol($check_char) ) {
                                $is_a_part_number = 1;
                            }
                        }
                    }
                }
            }
            elsif ( $current_number ne '' ) {
                push( @numbers, $current_number ) if $is_a_part_number;
                $current_number   = '';
                $is_a_part_number = 0;
            }
        }
    }

    return \@numbers;
}

sub is_a_number {
    my $char = shift;

    return ( $char =~ /^[0-9]$/ );
}

sub is_a_symbol {
    my $char = shift;

    return !( $char =~ /^[0-9\.]$/ );
}

sub find_gear_ratios {
    my $schematic = shift;

    my @schematic_chars;
    foreach my $line ( @{$schematic} ) {
        my @chars = split( //, $line );
        push( @schematic_chars, \@chars );
    }

    my @numbers;
    my $current_number = '';
    my $current_gear_location;
    for ( my $y = 0; $y < scalar @schematic_chars; $y++ ) {
        for ( my $x = 0; $x < scalar @{ $schematic_chars[0] }; $x++ ) {
            if ( is_a_number( $schematic_chars[$y]->[$x] ) ) {
                $current_number .= $schematic_chars[$y]->[$x];

                my @modifiers = ( -1, 0, 1 );
                foreach my $yy (@modifiers) {
                    foreach my $xx (@modifiers) {
                        my $my = $y + $yy;
                        my $mx = $x + $xx;
                        if (   $mx >= 0
                            && $mx < scalar @{ $schematic_chars[0] }
                            && $my >= 0
                            && $my < scalar @schematic_chars
                            && defined( $schematic_chars[$my]->[$mx] ) )
                        {
                            my $check_char = $schematic_chars[$my]->[$mx];
                            if ( is_a_gear($check_char) ) {
                                $current_gear_location = $my . ',' . $mx;
                            }
                        }
                    }
                }
            }
            elsif ( $current_number ne '' ) {
                push( @numbers, { number => $current_number, gear_location => $current_gear_location } ) if defined($current_gear_location);
                $current_number        = '';
                $current_gear_location = undef;
            }
        }
    }

    # full list of numbers with gears
    # loop through each number and look for matching number AFTER - will be a little inefficient as the 2nd in the pair will look again for the first

    return \@numbers;
}

sub is_a_gear {
    my $char = shift;

    return ( $char =~ /^[\*]$/ );
}

1;
