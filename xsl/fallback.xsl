<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version='1.0'
	xmlns:xsl='http://www.w3.org/1999/XSL/Transform'
	xmlns:media='http://search.yahoo.com/mrss/'
	xmlns:chap='http://www.connectholland.nl/chap/'
	xmlns:php='http://php.net/xsl'
	exclude-result-prefixes='php'>
	<!--
	Fallback RSS templates

	Since: Tue Oct 14 2008
	Author: Ron Rademaker
	-->

	<!--
	Fallback rss moded template
	*match* anything
	*mode* rss

	Since: Tue Oct 14 2008
	-->
	<xsl:template match='node()' mode='rss' priority='-1'/>

	<!--
	Iterates over all nodes until something is found that can add channel info, ends up with adding the required nodes
	*match* anything
	*mode* rssInfo

	Since: Tue Oct 14 2008
	-->
	<xsl:template name='nodeIterator'>
		<xsl:param name='curpos'/>

		<xsl:apply-templates select='/node()/descendant::node()[$curpos]' mode='rssInfo'>
			<xsl:with-param name='curpos' select='$curpos'/>
		</xsl:apply-templates>	
	</xsl:template>
	<xsl:template match='node()' mode='rssInfo'>
		<xsl:param name='curpos' select='0'/>

		<xsl:choose>
			<xsl:when test='count(/node()/descendant::node() ) &gt; $curpos'>
				<xsl:call-template name='nodeIterator'>
					<xsl:with-param name='curpos' select='$curpos + 1'/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<title/>
				<link/>
				<description/>
			</xsl:otherwise>
		</xsl:choose>	
	</xsl:template>
</xsl:stylesheet>
