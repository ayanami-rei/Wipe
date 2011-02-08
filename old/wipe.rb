#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'

proxy    = File.open("proxy.txt", "r") {|file| file.read}.split(/\n/).collect{|line| line.split(':')}
pictures = Dir.glob(File.dirname(__FILE__) + "/pic/*.{jpg,jpeg,png,gif}", 0)
puts "#{pictures.size} pictures detected"

threads = []
proxy.size.times do |i|
  threads << Thread.new do
    agent = Mechanize.new 
    agent.set_proxy(*proxy[rand(proxy.size)])
    begin
      page = agent.get('http://100ch.ru/tst/')
      form = page.form('postform')
    rescue
      puts "ERROR fetch page in thread #{i}"
      break
    end
    form.name         = 'Ayanami Rei'
    form.message      = 'New version test'
    form.postpassword = 'fgsfds'
    loop do
      form.file_uploads.first.file_name = pictures[rand(pictures.size)]
      form.submit rescue puts("ERROR sibmit form in thread #{i}") and next
      puts "Thread #{i}: posted succesful"
      sleep 10
    end
  end
end

threads.each(&:join)
