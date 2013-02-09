#!/bin/bash

strats=(clock mru lru)
for strat in "${strats[@]}"; do
	cd ../postgresql-9.2.2
	git checkout "${strat}"
	cd ../hw1
	./pgtest.sh $strat
done
./printer.pl > results.html
rm tf*
