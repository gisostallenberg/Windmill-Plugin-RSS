<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet version='1.0' 
		xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
		xmlns:media='http://search.yahoo.com/mrss/'
		xmlns:chap='http://www.connectholland.nl/chap/'
		xmlns:php='http://php.net/xsl'>
	<!--
	Main RSS creating XSL
	
	Since: Fri Dec 19 2008
	Author: Niels Nijens
	-->
	
	<!--
	Output XML
	-->
	<xsl:output method='xml'/>
	
	<!--
	Create rss and channel nodes
	
	*match* root wmpage
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='/wmpage'>
		<rss version='2.0' xmlns:media='http://search.yahoo.com/mrss/' xmlns:chap='http://www.connectholland.nl/chap/'>
			<channel>
				<xsl:apply-templates select='self::node()' mode='rssInfo'/>
				<generator>Windmill RSS Generator</generator>
				<xsl:apply-templates select='node()' mode='rssItem'/>
			</channel>
		</rss>
	</xsl:template>
	
	<!--
	Add information about the channel
	
	*match* wmpage
	*mode* rssInfo
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='wmpage' mode='rssInfo'>
		<title><xsl:apply-templates select='self::node()' mode='rssInfoTitle'/></title>
		<link><xsl:apply-templates select='self::node()' mode='rssInfoLink'/></link>
		<language><xsl:value-of select='php:function("strtolower", translate(@language, "_", "-") )'/></language>
		<copyright>Copyright (c) 2008, <xsl:value-of select='php:function("WMXSLFunctions::getHttpHost")'/></copyright>
		<description><xsl:apply-templates select='self::node()' mode='rssInfoDescription'/></description>
	</xsl:template>
	
	<!--
	Add the title to the channel node
	
	*match* wmpage
	*mode* rssInfoTitle
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='wmpage' mode='rssInfoTitle'/>
	
	<!--
	Add the link to the channel node
	
	*match* wmpage
	*mode* rssInfoDescription
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='wmpage' mode='rssInfoLink'>
		<xsl:text>http://</xsl:text>
		<xsl:value-of select='php:function("WMXSLFunctions::getHttpHost")'/>
	</xsl:template>
	
	<!--
	Add the description to the channel node
	
	*match* wmpage
	*mode* rssInfoDescription
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='wmpage' mode='rssInfoDescription'/>
	
	<!--
	Adds the nodes of this node (module tagname) as item to the channel
	
	*match* node()
	*mode* rssItem
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='node()' mode='rssItem'>
		<xsl:apply-templates select='node()' mode='rssItem'/>
	</xsl:template>
	<xsl:template match='query | pager' mode='rssItem'/>
	
	<!--
	Adds nodes containing name or title as item to the channel
	
	*match* node()
	*mode* rssItem
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='node()[name or title]' mode='rssItem'>
		<item>
			<title><xsl:value-of select='title | name'/></title>
			<link><xsl:apply-templates select='self::node()' mode='rssItemLink'/></link>
			<category><xsl:apply-templates select='self::node()' mode='rssItemCategory'/></category>
			<description>
				<xsl:apply-templates select='contentblocks' mode='rssItemDescription'/>
			</description>
		</item>
	</xsl:template>
	
	<!--
	Adds content to the link node of an item
	
	*match* node()
	*mode* rssItemLink
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='node()' mode='rssItemLink'>
		<xsl:apply-templates select='parent::node()/parent::node()' mode='rssInfoLink'/>
	</xsl:template>
	
	<!--
	Adds content to the category node of an item
	
	*match* node()
	*mode* rssItemCategory
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='node()' mode='rssItemCategory'/>
	
	<!--
	Adds content to the description node of an item
	
	*match* contentblocks
	*mode* rssItemDescription
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='contentblocks' mode='rssItemDescription'>
		<xsl:apply-templates select='contentblock' mode='rssItemDescription'/>
	</xsl:template>
	
	<!--
	Adds content to the description node of an item
	
	*match* contentblock[contentblocktemplate/name = "text"] | contentblock[contentblocktemplate/name = "textphoto"]
	*mode* rssItemDescription
	
	Since: Fri Dec 19 2008
	-->
	<xsl:template match='contentblock[contentblocktemplate/name = "text"] | contentblock[contentblocktemplate/name = "textphoto"]' mode='rssItemDescription'>
		<xsl:value-of select='text'/>
	</xsl:template>
	<xsl:template match='contentblock' mode='rssItemDescription'/>
	
</xsl:stylesheet>