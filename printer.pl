#!/usr/bin/perl
@strategies = ('Clock', 'LRU', 'MRU');

print "<table><tr><th></th><th>Clock</th><th>LRU</th><th>MRU</th></tr>";

for ($bufsize=240; $bufsize<=240; $bufsize+=16) {
	print "<tr><th>$bufsize</th>";
	foreach (@strategies) {
		print "<td>";
		for ($i=1; $i<=3; $i++) {
		    open FILE, "$bufsize.$_.$i" or die $!;	
			print <FILE>, " ";
		}
		print "</td>";
	}
	print "</tr>\n";
}
print "</table>";
