#!/bin/bash
filemask="$1"
additional_options="$2"
settings_file="$3"

tempdir=$(mktemp)
/opt/idea/bin/format.sh -m "$filemask" $additional_options -r -s /github/workspace/"$settings_file" /github/workspace/ 2>&1 | tee -a $tempdir/output
newly_formatted=$(cat $tempdir/output | grep "OK$" | wc -l)
formatted_well=$(cat $tempdir/output | grep "Formatted well$" | wc -l)
needs_reformatting=$(cat $tempdir/output | grep "Needs reformatting$" | wc -l)
echo "Formatted ($newly_formatted)": 
cat $tempdir/output | grep -o -P '(?<=Formatting ).*(?=...OK)'
echo
echo "==================="
echo
echo "Formatted well ($formatted_well)": 
cat $tempdir/output | grep -o -P '(?<=Checking ).*(?=...Formatted well)'
echo
echo "==================="
echo
echo "Needs reformatting ($needs_reformatting)": 
! cat $tempdir/output | grep -o -P '(?<=Checking ).*(?=...Needs reformatting)'
