#!/usr/bin/perl

my @strategies = ('clock', 'lru', 'mru');

print "<html><head><title>Performance Results</title>";
print '<link href="bootstrap.css" media="screen" rel="stylesheet" type="text/css">';
print "</head></body>";
print "<table><tr><th></th><th>Clock</th><th>LRU</th><th>MRU</th></tr>";

for ($bufsize=16; $bufsize<=240; $bufsize+=16) {
	print "<tr><th>$bufsize</th>";
	foreach (@strategies) {
		print "<td>";
		for ($i=1; $i<=3; $i++) {
		    open FILE, "tf.$bufsize.$_.$i" or die $!;	
			print <FILE>, " ";
		}
		print "</td>";
	}
	print "</tr>\n";
}
print "</table></body></html>";
