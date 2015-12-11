<?php
namespace ConnectHolland\Windmill\Plugin\Aeroplane\Test;

use ConnectHolland\Windmill\Plugin\RSS\RssPlugin;
use PHPUnit_Framework_TestCase;

/**
 * Unit test for the RSS plugin class
 *
 * @author Ron Rademaker
 */
class RssPluginTest extends PHPUnit_Framework_TestCase
{
    /**
     * Test if the root directory contains the required config file
     */
    public function testRootContainsConfig()
    {
        $plugin = new RssPlugin();
        $root = $plugin->getRootDirectory();

        $this->assertFileExists($root . '/config.xml');
    }

    /**
     * Tests if the config can be loaded
     *
     * @depends testRootContainsConfig
     */
    public function testConfigIsLoadable()
    {
        $plugin = new RssPlugin();
        $config = $plugin->getConfiguration();

        $this->assertInstanceOf('WMPluginConfig', $config);
    }

    /**
     * Tests if the plugin has the correct name
     */
    public function testPluginName()
    {
        $plugin = new RssPlugin();
        $name = $plugin->getName();

        $this->assertEquals('rss', $name);
    }
}
