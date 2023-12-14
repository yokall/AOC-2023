package HauntedWasteland::Map;

use strict;
use warnings;

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
    my ( $self, $current_node_name, $step_count ) = @_;

    my $instruction_index = $step_count < scalar @{ $self->{instructions} } ? $step_count : $step_count % scalar @{ $self->{instructions} };

    my $next_node_name = $self->{network}->{$current_node_name}->{ $self->{instructions}->[$instruction_index] };

    return $step_count + 1 if $next_node_name eq 'ZZZ';

    $step_count++;

    take_step( $self, $next_node_name, $step_count );
}

1;
