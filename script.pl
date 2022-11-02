use strict;
use warnings;
use JSON;
use Compare;

my $filename = 'data.json';
my $fileContent = '';

open(FH, '<', $filename) or die $!;

while (<FH>) {
    $fileContent .= $_;
}
close(FH);

my $deserialize = JSON->new->allow_nonref->decode($fileContent);
my @jsonContent = @{$deserialize};

my $duplicates = Compare->findDuplicates(\@jsonContent);
my $serialized = JSON->new->allow_nonref->pretty->encode($duplicates);

open(FH, '>', 'report.json') or die $!;
print FH $serialized;
close(FH);