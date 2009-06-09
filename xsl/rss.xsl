<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:media='http://search.yahoo.com/mrss/'
	xmlns:chap='http://www.connectholland.nl/chap/'
	xmlns:php='http://php.net/xsl'
	exclude-result-prefixes='php'>
	<!--
	Main RSS creating XSL

	Since: Tue Oct 14 2008
	Author: Ron Rademaker
	-->

	<!--
	Import fallback templates (makes sure they have the lowest possible priority
	-->
	<xsl:import href='fallback.xsl'/>

	<!--
	Output XML 
	-->
	<xsl:output method="xml"/>
	
	<!--
	Main wmpage template
	*match* root wmpage

	Since: Tue Oct 14 2008
	-->
	<xsl:template match='/wmpage'>
		<rss version='2.0' xmlns:media='http://search.yahoo.com/mrss/' xmlns:chap='http://www.connectholland.nl/chap/'>
			<channel>
				<xsl:apply-templates select='self::node()' mode='rssInfo'/>
				<generator>Windmill RSS Generator</generator>
				<xsl:apply-templates select='node()' mode='rss'/>
			</channel>
		</rss>
	</xsl:template>

</xsl:stylesheet>	
