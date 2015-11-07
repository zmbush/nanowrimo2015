#!/bin/bash

DAY=$1
DAY_WORDS=$(bc <<< "$DAY * 50000 / 30")
CURRENT_WORDS=$(wc -w `cat Contents.txt` | grep total | sed -e 's/^ *//' | cut -d' ' -f1)
NEEDED_WORDS=$(bc <<< "$DAY_WORDS - $CURRENT_WORDS")

TMP=/tmp/nano-place-git
rm -rf $TMP
git clone -q . $TMP
LAST_DAY_WORDS=$(
  cd $TMP;
  git checkout -q $(git tag | tail -n 1);
  wc -w `cat Contents.txt` | grep total | sed -e 's/^ *//' | cut -d' ' -f1
)
WORDS_WRITTEN_TODAY=$(bc <<< "$CURRENT_WORDS - $LAST_DAY_WORDS")
NEEDED_FOR_DAY_COUNT=$(bc <<< "1666 - $WORDS_WRITTEN_TODAY")

echo "Words needed today:           $DAY_WORDS"
echo "Words written so far:         $CURRENT_WORDS"
echo "Words written today:          $WORDS_WRITTEN_TODAY"
echo
echo "Words remaining:              $NEEDED_WORDS"
echo "Words written for day count:  $NEEDED_FOR_DAY_COUNT"
