class Word < ActiveRecord::Base

def self.read_file(filename)
  text = File.open(filename).read
  text.each_line do |line|
    Word.new(value: line).save
  end
end

end
