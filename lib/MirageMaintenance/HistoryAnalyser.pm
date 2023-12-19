package MirageMaintenance::HistoryAnalyser;

use strict;
use warnings;

use List::Util qw(sum);

sub find_step_differences {
    my $history = shift;

    my @differences;
    for my $i ( 1 .. scalar @{$history} - 1 ) {
        my $value1 = $history->[ $i - 1 ];
        my $value2 = $history->[$i];

        push @differences, $value2 - $value1;
    }

    return \@differences;
}

sub fully_analyse_history {
    my $current_sequence_ref = shift;

    my @current_sequence = @{$current_sequence_ref};

    my $next_sequence;

    my @sequences;
    push @sequences, $current_sequence_ref;
    do {
        my $current_sequence = find_step_differences( \@current_sequence );
        push @sequences, $current_sequence;
        @current_sequence = @{$current_sequence};
    } while ( _all_values_are_not_zero( \@current_sequence ) );

    return \@sequences;
}

sub _all_values_are_not_zero {
    my $values = shift;

    foreach my $value ( @{$values} ) {
        return 1 if $value != 0;
    }

    return 0;
}

sub extrapolate_next_step {
    my $ranges = shift;

    my @next_steps;
    for my $ri ( reverse 0 .. scalar @{$ranges} - 2 ) {
        my $last_step_value = $ranges->[$ri]->[-1];
        my $step_size       = $ranges->[ $ri + 1 ]->[-1];

        my $next_step = $last_step_value + $step_size;

        push @next_steps, $next_step;
        push @{ $ranges->[$ri] }, $next_step;
    }

    return $next_steps[-1];
}

1;
