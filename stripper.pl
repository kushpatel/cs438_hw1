#!/usr/bin/perl
my $preRead, $preHit;
open F, $ARGV[0] or die $!;
while (<F>) {
    $_ =~ /\s*(\d+)\s*\|\s*(\d+)/;
    $preRead = $1;
    $preHit = $2;
}
close F;
my $diffRead, $diffHit;
print "preRead: $preRead, preHit: $preHit, diffRead: $diffRead, diffHit: $diffHit\n";
open B, $ARGV[1] or die $!;
while (<B>) {
    $_ =~ /\s*(\d+)\s*\|\s*(\d+)/;
    $diffRead = $1 - $preRead;
    $diffHit = $2 - $preHit;
}
close B;
print $diffHit / ($diffHit + $diffRead), "\n";
