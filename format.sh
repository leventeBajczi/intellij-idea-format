#!/bin/bash
filemask="$1"
additional_options="$2"
settings_file="$3"

tempfile=$(mktemp)
/opt/idea/bin/format.sh -m "$filemask" $additional_options -r -s /github/workspace/"$settings_file" /github/workspace/ | tee -a $tempfile
newly_formatted=$(cat $tempfile | grep "OK$" | wc -l)
formatted_well=$(cat $tempfile | grep "Formatted well$" | wc -l)
needs_reformatting=$(cat $tempfile | grep "Needs reformatting$" | wc -l)
echo "Formatted ($newly_formatted)": 
cat $tempfile | grep -o -P '(?<=Formatting ).*(?=...OK)'
echo
echo "==================="
echo
echo "Formatted well ($formatted_well)": 
cat $tempfile | grep -o -P '(?<=Checking ).*(?=...Formatted well)'
echo
echo "==================="
echo
echo "Needs reformatting ($needs_reformatting)": 
! cat $tempfile | grep -o -P '(?<=Checking ).*(?=...Needs reformatting)'
