package PipeMaze::Analyser;

use strict;
use warnings;

sub find_the_start {
    my $maze = shift;

    foreach my $y ( 0 .. scalar @{$maze} - 1 ) {
        foreach my $x ( 0 .. scalar @{ $maze->[0] } - 1 ) {
            return [ $x, $y ] if $maze->[$y]->[$x] eq 'S';
        }
    }
}

sub find_joining_pipes_from_start {
    my ( $maze, $start_coordinates ) = @_;

    my $start_x = $start_coordinates->[0];
    my $start_y = $start_coordinates->[1];

    my ( $north, $east, $south, $west );

    $north = $maze->[ $start_y - 1 ]->[$start_x] if $start_y - 1 >= 0;
    $east  = $maze->[$start_y]->[ $start_x + 1 ] if $start_x + 1 < scalar @{ $maze->[0] };
    $south = $maze->[ $start_y + 1 ]->[$start_x] if $start_y + 1 < scalar @{$maze};
    $west  = $maze->[$start_y]->[ $start_x - 1 ] if $start_x - 1 >= 0;

    my @joining_pipes;
    push @joining_pipes, [ $start_x, $start_y - 1 ] if $north && ( $north eq '|' || $north eq '7' || $north eq 'F' );
    push @joining_pipes, [ $start_x + 1, $start_y ] if $east && ( $east eq '-' || $east eq '7' || $east eq 'J' );
    push @joining_pipes, [ $start_x, $start_y + 1 ] if $south && ( $south eq '|' || $south eq 'J' || $south eq 'L' );
    push @joining_pipes, [ $start_x - 1, $start_y ] if $west && ( $west eq '-' || $west eq 'F' || $west eq 'L' );

    return \@joining_pipes;
}

sub find_joining_pipes_from_pipe {
    my ( $maze, $pipe_coordinates ) = @_;

    my $pipe_x = $pipe_coordinates->[0];
    my $pipe_y = $pipe_coordinates->[1];

    my ( $north, $east, $south, $west );

    $north = $maze->[ $pipe_y - 1 ]->[$pipe_x] if $pipe_y - 1 >= 0;
    $east  = $maze->[$pipe_y]->[ $pipe_x + 1 ] if $pipe_x + 1 < scalar @{ $maze->[0] };
    $south = $maze->[ $pipe_y + 1 ]->[$pipe_x] if $pipe_y + 1 < scalar @{$maze};
    $west  = $maze->[$pipe_y]->[ $pipe_x - 1 ] if $pipe_x - 1 >= 0;

    my @joining_pipes;
    my $pipe = $maze->[$pipe_y]->[$pipe_x];
    if ( $pipe eq '|' ) {
        push @joining_pipes, [ $pipe_x, $pipe_y - 1 ] if $north && ( $north eq '|' || $north eq '7' || $north eq 'F' );
        push @joining_pipes, [ $pipe_x, $pipe_y + 1 ] if $south && ( $south eq '|' || $south eq 'J' || $south eq 'L' );
    }
    elsif ( $pipe eq '-' ) {
        push @joining_pipes, [ $pipe_x + 1, $pipe_y ] if $east && ( $east eq '-' || $east eq '7' || $east eq 'J' );
        push @joining_pipes, [ $pipe_x - 1, $pipe_y ] if $west && ( $west eq '-' || $west eq 'F' || $west eq 'L' );
    }
    elsif ( $pipe eq '7' ) {
        push @joining_pipes, [ $pipe_x - 1, $pipe_y ] if $west && ( $west eq '-' || $west eq 'L' || $west eq 'F' );
        push @joining_pipes, [ $pipe_x, $pipe_y + 1 ] if $south && ( $south eq '|' || $south eq 'J' || $south eq 'L' );
    }
    elsif ( $pipe eq 'F' ) {
        push @joining_pipes, [ $pipe_x + 1, $pipe_y ] if $east && ( $east eq '-' || $east eq '7' || $east eq 'J' );
        push @joining_pipes, [ $pipe_x, $pipe_y + 1 ] if $south && ( $south eq '|' || $south eq 'J' || $south eq 'L' );
    }
    elsif ( $pipe eq 'J' ) {
        push @joining_pipes, [ $pipe_x - 1, $pipe_y ] if $west && ( $west eq '-' || $west eq 'F' || $west eq 'L' );
        push @joining_pipes, [ $pipe_x, $pipe_y - 1 ] if $north && ( $north eq '|' || $north eq '7' || $north eq 'F' );
    }
    elsif ( $pipe eq 'L' ) {
        push @joining_pipes, [ $pipe_x, $pipe_y - 1 ] if $north && ( $north eq '|' || $north eq '7' || $north eq 'F' );
        push @joining_pipes, [ $pipe_x + 1, $pipe_y ] if $east && ( $east eq '-' || $east eq '7' || $east eq 'J' );
    }

    return \@joining_pipes;
}

sub find_next_pipe {
    my ( $maze, $pipe_coordinates, $previous_coordinates ) = @_;

    my $joining_pipes = find_joining_pipes_from_pipe( $maze, $pipe_coordinates );

    return $joining_pipes->[0]->[0] eq $previous_coordinates->[0]
        && $joining_pipes->[0]->[1] eq $previous_coordinates->[1] ? $joining_pipes->[1] : $joining_pipes->[0];
}

sub trace_loop {
    my $maze = shift;

    my @loop;

    my $start = find_the_start($maze);
    push @loop, $start;

    my $next_pipes = find_joining_pipes_from_start( $maze, $start );
    my $next       = $next_pipes->[0];

    while ($next) {
        push @loop, [ $next->[0], $next->[1] ];
        ($next) = find_next_pipe( $maze, $next, $loop[-2] );
    }

    return \@loop;
}

1;
