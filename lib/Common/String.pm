package Common::String;

use strict;
use warnings;

sub trim {
    my $string = shift;

    $string =~ s/^\s+//;
    $string =~ s/\s+$//;

    return $string;
}

1;
