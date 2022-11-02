package Compare;

use warnings;
use strict;
use v5.34;

sub findDuplicates {
    my @list = @{$_[1]};
    my $duplicates = {};
    my @checked = ();

    for (my $i = 0; $i < scalar @list; $i++) {
        for (my $e = 0; $e < scalar @list; $e++) {
            if ($list[$i]{'uuid'} eq $list[$e]{'uuid'}) {
                next;
            }
            if ($list[$i]{'duration_seconds'} != $list[$e]{'duration_seconds'}) {
                next;
            }

            my $normalized = join('-', sort ($list[$i]{'uuid'}, $list[$e]{'uuid'}));
            if (grep(/^$normalized$/, @checked)) {
                next;
            } else {
                push(@checked, $normalized);
            }
            
            if (exists $duplicates->{$list[$e]{'uuid'}}) {
                push(@{$duplicates->{$list[$e]{'uuid'}}}, $list[$i]{'uuid'});
            } else {
                $duplicates->{$list[$e]{'uuid'}} = [$list[$i]{'uuid'}];
            }
        }
    }

    return $duplicates;
}
1;