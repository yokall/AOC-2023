package HauntedWasteland::Map;

use strict;
use warnings;
## no critic (ProhibitNoWarnings);
no warnings 'recursion';

use Math::BigInt;

sub new {
    my ( $class, $instruction_string, $map_description ) = @_;

    my @instructions = split //, $instruction_string;

    my $self = bless {
        instructions => \@instructions,
        network      => build_network($map_description),
    }, $class;

    return $self;
}

sub build_network {
    my $map_description = shift;

    my %network;
    foreach my $node ( @{$map_description} ) {
        my ( $node_name, $left_node_name, $right_node_name ) = $node =~ /(\w+) = [(](\w+), (\w+)[)]/;

        $network{$node_name} = {
            L => $left_node_name,
            R => $right_node_name
        };
    }

    return \%network;
}

sub network {
    my $self = shift;

    return $self->{network};
}

sub follow_instructions {
    my $self = shift;

    return take_step( $self, 'AAA', 0 );
}

sub take_step {
    my ( $self, $current_node_name, $step_count, $part_two ) = @_;

    my $instruction_index = $step_count < scalar @{ $self->{instructions} } ? $step_count : $step_count % scalar @{ $self->{instructions} };

    my $next_node_name = $self->{network}->{$current_node_name}->{ $self->{instructions}->[$instruction_index] };

    $step_count++;

    if ($part_two) {
        $step_count = take_step( $self, $next_node_name, $step_count, $part_two ) unless $next_node_name =~ /Z$/;
    }
    else {
        $step_count = take_step( $self, $next_node_name, $step_count ) unless $next_node_name eq 'ZZZ';
    }

    return $step_count;
}

sub follow_multiple_paths {
    my $self = shift;

    my @node_names = keys %{ $self->{network} };

    my $paths = find_starting_nodes( \@node_names );

    for my $i ( 0 .. scalar( @{$paths} ) - 1 ) {
        my $step_count = take_step( $self, $paths->[$i], 0, 1 );

        $paths->[$i] = $step_count;
    }

    return array_lcm( @{$paths} );
}

sub find_starting_nodes {
    my $nodes = shift;

    my @starting_nodes;
    foreach my $node_name ( @{$nodes} ) {
        push @starting_nodes, $node_name if $node_name =~ /A$/;
    }

    return \@starting_nodes;
}

sub gcd {
    my ( $x, $y ) = @_;
    ( $x, $y ) = ( $y, $x % $y ) while $y;
    return $x;
}

sub lcm {
    my ( $x, $y ) = @_;
    return ( $x * $y ) / gcd( $x, $y );
}

sub array_lcm {
    my @numbers = @_;
    my $result  = Math::BigInt->new(1);

    for my $number (@numbers) {
        $result = lcm( $result, Math::BigInt->new($number) );
    }

    return $result;
}

1;
