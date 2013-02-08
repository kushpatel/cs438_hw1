#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <strategy>" >&2
	exit 1
else
	./pgtest.sh $1
	./printer.pl $1 > results.html
	rm tf*
fi
