#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <strategy>" >&2
	exit 1
else
	./pgtest.sh $1
	./printer.pl q1 $1 > results1.html
	./printer.pl q2 $1 > results2.html
	rm tf*
fi
