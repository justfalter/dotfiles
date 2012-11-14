require 'rubygems'
require 'irb/completion'
#begin
#  require 'irb/ext/save-history'
#
#  IRB.conf[:SAVE_HISTORY] = 200
#rescue LoadError
#  puts "Couldn't load 'irb/ext/save-history'"
#end

#Set up Looksee
begin
  require 'looksee'
  Looksee.styles[:overridden] = "\e[1;35m%s\e[0m"
rescue LoadError
  puts "Couldn't load 'looksee'"
end

begin
  require 'sketches'
  Sketches.config :editor => 'mvim'#, :eval_after_editor_quit => true, :background => false
rescue LoadError
  puts "Couldn't load 'sketches'"
end

require 'csv'

class Array
  def to_csv
    CSV.generate do |csv|
      self.each do |data|
        csv << data
      end
    end
  end
end

begin 
  require 'awesome_print'

  def app(o)
    z = o.class.ancestors.reverse[0..-2]
    z.each do |klass|
      ap klass.instance_methods(false,true)
    end
    ap o.methods(false,true)
    nil
  end
rescue LoadError
  puts "Couldn't load 'awesome_print'"
end
