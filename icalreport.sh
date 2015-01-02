#!/bin/bash
# Converts vCalendar/iCalendar-style data into a simple HTML report view. 
# See README.md for details.
#
# Copyright (C) 2015, https://github.com/4gra
# This program comes with ABSOLUTELY NO WARRANTY; see included file LICENCE.
# This is free software, and you are welcome to redistribute it under certain
# conditions; view the included file LICENCE for details.
#
file=$1
bn=$(basename "$file" ".ics")
bd=$(dirname $0)
[[ -z $file ]] && { echo "Usage: $(basename $0) <icsfile.ics>)" >&2; exit 1; }

python "${bd}/icalreport.py" "$1" | xsltproc "${bd}/icalreport.xslt" - > "${bn}.html"

[[ $? == 0 && -e "${bn}.html" ]] && { echo "${bn}.html written." >&2; }
