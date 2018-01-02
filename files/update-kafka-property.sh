#!/usr/bin/env bash

# Small script that allows for overriding or adding Kafka configuration

echo "$1, $2, $3"

if [ -n $1 ] && [ -n $2 ] && [ -n $3 ]; then

    FILE=$1
    PROPERTY=$2
    VALUE=$3

    REPLACEMENT="$PROPERTY=$VALUE"
    echo $REPLACEMENT
    if grep -e "^$PROPERTY\=" $FILE -q
    then
        # Property already exist, then override
        sed -i -E "s|^$PROPERTY\=.*|$REPLACEMENT|g" "$FILE"
    else
        # Append property
        echo $REPLACEMENT >> $FILE
    fi

else

    echo "Not all arguments are set user [filename, property, value]"
    exit 1;
fi

