#!/bin/bash

# Requires mmb_utils from https://sweh.spuddy.org/Beeb/mmb_utils.html
# for the beeb list command to detokenize ARM Basic Programs

# Unzip the original archive (into a directory called programs)
unzip -qo original/programs.zip
chmod 755 programs
chmod 755 programs/BAS*
find programs -type f | xargs chmod 644

# Detokenize all the programs
for i in `find programs -type f | sort`
do
    mv $i tmpfile
    beeb list tmpfile -o 1 -t arm > $i

    # If there was an error, then log and replace with original
    if [[ "$?" != "0" ]]
    then
	    echo "Not BASIC: $i"
	    mv tmpfile $i
    else
        touch -r tmpfile $i
        rm -f tmpfile
    fi

done

rm -f tmpfile
