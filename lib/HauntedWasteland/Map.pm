package HauntedWasteland::Map;

use strict;
use warnings;

sub new {
    my ( $class, $instructions, $map_description ) = @_;

    my $self = bless {
        instructions => $instructions,
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

1;
