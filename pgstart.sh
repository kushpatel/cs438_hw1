#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "Usage: $0 <logname> <numbuffers>" >&2
	exit 1
else

	~/pgsql/bin/pg_ctl start -D ~/pgdata -l ~/cs438/hw1/Logs/$1.log -o "-B $2 -N 8 -o '-te -fm -fh'"
	sleep 1s
	~/pgsql/bin/psql test -p 4444 -f queries
fi