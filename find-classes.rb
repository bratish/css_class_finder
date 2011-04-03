require 'rubygems'
require 'css_parser'
require 'pp'
require 'pick_css_classes'
require 'util'

include CssParser

def doubtful_entry(css_class)
  
end

file = "application.css"
parser = CssParser::Parser.new

parser.load_file!(file)
array_of_classes = []

parser.each_selector do |selector, declarations, specificity|
  array_of_classes.push(selector) if selector.include? "."
end

classes_in_file = array_of_classes.collect{|x| x.scan(/\.([\w\-]+)/)}.flatten.uniq!
f = 'index.html.erb'
pcc = PickCssClasses.new(f)
clean_class_references = pcc.pure_class_references
class_references_with_script_tags = pcc.class_references_with_script_tags
pp class_references_with_script_tags; exit
classes_found_clean = []
classes_found_with_doubt = []
puts "#{f}:"
classes_in_file.each do |c|

classes_found_clean.push(c) if clean_class_references.include?(c)

  puts "    #{c}" if class_references_with_script_tags.include?(c)
end
#  puts "  Cleanly found:"
#  #  puts "  Cleanly found:"
#puts "    #{c}"
