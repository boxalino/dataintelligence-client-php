boxalino Data Intelligence client for PHP
=========================================

Overview
--------

This library provides access to various functions of the boxalino Data Intelligence.

Usage
-----

To use the Data Intelligence client in your PHP project, take the following steps:

#1) Copy the contents of lib into your PHP codebase
#2) Configure your autoloader for Thrift or use the one provided:

require_once 'lib/Thrift/ClassLoader/ThriftClassLoader.php';
$loader = new \Thrift\ClassLoader\ThriftClassLoader(false);
$loader->registerNamespace('Thrift', 'lib/Thrift');
$loader->register();

#3) After that, you have to include the client to use it:

require_once 'lib/com/boxalino/dataintelligence/api/thrift/BoxalinoDataIntelligence.php';
require_once 'lib/com/boxalino/dataintelligence/api/thrift/Types.php';
