#!/usr/bin/perl

use strict;
use warnings;

use File::Basename;
use FindBin;

use lib "$FindBin::Bin/../lib";

use Common::FileReader;
use CubeGame::GameAnalyser;

my $puzzle_input      = Common::FileReader::read_file_to_array( dirname(__FILE__) . '/../files/02_puzzle_input.txt' );
my $bag_configuration = { red => 12, green => 13, blue => 14 };

my $total = 0;
foreach my $line ( @{$puzzle_input} ) {
    my $game = CubeGame::GameAnalyser::parse_record($line);

    if ( CubeGame::GameAnalyser::game_is_possible( $game->{sets}, $bag_configuration ) ) {
        $total += $game->{id};
    }
}

print 'Part 1 answer: ' . $total . "\n";

$total = 0;
foreach my $line ( @{$puzzle_input} ) {
    my $game = CubeGame::GameAnalyser::parse_record($line);

    my $required_cube_count = CubeGame::GameAnalyser::get_required_cube_count($game);

    my $power = 1;
    $power = $power * $_ foreach values %{$required_cube_count};

    $total += $power;
}

print 'Part 2 answer: ' . $total . "\n";
