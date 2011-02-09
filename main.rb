#!/usr/bin/env ruby
#encoding: utf-8

require "rubygems"
require "fileutils"

Dir.glob(File.dirname(__FILE__) + '/lib/*.rb', &method(:require))

Wipe.new do
  page         "http://100ch.ru/tst/res/131.html"
  form         "postform"
  text_name    "ололо"
  text_message "qqqqqqqqqqqq"
  attach       :imagefile, {:folder => "img", :mutex => true}
  threads      1
  wait         30
end.run