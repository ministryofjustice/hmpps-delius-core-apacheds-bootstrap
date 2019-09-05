#!/bin/bash
#
# Usage:
#   cat file | ./ldif-sort.sh
#
# Sorts an LDIF file hierarchically, so entries can be imported in the correct order.
#
# This is done using the following steps:
# 1. Convert line-endings to unix
# 2. Squash LDIF entry paragraphs into single lines
# 3. Prepend each line with a count of the commas (,) in the dn attribute
# 4. Sort the lines numerically
# 5. Remove the prepended comma counts
# 6. Expand LDIF entries back into paragraphs
#

sed $'s/\r$//' \
| awk 'BEGIN{RS="\n\n" ; ORS="\2";}{ print }' \
| awk 'BEGIN{RS="\n" ; ORS="\1";}{ print }' \
| awk 'BEGIN{RS="\2" ; ORS="\n";}{ print }' \
| while IFS= read -r line; do
    dn=$(echo ${line} | grep -Eo 'dn:[^:]+?:')
    commas=${dn//[^,]}
    count=${#commas}
    echo "${count} ${line}"
  done \
| sort -n \
| sed 's/[^ ]* //' \
| awk '{$1=$1}1' FS='\1' OFS='\n' ORS='\n\n'
