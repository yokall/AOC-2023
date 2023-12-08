#!/usr/bin/perl

use strict;
use warnings;

use Test2::V0;

use lib 'lib';

use GearRatios::PartNumberFinder;

my $schematic;
{
## no critic 'RequireInterpolationOfMetachars'
    $schematic
        = [ '467..114..', '...*......', '..35..633.', '......#...', '617*......', '.....+.58.', '..592.....', '......755.', '...$.*....', '.664.598..', ];
}

subtest 'find_part_numbers' => sub {
    my @expected_part_numbers = qw/ 467 35 633 617 592 755 664 598 /;

    my $part_numbers = GearRatios::PartNumberFinder::find_part_numbers($schematic);

    is( $part_numbers, \@expected_part_numbers, 'should return a list of numbers with an adjacent symbol' );
};

subtest 'find_gear_ratios' => sub {
    my @expected_gear_ratios = qw/ 16345 451490 /;

    my $gear_ratios = GearRatios::PartNumberFinder::find_gear_ratios($schematic);

    is( $gear_ratios, \@expected_gear_ratios, 'should return a list of gear ratios' );
};

done_testing();
