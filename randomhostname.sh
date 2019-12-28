#!/bin/bash
# Source: https://blogs.warwick.ac.uk/mikewillis/entry/random_words/

# This gets a random word and sets it to lower

WORDFILE=/usr/share/dict/words
# seed random from pid
# RANDOM=$$;
# using cat means wc outputs only a number, not number followed by filename
lines=$(cat $WORDFILE  | wc -l);
rnum=$((RANDOM*RANDOM%$lines+1));
WORD=$(sed -n "$rnum p" $WORDFILE;)
# WORD=$(sort -R /usr/share/dict/words | head -1)
WORD=$(echo "$WORD" | tr '[:upper:]' '[:lower:]')
date
echo "$WORD"

# This sets the hostname of the laptop to the random word
scutil --set HostName $WORD
scutil --set LocalHostName $WORD
scutil --set ComputerName $WORD
dscacheutil -flushcache

