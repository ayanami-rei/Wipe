require "mechanize"

class Proxy
  attr_accessor :thread

  def initialize file="proxy.txt"
	proxy = File.open("proxy.txt", "r") {|file| file.read}.split(/\n/).collect{|line| line.split(':')}
		puts "#{proxy.size} proxies loaded. Checking..."
     end

  def check_proxy
counter = 0
	pFile = File.new("good_proxies.txt", "w")

proxy.size.times do |i|
	agent = Mechanize.new
	agent.set_proxy(*proxy[counter])
	puts "Checking #{proxy[counter]}"
	counter = counter + 1
	begin
	check = agent.get('http://google.com')
	form = check.form('f')
	form.q = 'Check'
	form.submit
	rescue
	puts "Proxy #{proxy[counter]} is broken!"
	next
	pFile.syswrite(proxy[counter] + "\n")
	end
    end
pFile.close
  end	

  def get
	answer = File.open("good_proxies.txt", "r") {|file| file.read}.split(/\n/).collect{|line| line.split(':')}
	answer = *answer[@thread]
	answer
  end
end
