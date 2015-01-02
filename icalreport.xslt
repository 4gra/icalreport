<?xml version="1.0" encoding="UTF-8"?>
<!--
Converts the naive XML produced by icalreport.py into readable XHTML.
Copyright (C) 2015, https://github.com/4gra
This program comes with ABSOLUTELY NO WARRANTY; see included file LICENCE.
This is free software, and you are welcome to redistribute it under certain
conditions; view the included file LICENCE for details.
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
  <xsl:template match="/events">
  <html>
    <head>
      <title>Calendar View</title> 
      <style>
        td.sep {
          border-top: 1px solid black;
        }
      </style>
    </head>
    <body>
      <h1>Events</h1>
      <table>
      <thead>
        <tr><th>Start Date/Time</th><th rowspan="2">Summary, Location and Description</th></tr>
        <tr><th>End Date/Time</th></tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="event">
          <xsl:sort select="dtstart" />
        </xsl:apply-templates>
      </tbody>
      </table>
    </body>
  </html>
  </xsl:template>

<!-- inner templates -->
  <xsl:template match="event">
    <tr>
    <td class="sep date"><strong><xsl:text>S</xsl:text></strong><xsl:text>: </xsl:text><xsl:value-of select="dtstart"/></td>
    <td class="sep" rowspan="2" valign="top">
    <xsl:value-of select="summary"/>
    <xsl:apply-templates select="location"/>
    <xsl:apply-templates select="description"/>
    </td>
    </tr>
    <tr>
    <td class="date"><strong><xsl:text>E</xsl:text></strong><xsl:text>: </xsl:text><xsl:value-of select="dtend"/></td>
    </tr>
  </xsl:template>
 
  <xsl:template match="location">
    <br/><strong><xsl:text>Location</xsl:text></strong><xsl:text>: </xsl:text><xsl:value-of select="."/>
  </xsl:template>

  <xsl:template match="description">
    <br/><pre><strong><xsl:text>Description</xsl:text></strong><xsl:text>: </xsl:text>
    <xsl:value-of select="."/></pre>
  </xsl:template>
 
</xsl:stylesheet>
