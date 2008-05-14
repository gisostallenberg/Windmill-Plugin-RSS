<?php
/**
 * WMOutputterRSS is plugin WMOutputter for rss requests
 *
 * @since Thu May 10 2007
 * @author Giso Stallenberg
 * @package Windmill.Plugins.RSS
 **/
WMCommonRegistry::get("wmpluginsystem")->loadVelponClass("WMOutputter", "rss");
class WMOutputterRSS extends WMOutputterRSSVelpon {
	/**
	 * printOutput
	 *
	 * Prints the output  of the request (sets the dt to [plugindir]/rss.xsl if there's no special dt requested)
	 *
	 * @since Thu May 10 2007
	 * @access public
	 * @return void
	 **/
	public function printOutput(WMDesignTemplate $dt, WMContentTemplate $ct, $encoding) {
		header("Content-type: text/xml; charset=UTF-8");

		if (WMCommonRegistry::get("wmrequest")->getVariable("xml") == 1) {
			print $this->outputDoc->saveXML();
		}
		else {
			if (!WMCommonRegistry::get("wmrequest")->hasVariable("dt") ) {
				$dt = new WMDesignTemplate(realpath(dirname(__FILE__) . "/..") . "/rss.xsl");
			}
			$parser = new WMXSLParser();
			$xhtml = $parser->parse($this->outputDoc, $dt->getXSLT(), $ct, true);

			print $xhtml->saveXML();
		}
	}
}
?>
