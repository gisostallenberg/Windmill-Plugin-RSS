<?xml version='1.0'?>
<!DOCTYPE xsl:stylesheet>
<xsl:stylesheet version='1.0' xmlns:xsl='http://www.w3.org/1999/XSL/Transform' xmlns:php='http://php.net/xsl'>
<!--
Stylesheet to handle the default rss output
Since: Fri May 11 2007
Author: Giso Stallenberg
-->
	<!--
		Main template match (applies the first childnode)

		*match* The root element wmpage
		*match* /wmpage

		Since: Thu May 10 2007
	-->
	<xsl:template match='/wmpage'>
		<rss version="2.0">
			<xsl:apply-templates select='node()[1]' mode='rss_channel'/>
		</rss>
	</xsl:template>

	<!--
		Template to get the baselink attribute's value

		*match* Any node
		*match* node()
		*mode* rss_getBaselink

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_getBaselink'>
		<xsl:value-of select='/wmpage/@baselink'/>
	</xsl:template>

	<!--
		Template to get the language attribute's value

		*match* Any node
		*match* node()
		*mode* rss_getLanguage

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_getLanguage'>
		<xsl:value-of select='translate(/wmpage/@language, "_", "-")'/>
	</xsl:template>

	<!--
		Main template for the rss channel

		*match* Any node
		*match* node()
		*mode* rss_channel

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channel'>
		<channel>
			<xsl:apply-templates select='self::node()' mode='rss_channelTitle'/>
			<xsl:apply-templates select='self::node()' mode='rss_channelLink'/>
			<xsl:apply-templates select='self::node()' mode='rss_channelDescription'/>
			<xsl:apply-templates select='self::node()' mode='rss_channelLanguage'/>
			<xsl:apply-templates select='self::node()' mode='rss_channelOtherElements'/>

			<xsl:apply-templates select='node()' mode='rss_item'/>
		</channel>
	</xsl:template>

	<!--
		The channel title

		*match* Any node
		*match* node()
		*mode* rss_channelTitle

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channelTitle'>
		<title>
			<xsl:apply-templates select='self::node()' mode='rss_channelTitleValue'/>
		</title>
	</xsl:template>

	<!--
		The channel title's value

		*match* Any node
		*match* node()
		*mode* rss_channelTitleValue

		Since: Fri May 11 2007
	-->
	<xsl:template match='node()' mode='rss_channelTitleValue'>
		<xsl:value-of select='php:function("getenv", "Sitename")'/> - <xsl:value-of select='php:function("ucfirst", name() )'/>
	</xsl:template>

	<!--
		The channel's website link

		*match* Any node
		*match* node()
		*mode* rss_channelLink

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channelLink'>
		<link>
			<xsl:apply-templates select='self::node()' mode='rss_getBaselink'/>
		</link>
	</xsl:template>

	<!--
		The channel's description

		*match* Any node
		*match* node()
		*mode* rss_channelDescription

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channelDescription'>
		<xsl:variable name='description'>
			<xsl:apply-templates select='self::node()' mode='rss_channelDescriptionValue'/>
		</xsl:variable>
		<description>
			<xsl:value-of select='php:function("gettext", $description)'/>
		</description>
	</xsl:template>

	<!--
		The channel's description's value

		*match* Any node
		*match* node()
		*mode* rss_channelDescriptionValue

		Since: Fri May 11 2007
	-->
	<xsl:template match='node()' mode='rss_channelDescriptionValue'>
		<xsl:text>Het </xsl:text><xsl:value-of select='name()'/><xsl:text> channel van </xsl:text><xsl:value-of select='php:function("getenv", "Sitename")'/>
 </xsl:template>

	<!--
		The channel's language

		*match* Any node
		*match* node()
		*mode* rss_channelLanguage

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channelLanguage'>
		<language>
			<xsl:apply-templates select='self::node()' mode='rss_getLanguage'/>
		</language>
	</xsl:template>

	<!--
		The channel's language (fallback when there's no language attribute)

		*match* Any node that has a root wmpage without a language attribute
		*match* /wmpage[not(@language)]//node()
		*mode* rss_channelLanguage

		Since: Thu May 10 2007
	-->
	<xsl:template match='/wmpage[not(@language)]//node()' mode='rss_channelLanguage'/>

	<!--
		The channel's other element's (here for extending purpose)

		*match* Any node
		*match* node()
		*mode* rss_channelOtherElements

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_channelOtherElements'/>

	<!--
		The channel's items

		*match* Any node
		*match* node()
		*mode* rss_item

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_item'>
		<item>
			<xsl:apply-templates select='self::node()' mode='rss_itemTitle'/>
			<xsl:apply-templates select='self::node()' mode='rss_itemLink'/>
			<xsl:apply-templates select='self::node()' mode='rss_itemDescription'/>
			<xsl:apply-templates select='self::node()' mode='rss_itemPubDate'/>

			<xsl:apply-templates select='self::node()' mode='rss_itemOtherElements'/>
		</item>
	</xsl:template>

	<!--
		The channel's title (fallback)

		*match* Any node
		*match* node()
		*mode* rss_itemTitle

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_itemTitle'/>

	<!--
		The channel's title (matches when there is a childnode title)

		*match* Any node that has a title childnode
		*match* node()[title]
		*mode* rss_itemTitle

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[title]' mode='rss_itemTitle'>
		<xsl:apply-templates select='title' mode='rss_getItemTitle'/>
	</xsl:template>

	<!--
		The channel's title (matches when there is a childnode titel)

		*match* Any node that has a titel childnode
		*match* node()[titel]
		*mode* rss_itemTitle

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[titel]' mode='rss_itemTitle'>
		<xsl:apply-templates select='titel' mode='rss_getItemTitle'/>
	</xsl:template>

	<!--
		The item's title getter (the actual title element)

		*match* Any node
		*match* node()
		*mode* rss_getItemTitle
		*param* title

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_getItemTitle'>
		<xsl:param name='title' select='self::node()'/>

		<title>
			<xsl:value-of select='$title'/>
		</title>
	</xsl:template>

	<!--
		The items link

		*match* Any node
		*match* node()
		*mode* rss_itemLink

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_itemLink'>
		<link>
			<xsl:apply-templates select='self::node()' mode='rss_itemLinkValue'/>
		</link>
	</xsl:template>

	<!--
		The items link's value

		*match* Any node
		*match* node()
		*mode* rss_itemLinkValue

		Since: Fri May 11 2007
	-->
	<xsl:template match='node()' mode='rss_itemLinkValue'>
		<xsl:apply-templates select='self::node()' mode='rss_getBaselink'/>rss/<xsl:value-of select='name(parent::node() )'/>/item/<xsl:value-of select='id'/>/
	</xsl:template>

	<!--
		The items description (fallback)

		*match* Any node
		*match* node()
		*mode* rss_itemDescription

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_itemDescription'/>

	<!--
		The items description (when there is a childnode text)

		*match* Any node that has a childnode text
		*match* node()[text]
		*mode* rss_itemDescription

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[text]' mode='rss_itemDescription'>
		<xsl:apply-templates select='text' mode='rss_getItemDescription'/>
	</xsl:template>

	<!--
		The items description (when there is a childnode tekst)

		*match* Any node that has a childnode tekst
		*match* node()[tekst]
		*mode* rss_itemDescription

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[tekst]' mode='rss_itemDescription'>
		<xsl:apply-templates select='tekst' mode='rss_getItemDescription'/>
	</xsl:template>

	<!--
		The items description getter (the actual description element)

		*match* Any node
		*match* node()
		*mode* rss_getItemDescription
		*param* description
		*param* length

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_getItemDescription'>
		<xsl:param name='description' select='self::node()'/>
		<xsl:param name='length' select='200'/>

		<description>
			<xsl:value-of select='substring($description, 0, $length)'/>
			<xsl:if test='string-length($description) &gt; $length'>
				<xsl:text> (...)</xsl:text>
			</xsl:if>
		</description>
	</xsl:template>

	<!--
		The item's publication date (fallback)

		*match* Any node
		*match* node()
		*mode* rss_itemPubDate

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_itemPubDate'/>

	<!--
		The item's publication date (when there is a childnode date)

		*match* Any node that has a childnode date
		*match* node()[date]
		*mode* rss_itemPubDate

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[date]' mode='rss_itemPubDate'>
		<xsl:apply-templates select='date' mode='rss_getItemPubDate'/>
	</xsl:template>

	<!--
		The item's publication date (when there is a childnode datum)

		*match* Any node that has a childnode datum
		*match* node()[datum]
		*mode* rss_itemPubDate

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()[datum]' mode='rss_itemPubDate'>
		<xsl:apply-templates select='date' mode='rss_getItemPubDate'/>
	</xsl:template>

	<!--
		The items pubDate getter (the actual pubDate element)

		*match* Any node
		*match* node()
		*mode* rss_getItemPubDate
		*param* date

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_getItemPubDate'>
		<xsl:param name='date' select='self::node()'/>

		<pubDate>
			<xsl:value-of select='php:function("date", "r", php:function("strtotime", string($date) ) )'/>
		</pubDate>
	</xsl:template>

	<!--
		The item's other element's (here for extending purpose)

		*match* Any node
		*match* node()
		*mode* rss_itemOtherElements

		Since: Thu May 10 2007
	-->
	<xsl:template match='node()' mode='rss_itemOtherElements'/>
</xsl:stylesheet>