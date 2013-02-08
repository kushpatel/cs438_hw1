#!/usr/bin/perl

my @strategies = @ARGV ? ( $ARGV[0] ) : ('clock', 'lru', 'mru');

print <<HTML;
<html>
	<head>
		<title>Performance Results</title>
		<link href="bootstrap.css" media="screen" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="container">
			<h2>Buffer Strategy Performance Results in PostgreSQL</h2>
			<table class="table table-striped table-condensed"><tr><th></th>
HTML
foreach (@strategies) {
	print "<th>@{[ucfirst($_)]}</th>";
}
print '</tr>';
for ($bufsize=16; $bufsize<=240; $bufsize+=16) {
	print "<tr><th>$bufsize</th>";
	foreach (@strategies) {
		print "<td>";
		for ($i=1; $i<=3; $i++) {
		    open FILE, "tf.$bufsize.$_.$i" or die "No files for strategy $_";	
			printf("%4f ", <FILE>);
			print "| " unless ($i == 3);
		}
		print "</td>";
	}
	print "</tr>\n";
}
print "</table></table></body></html>";
