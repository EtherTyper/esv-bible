#!/usr/bin/env bash

KEY=$(<apikey.txt)
curl -L -H "Authorization: Token $KEY" -G "https://api.esv.org/v3/passage/audio/" --data-urlencode "q=$*" | mpv -
