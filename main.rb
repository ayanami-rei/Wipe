$LOAD_PATH << "lib"

require "rubygems"
require "wipe"
require "proxy"
require "image"

wipe = Wipe.new do
  page         "http://100ch.ru/tst/"
  form         "postform"
  text_name    "Ayanami Rei"
  text_message "Just testing"
  attach       :imagefile, "img"
  threads      1
  wait         30
end.run
