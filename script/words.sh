#!/bin/bash

DAY=${1-$(date +'%d')}
DAILY_GOAL=${2-1666}
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
NEEDED_FOR_DAY_COUNT=$(bc <<< "$DAILY_GOAL - $WORDS_WRITTEN_TODAY")

echo
echo "  Needed today:   $DAY_WORDS"
echo "  Written so far: $CURRENT_WORDS"
echo "  Written today:  $WORDS_WRITTEN_TODAY"
echo
echo "  Remaining:      $NEEDED_WORDS"
echo "  Day count left: $NEEDED_FOR_DAY_COUNT"
