#!/usr/bin/env bash

KEY=$(<apikey.txt)
while IFS=, read -r _ _ BOOK CHAPTERS _; do
    for i in $(seq 1 "$CHAPTERS")
    do
        mkdir -p "$BOOK"
        FILE="$BOOK/$BOOK $i.html"
        if [ ! -f "$FILE" ]
        then
            sleep 1
            echo "Getting $FILE"
            curl -H "Authorization: Token $KEY" -G "https://api.esv.org/v3/passage/html/" --data-urlencode "q=$BOOK+$i" --data-urlencode "include-audio-link=false" | jq -r .passages[] > "$FILE"
        fi
    done
done < <(tail -n +2 Books.csv)
