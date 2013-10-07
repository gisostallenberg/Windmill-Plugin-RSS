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
		if (WMCommonRegistry::get("wmtrigger")->hasTrigger("xml", "debug") || WMCommonRegistry::get("wmtrigger")->hasTrigger("api", "protected") ) {
			WMHeader::xmlData($this->outputDoc);
		}
		elseif (WMCommonRegistry::get("wmtrigger")->hasTrigger("sqltime", "debug") ) {
			var_dump(BasePeer::$time);
			$this->endOutput();
		}
		else {
			if (WMCommonRegistry::get("wmtrigger")->hasTrigger("timings", "debug") ) {
				$beforeParsing = microtime(true);
			}
			$xhtml = $dt->apply($this->outputDoc, $ct);

			foreach ($ct->getAdditionalHeaders() as $header) {
				WMHeader::sendHeader($header["type"], $header["value"]);
			}
			$contenttype = $ct->getContentType();
			if (strpos($contenttype, "+xml") !== false || in_array($contenttype, array("text/xml", "application/xml") ) ) {
				WMHeader::xmlData($xhtml, $ct->getContentType(), $encoding);
			}
			else {
				$parser = new WMDesignTemplateXSLParser("include");
				$designTemplateManager = new WMDesignTemplateManager();
				$rssdt = $designTemplateManager->getTemplate("rss");
				$rss = $parser->parse($this->outputDoc, $rssdt->getXSLT(), $ct, true);

				WMHeader::xmlData($rss, "application/rss+xml");
				WMHeader::send();
			}
			if (WMCommonRegistry::get("wmtrigger")->hasTrigger("timings", "debug") ) {
				$afterParsing = microtime(true);
				print "XSL Parsing took " . ($afterParsing - $beforeParsing) . " seconds<br/>";
			}
		}
		$this->changeOutput(WMHeader::getData(), $ct->getContentType(), $encoding);
		$this->sendOutput();
	}

}
