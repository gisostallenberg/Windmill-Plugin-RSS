<?php
/**
 * Bootstrap file for PHPUnit tests
 *
 * @author Ron Rademaker
 */
chdir(__DIR__);

$bootstrap = WMBootstrap::bootstrap('Rss');
WMServer::getInstance(array());
WMApplication::getInstance(array(WMBootstrap::getSitename(), 'WMRSSWindmill'));

$pluginSystem = WMPluginSystem::getInstance(array());
$pluginSystem->addPluginDirectory(__DIR__ . '/../../');

WMCommonRegistry::set('wmrequest', WMRequest::getInstance(array($_REQUEST)));
WMCommonRegistry::set('wmtrigger', WMTrigger::createInstance());
WMCommonRegistry::set('wmsession', WMSession::getInstance(array(60)));

WMUserfriendlyNames::getInstance(array());
