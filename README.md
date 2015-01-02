icalreport
==========
Takes iCalendar/vCalendar-like data and produces an HTML report containing all
events.

Converts vCalendar/iCalendar data (tested on the output of the readpst tool)
into a simple HTML report view.  It only includes a very small subset of tags
(but it's easy to add more).

Most people will probably want a more comprehensive tool (see [Ical2html](http://www.w3.org/Tools/Ical2html/) for
example) but few produce a very simple, flat report.

See python source file for limitations.

Requirements
============
   * [python](https://www.python.org/) 2.x >= 2.6
   * python [vobject](http://vobject.skyhouseconsulting.com/) library
   * [xsltproc](http://xmlsoft.org/XSLT/xsltproc2.html)

LICENCE
=======
 Copyright (C) 2015, https://github.com/4gra
 This program comes with ABSOLUTELY NO WARRANTY; for details see included LICENCE.
 This is free software, and you are welcome to redistribute it under certain
 conditions; view the included file LICENCE for details.
