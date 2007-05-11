<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:php='http://php.net/xsl'>
<!--
Stylesheet to handle rss
Since: Thu May 10 2007
Author: Giso Stallenberg

==Changelog==

= Giso Stallenberg Fri May 11 2007 =
* Moved default rss xsl to separate file to make it overwritable
-->
	<xsl:import href='defaultrss.xsl'/>
	<!--
		The output method

		Since: Thu May 10 2007
	-->
	<xsl:output method="xml" indent="yes"/>
</xsl:stylesheet>
