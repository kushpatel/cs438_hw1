#!/bin/bash

#if [ "$#" -ne 0 ]; then
#	echo "Usage: $0 <logname>" >&2
#	exit 1
#else
	buffSize=240
	#while [ $BSIZE -lt 241 ]; do
		~/pgsql/bin/pg_ctl start -D ~/pgdata -l ~/cs438/hw1/Logs/testlog.log -o "-B $buffSize -N 8 -o '-te -fm -fh'"
		sleep 1s
		#for i in `seq 1 3`; do
			~/pgsql/bin/psql test -p 4444 -c "SELECT blks_read,blks_hit FROM pg_stat_database WHERE datname='test';" > pre
			#~/pgsql/bin/psql test -p 4444 -c "SELECT * FROM raw_r_tuples;" > tuples
			~/pgsql/bin/psql test -p 4444 -c "SELECT * FROM raw_r_tuples r, raw_s_tuples s WHERE r.pkey = s.pkey;" > tuples
			~/pgsql/bin/psql test -p 4444 -c "SELECT blks_read,blks_hit FROM pg_stat_database WHERE datname='test';" > post
		#done
		#$buffSize+=16
	#done
#fi