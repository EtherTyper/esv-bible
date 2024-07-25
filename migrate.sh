#!/usr/bin/env bash

mkdir -p Psalm crossrefs/Psalm

for i in {1..150}
do
    OLDFILE="Psalms/Psalms $i.html"
    NEWFILE="Psalm/Psalm $i.html"

    [ -f "$OLDFILE" ] && mv -n "$OLDFILE" "$NEWFILE"

    OLDFILECROSSREF="crossrefs/Psalms/Psalms $i.html"
    NEWFILECROSSREF="crossrefs/Psalm/Psalm $i.html"

    [ -f "$OLDFILECROSSREF" ] && mv "$OLDFILECROSSREF" "$NEWFILECROSSREF"
done

rm -df Psalms crossrefs/Psalms
