#!/bin/bash
tempdir=$(mktemp)
/home/levente/.local/share/JetBrains/Toolbox/apps/IDEA-U/ch-0/231.9011.34/bin/format.sh -m *java,*kts,*kt -dry -r -s ./doc/ThetaIntelliJCodeStyle.xml ./ 2>&1 | tee -a $tempdir/output
formatted_well=$(cat $tempdir/output | grep "Formatted well" | wc -l)
needs_reformatting=$(cat $tempdir/output | grep "Needs reformatting" | wc -l)
echo "Formatted well ($formatted_well)": 
cat $tempdir/output | grep -o -P '(?<=Checking ).*(?=...Formatted well)'
echo
echo "==================="
echo
echo "Needs reformatting ($needs_reformatting)": 
! cat $tempdir/output | grep -o -P '(?<=Checking ).*(?=...Needs reformatting)'
