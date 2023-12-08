package Common::FileReader;

use strict;
use warnings;

sub read_file_to_array {
    my $filename = shift;

    open my $FH, '<', $filename or croak $!;
    my $lines = _read_lines_to_string_array($FH);
    close $FH;

    return $lines;
}

sub _read_lines_to_string_array {
    my $FH = shift;

    my @lines;
    while (<$FH>) {
        chomp;
        push @lines, $_;
    }

    return \@lines;
}

sub read_file_to_2d_array {
    my $filename = shift;

    open my $FH, '<', $filename or croak $!;
    my $char_array = _read_lines_to_char_array($FH);
    close $FH;

    return $char_array;
}

sub _read_lines_to_char_array {
    my $FH = shift;

    my @lines;
    while (<$FH>) {
        chomp;
        my $line       = $_;
        my @characters = split //, $line;
        push @lines, \@characters;
    }

    return \@lines;
}

1;
