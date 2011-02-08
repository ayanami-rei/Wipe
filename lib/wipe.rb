require "mechanize"

class Wipe

  attr_accessor :link, :fields, :file_field, :form_name, :reload, :files, :threads_count

  def initialize &block
    @fields, @threads_count, @timeout = {}, 1, 0
    instance_eval &block
  end

  def run
    agent = Mechanize.new

    threads = []
    @threads_count.times do |i|
      threads << Thread.new do
        loop do
          begin
            page = agent.get(@link)
            form = page.form(@form_name)
          rescue
            puts "ERROR fetch page"
            return
          end
          @fields.each { |name, value| form[name] = value }
          form.file_uploads.first.file_name = @files[rand(@files.size)] if @file_field
          begin
            page = agent.submit(form)
          rescue
            puts "ERROR submit form from thread #{i}"
            next
          end
          puts "nexttt"
          File.open("log.txt", "w") {|file| file.puts page.body}
          sleep @timeout
        end
      end
    end
    threads.each(&:join)
  end

  def threads count
    @threads_count = count
  end

  def wait sec
    @timeout = sec
  end

  def page link
    @link = link
  end

  def form name
    @form_name = name
  end

  def text name, value
    @fields[name] = value
  end

  def attach name, folder
    @files = Dir.glob(folder + "/*.{jpg,jpeg,png,gif}", 0)
    @file_field = name.to_s
  end

  def method_missing name, *args, &block
    case name.to_s
    when /text_(.+)/
      text($1, *args)
	  else
	    puts name.to_s + " called"
	  end
  end
end