<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>

<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:php='http://php.net/xsl'>
	<!--
	Collection of overwritable rss templates

	Since: Thu Oct 09 2008
	Author: Ron Rademaker
	-->

	<!--
	Adds the channel items
	*match* anything
	*mode* channelItem

	Since: Thu Oct 09 2008
	-->
	<xsl:template match='node()' mode='channelItem'>
		<xsl:apply-templates select='node()' mode='channelItem'/>
	</xsl:template>

	<!--
	Adds the information about the channel
	*match* anything
	*mode* channelInfo
	
	Since: Thu Oct 09 2008
	-->
	<xsl:template match='node()' mode='channelInfo'>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"title"'/>
			<xsl:with-param name='required' select='1'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"link"'/>
			<xsl:with-param name='required' select='1'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"description"'/>
			<xsl:with-param name='required' select='1'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"language"'/>
			<xsl:with-param name='default' select='"nl"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"copyrigh"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"managingEditor"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"webmaster"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"pubDate"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"lastBuildDate"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"category"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"generator"'/>
			<xsl:with-param name='default' select='"Windmill RSS"'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"ttl"'/>
			<xsl:with-param name='default' select='60'/>
		</xsl:apply-templates>
		<xsl:apply-templates select='self::node()' mode='channel'>
			<xsl:with-param name='node' select='"image"'/>
		</xsl:apply-templates>
	</xsl:template>

	<!--
	Fallback channel node generating templates
	*match* anything
	*mode* channel

	Since: Thu Oct 09 2008
	-->
	<xsl:template name='channelIterator'>
		<xsl:param name='node'/>
		<xsl:param name='required' select='0'/>
		<xsl:param name='default'/>
		<xsl:param name='curpos'/>

		<xsl:apply-templates select='/node()/descendant::node()[$curpos]' mode='channel'>
			<xsl:with-param name='node' select='$node'/>
			<xsl:with-param name='default' select='$default'/>
			<xsl:with-param name='required' select='$required'/>
			<xsl:with-param name='curpos' select='$curpos'/>
		</xsl:apply-templates>
	</xsl:template>
	<xsl:template match='node()' mode='channel'>
		<xsl:param name='node'/>
		<xsl:param name='required' select='0'/>
		<xsl:param name='default'/>
		<xsl:param name='curpos' select='0'/>

		<xsl:choose>
			<xsl:when test='count(/node()/descendant::node() ) &gt; $curpos'>
				<xsl:call-template name='channelIterator'>
					<xsl:with-param name='node' select='$node'/>
					<xsl:with-param name='default' select='$default'/>
					<xsl:with-param name='required' select='$required'/>
					<xsl:with-param name='curpos' select='$curpos + 1'/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test='($required  = 1) or $default'>
				<xsl:element name='{$node}'><xsl:value-of select='$default'/></xsl:element>
			</xsl:when>
		</xsl:choose>	
	</xsl:template>	

	<!--
	Includes the title of the rss feed
	*match* something with a title class or a h1
	*mode* channel

	Since: Thu Oct 09 2008
	-->
	<xsl:template match='h1 | node()[contains(@class, "title ") or contains(@class, " title") or (@class = "title")]' mode='channel'>
		<xsl:param name='node'/>
		<xsl:param name='required' select='0'/>
		<xsl:param name='default'/>
		<xsl:param name='curpos' select='0'/>

		<xsl:choose>
			<xsl:when test='$node = "title"'>
				<title><xsl:value-of select='self::node()'/></title>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name='channelIterator'>
					<xsl:with-param name='node' select='$node'/>
					<xsl:with-param name='default' select='$default'/>
					<xsl:with-param name='required' select='$required'/>
					<xsl:with-param name='curpos' select='$curpos + 1'/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!--
	Adds a node to an item element
	*match* anything
	*mode* node

	Since: Thu Oct 09 2008
	-->
	<xsl:template match='node()' mode='item'>
		<xsl:param name='node'/>

		<xsl:element name='{$node}'><xsl:copy-of select='node()'/></xsl:element>
	</xsl:template>

</xsl:stylesheet>	
