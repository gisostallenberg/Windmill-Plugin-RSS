<?php
/**
 * WMOutputCreatorRSS is the WMOutputCreator for rss requests
 *
 * @since Thu May 10 2007
 * @author Giso Stallenberg
 * @package Windmill.Plugins.RSS
 **/
class WMOutputCreatorRSS extends WMPlugin {
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
		$dom = $this->object->createOutput($encoding);
		$dom->getElementsByTagname("wmpage")->item(0)->setAttribute("baselink", WMCommonRegistry::get("wmserver")->getScriptUri() );

		return $dom;
	}
}
?>
