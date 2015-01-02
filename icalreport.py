#!/usr/bin/env python
"""
icalreport.py: Converts vCalendar/iCalendar-style data into a naive XML
representation.

Obvious limitations:
    Outputs to stdout only.
    Ignores timezone data in dates.
    Only includes TAGS as specified below.
    COMPLETELY ignores recurrence; categories, etc.
    Single-threaded; converts about 500 events per second.

Presumably this could be shaped into something more like 
  http://tools.ietf.org/html/draft-daboo-et-al-icalendar-in-xml-07
but I didn't need any of this for my purposes.

I see also that someone has made a far more thorough, XSL-only attempt:
  http://web.archive.org/web/20130906202043/http://designadmin.com/journal/2007/07/29/xslt-transformation-of-ics-to-xml/

Copyright (C) 2015, https://github.com/4gra
This program comes with ABSOLUTELY NO WARRANTY; see included file LICENCE.
This is free software, and you are welcome to redistribute it under certain
conditions; view the included file LICENCE for details.
"""
import vobject
from sys import stderr, argv
# Be nice
__version__ = 0.1
__author__ = 'https://github.com/4gra/'

# When adding more tags, remember to modify the XSLT to transform them somehow!
# TODO: generate XSLT according to template to add tags dynamically...
TAGS = ['summary', 'description', 'location', 'dtstart','dtend']

def process(fname):
    try:
        print '<events>'
        ic = open(fname, 'rb')
        c = vobject.readComponents(ic)

        while True:
            item = c.next()
            event = item.vevent
            #useful: event.components; item.getChildren()
            print '  <event>'
            for t in TAGS:
                try:
                    val = getattr(event, t).value
                    # format anything that looks like a date.
                    # note horrible ignorance of tz data.
                    try:
                        val = val.strftime('%Y-%m-%d %H:%M')
                    except AttributeError:
                        pass
                    print "    <%s>%s</%s>" % (t,val,t)
                except AttributeError:
                    # alternatively, produce <error>%s</error>
                    pass
            print '  </event>'
            #raise StopIteration

    except IOError, e:
        #print "<error>%s</error>" % e
        print >> stderr, "Error opening file: %s." % e
    except StopIteration:
        pass
    finally:
        print '</events>'

if __name__ == '__main__':
    try:
        process(argv[1])
    except IndexError:
        print >> stderr, "Usage: %s <icsfile>" % argv[0]
