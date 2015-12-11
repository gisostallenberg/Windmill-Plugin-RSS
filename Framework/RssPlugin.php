<?php

namespace ConnectHolland\Windmill\Plugin\RSS;

use WMAbstractPluginConfiguration;

/**
 * Plugin class for RSS
 *
 * @author Ron Rademaker
 */
class RssPlugin extends WMAbstractPluginConfiguration
{

    /**
     * Get the root path of the plugin
     *
     * @return string
     */
    public function getRootDirectory()
    {
        return __DIR__ . '/../';
    }
}
