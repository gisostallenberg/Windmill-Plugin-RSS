<?php
/**
 * WMOutputCreatorRSS is the WMOutputCreator for rss requests
 *
 * Changelog
 * ---------
 *
 * Giso Stallenberg Fri May 11 2007
 * -----------------------------
 * - Corrected baselink, to be really base ;)
 *
 * @since Thu May 10 2007
 * @author Giso Stallenberg
 * @package Windmill.Plugins.RSS
 **/
WMCommonRegistry::get("wmpluginsystem")->loadVelponClass("WMOutputCreator", "rss");
class WMOutputCreatorRSS extends WMOutputCreatorRSSVelpon {
	/**
	 * createOutput
	 *
	 * Fills the outputDoc (adds a baselink attribute to wmpage)
	 *
	 * @since Thu May 10 2007
	 * @access public
	 * @param string $encoding
	 * @return WMDomDocument
	 **/
	public function createOutput($encoding) {
		$dom = parent::createOutput($encoding);

		$baselink = $_SERVER["SCRIPT_URI"];
		if ($_SERVER["SCRIPT_URL"] !== "/") {
			$baselink = str_replace($_SERVER["SCRIPT_URL"], "", $baselink) . "/";
		}

		$dom->getElementsByTagname("wmpage")->item(0)->setAttribute("baselink", $baselink);

		return $dom;
	}
}
?>
