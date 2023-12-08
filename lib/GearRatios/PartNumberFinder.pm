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

    my $max_y = scalar @schematic_chars;
    my $max_x = scalar @{ $schematic_chars[0] };

    my @numbers;
    my $current_number   = '';
    my $is_a_part_number = 0;
    for ( my $y = 0; $y < $max_y; $y++ ) {
        for ( my $x = 0; $x < $max_x; $x++ ) {
            if ( is_a_number( $schematic_chars[$y]->[$x] ) ) {
                $current_number .= $schematic_chars[$y]->[$x];

                my @modifiers = ( -1, 0, 1 );
                foreach my $yy (@modifiers) {
                    foreach my $xx (@modifiers) {
                        my $my = $y + $yy;
                        my $mx = $x + $xx;
                        if (   $mx >= 0
                            && $my >= 0
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

    my $max_y = scalar @schematic_chars;
    my $max_x = scalar @{ $schematic_chars[0] };

    my @numbers;
    my $current_number = '';
    my $current_gear_location;
    for ( my $y = 0; $y < $max_y; $y++ ) {
        for ( my $x = 0; $x < $max_x; $x++ ) {
            if ( is_a_number( $schematic_chars[$y]->[$x] ) ) {
                $current_number .= $schematic_chars[$y]->[$x];

                my @modifiers = ( -1, 0, 1 );
                foreach my $yy (@modifiers) {
                    foreach my $xx (@modifiers) {
                        my $my = $y + $yy;
                        my $mx = $x + $xx;
                        if (   $mx >= 0
                            && $my >= 0
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

    my @gear_ratios;
    for ( my $i = 0; $i < scalar @numbers; $i++ ) {
        for ( my $j = $i + 1; $j < scalar @numbers; $j++ ) {
            if ( $numbers[$i]->{gear_location} eq $numbers[$j]->{gear_location} ) {
                push( @gear_ratios, ( $numbers[$i]->{number} * $numbers[$j]->{number} ) );
            }
        }
    }

    return \@gear_ratios;
}

sub is_a_gear {
    my $char = shift;

    return ( $char =~ /^[\*]$/ );
}

1;
