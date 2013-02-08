#!/bin/bash

if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <strategy>" >&2
	exit 1
else
	cd ../postgresql-9.2.2
	echo "Building $1"
	(make && make install) > /dev/null
	cd ../hw1
	buffSize=16
	while [ $buffSize -lt 241 ]; do
		echo "Testing buffer size $buffSize"
		~/pgsql/bin/pg_ctl start -D ~/pgdata -l log.log -o "-B $buffSize -N 8 -o '-te -fm -fh'" && sleep 1s
		if [ $? -ne 1 ]; then 
			for i in `seq 1 3`; do
				echo "Iteration $i"
				~/pgsql/bin/psql test -p 4444 -c "SELECT blks_read,blks_hit FROM pg_stat_database WHERE datname='test';" > pre
				~/pgsql/bin/psql test -p 4444 -c "SELECT * FROM raw_r_tuples;" > tuples
				~/pgsql/bin/psql test -p 4444 -c "SELECT * FROM raw_r_tuples r, raw_s_tuples s WHERE r.pkey = s.pkey;" > tuples
				~/pgsql/bin/psql test -p 4444 -c "SELECT blks_read,blks_hit FROM pg_stat_database WHERE datname='test';" > post
				./stripper.pl pre post > tf.$buffSize.$1.$i
			done
		fi
		~/pgsql/bin/pg_ctl -D ~/pgdata stop
		let buffSize=buffSize+16
	done
	./printer.pl $1 > results.html
	rm pre
	rm post
	rm tuples
fi