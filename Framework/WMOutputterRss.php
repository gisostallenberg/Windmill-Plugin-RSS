<?php
/**
 * WMOutputterRss is plugin WMOutputter for creating RSS feeds
 *
 * @since Thu Oct 09 2008
 * @author Ron Rademaker
 * @package Windmill.Plugins.Rss
 **/
WMCommonRegistry::get("wmpluginsystem")->loadVelponClass("WMOutputter", "rss");
class WMOutputterRss extends WMOutputterRssVelpon {
	/**
	 * printOutput
	 *
	 * Prints the output of the request as an RSS feed
	 * Note: UFTS are not supported in RSS feeds and disabled
	 *
	 * @since Tue Oct 14 2008
	 * @access protected
	 * @return void
	 **/
	public function printOutput(WMDesignTemplate $dt, WMContentTemplate $ct, WMCollection $ufts, $encoding) {
		$user = WMCommonRegistry::get("wmsession")->get("user")->getUser();
		$os = WMCommonRegistry::get("wmserver")->getOperatingSystem()->getIdentifier();

		if (WMCommonRegistry::get("wmtrigger")->hasTrigger("xml") && ($user instanceof WMLdapUser || (ini_get("windmill.error") === "0" || (!extension_loaded("windmill") && ($os === "windows") ) ) ) ) {
			WMHeader::xmlData($this->outputDoc);
			WMHeader::send();
		}
		else {
			$parser = new WMDesignTemplateXSLParser("include");
			$designTemplateManager = new WMDesignTemplateManager();
			$rssdt = $designTemplateManager->getTemplate("rss");
			$rss = $parser->parse($this->outputDoc, $rssdt->getXSLT(), $ct, true);

			WMHeader::xmlData($rss, "application/rss+xml");
			WMHeader::send();
		}
	}

}
