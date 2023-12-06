#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use Trebuchet::Calibration;

subtest 'calculate_calibration_total' => sub {
    my $input = [ '1abc2', 'pqr3stu8vwx', 'a1b2c3d4e5f', 'treb7uchet', ];

    my $actual = Trebuchet::Calibration::calculate_calibration_total($input);

    is( $actual, 142, 'should add up the calibration values' );
};

subtest 'calculate_calibration_total_2' => sub {
    my $input = [ 'two1nine', 'eightwothree', 'abcone2threexyz', 'xtwone3four', '4nineeightseven2', 'zoneight234', '7pqrstsixteen', ];

    my $actual = Trebuchet::Calibration::calculate_calibration_total_2($input);

    is( $actual, 281, 'should add up the calibration values' );
};

subtest 'extract_numbers_in_order_from_string' => sub {
    my $string = 'eightwo';
    my $actual = Trebuchet::Calibration::extract_numbers_in_order_from_string($string);

    is( $actual, [ 8, 2 ], 'should extract all digits even when the words overlap' );

    $string = 'eight2';
    $actual = Trebuchet::Calibration::extract_numbers_in_order_from_string($string);

    is( $actual, [ 8, 2 ], 'should handle digits and number names' );
};

done_testing();
