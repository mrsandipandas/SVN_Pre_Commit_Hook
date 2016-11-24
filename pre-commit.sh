#!/bin/bash 
REPOS="$1"
TXN="$2"
READ_ONLY_REPOS=("B/" "A/" "C/")

CHANGES=($(svnlook changed -t "$TXN" "$REPOS"| grep -E "^[A|D|U|_U|UU]" | awk '{print $2}'))

for a_read_only_repo in "${READ_ONLY_REPOS[@]}";
do
  for a_change in "${CHANGES[@]}";
  do
    if echo "$a_change" | grep -E "$a_read_only_repo.*"
    then
      echo "This is a readonly repo:" $a_read_only_repo 1>&2 && exit 1;
    fi
  done
done

exit 0


