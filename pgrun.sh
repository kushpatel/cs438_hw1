#!/bin/bash

strats=(clock mru lru)
for strat in "${strats[@]}"; do
	cd ../postgresql-9.2.2
	git checkout "${strat}"
	cd ../hw1
	./pgtest.sh $strat
done
./printer.pl q1 > results1.html
./printer.pl q2 > results2.html
rm tf*
