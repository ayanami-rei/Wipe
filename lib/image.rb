class Image

  attr_accessor :files, :folder

  def initialize options
    @folder = options[:folder]
    @files = Dir.glob(@folder + "/*.{jpg,jpeg,png,gif}", 0)
  end

  def get
    file     = @files[rand(@files.size)]
    tmp_file = 'tmp/'+ File.basename(file)
    FileUtils.cp file, tmp_file
		File.open(tmp_file,"a") {|temp| temp.write(rand_str(rand(20)+10))}
    tmp_file
  end

  def rand_str(size=16, s="")
    size.times { s << (i = rand(62); i += ((i < 10) ? 48 : ((i < 36) ? 55 : 61 ))).chr }
    s
  end
end