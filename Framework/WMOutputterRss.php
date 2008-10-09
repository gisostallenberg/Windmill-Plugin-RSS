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
	 * Prints the output of the request
	 * Creating RSS is done in two steps:
	 * - Parse with passed or default DT (preferred dt is something like a content dt)
	 * - Parse with rss dt (first parse should make something the rss dt can figure out, rss dt looks at classnames)
	 *
	 * Note: UFTS are not supported in RSS feeds and disabled
	 *
	 * @since Thu Oct 09 2008
	 * @access protected
	 * @return void
	 **/
	public function printOutput(WMDesignTemplate $dt, WMContentTemplate $ct, WMCollection $ufts, $encoding) {
		$parser = new WMXSLParser();
		$rssable = $parser->parse($this->outputDoc, $dt->getXSLT(), $ct, true);
		$parser = new WMXSLParser("include");
		$designTemplateManager = new WMDesignTemplateManager();
		$rssdt = $designTemplateManager->getTemplate("rss");
		$rss = $parser->parse($rssable, $rssdt->getXSLT(), $ct, true);
		
		header("Content-type: text/xml; charset=UTF-8");
		Header("Cache-Control: no-cache"); // IE caches XMLHttpRequest..
		Header("Pragma: no-cache");
		print $rss->saveXML();
	}

}
