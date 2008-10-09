<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:php='http://php.net/xsl'>
	<!--
	XSL to transform HTML into RSS

	Since: Thu Oct 09 2008
	Author: Ron Rademaker
	-->

	<!--
	Import rss, in import so they can be overwritten in other imports
	-->
	<xsl:import href='rsstemplates.xsl'/>

	<!--
	Ouput XML
	-->
	<xsl:output method='xml'/>

	<!--
	Creates the RSS feed
	*match* any root node
	
	Since: Thu Oct 09 2008
	-->
	<xsl:template match='/node()'>
		<rss version='2.0'>
			<channel>
				<xsl:apply-templates select='self::node()' mode='channelInfo'/>
				<xsl:apply-templates select='self::node()' mode='channelItem'/>
			</channel>
		</rss>
	</xsl:template>
</xsl:stylesheet>	
