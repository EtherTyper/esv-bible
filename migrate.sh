#!/usr/bin/env bash

mkdir -p Psalm crossrefs/Psalm

for i in {1..150}
do
    OLDFILE="Psalms/Psalms $i.html"
    NEWFILE="Psalm/Psalm $i.html"

    if [ -f "$OLDFILE" ]
    then
        mv "$OLDFILE" "$NEWFILE"
    fi

    OLDFILECROSSREF="crossrefs/Psalms/Psalms $i.html"
    NEWFILECROSSREF="crossrefs/Psalm/Psalm $i.html"

    if [ -f "$OLDFILECROSSREF" ]
    then
        mv "$OLDFILECROSSREF" "$NEWFILECROSSREF"
    fi
done

rm -df Psalms crossrefs/Psalms
