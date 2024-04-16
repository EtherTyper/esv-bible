#!/usr/bin/env bash

KEY=$(<apikey.txt)
find . -type f -name '*.html' -empty -print -delete
while IFS=, read -r _ _ BOOK CHAPTERS _; do
    for i in $(seq 1 "$CHAPTERS")
    do
        mkdir -p "$BOOK"
        if [[ "$CHAPTERS" != "1" ]]
        then
            QUERY="$BOOK $i"
        else
            QUERY="$BOOK"
        fi
        FILE="$BOOK/$QUERY.html"

        if [ ! -f "$FILE" ]
        then
            sleep 1
            echo "Getting $FILE"
            curl -H "Authorization: Token $KEY" -G "https://api.esv.org/v3/passage/html/" --data-urlencode "q=$QUERY" --data-urlencode "include-audio-link=false" | jq -r .passages[] > "$FILE"
        fi
    done
done < <(tail -n +2 Books.csv)
