#!/usr/bin/env bash

KEY=$(<apikey.txt)

FILES=()
find . -type f -name '*.html' -empty -print -delete
while IFS=, read -r _ _ BOOK CHAPTERS _; do
    for i in $(seq 1 "$CHAPTERS")
    do
        if [[ "$CHAPTERS" != "1" ]]
        then
            QUERY="$BOOK $i"
        else
            QUERY="$BOOK"
        fi

        mkdir -p "$BOOK"
        FILE="$BOOK/$QUERY.html"
        FILES+=("$FILE")

        if [ ! -f "$FILE" ]
        then
            sleep 1
            echo "Getting $FILE"
            curl -H "Authorization: Token $KEY" -G "https://api.esv.org/v3/passage/html/" --data-urlencode "q=$QUERY" --data-urlencode "include-audio-link=false" | jq -r .passages[] > "$FILE"
        fi

        mkdir -p "crossrefs/$BOOK"
        FILECROSSREF="crossrefs/$FILE"

        if [ ! -f "$FILECROSSREF" ]
        then
            sleep 1
            echo "Getting $FILECROSSREF"
            curl -H "Authorization: Token $KEY" -G "https://api.esv.org/v3/passage/html/" --data-urlencode "q=$QUERY" --data-urlencode "include-audio-link=false" --data-urlencode "include-crossrefs=true" | jq -r .passages[] > "$FILECROSSREF"
        fi
    done
done < <(tail -n +2 Books.csv)

shopt -s extglob
tar -czf esv-bible.tar.gz "${FILES[@]}"
tar -czf esv-bible-crossrefs.tar.gz -C crossrefs "${FILES[@]}"
