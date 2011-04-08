require 'rubygems'
require 'css_parser'
require 'pp'
require 'pick_css_classes'
require 'util'

include CssParser

railsroot = "/Users/bratish/solaro"
class_hash = {}

Dir.glob(File.join(railsroot, "public", "stylesheets", "*.css")) do |f|
  parser = CssParser::Parser.new
  parser.load_file!(f)
  array_of_classes = []
  
  parser.each_selector do |selector, declarations, specificity|
    array_of_classes.push(selector) if selector.include? "."
  end
  class_hash[f] = array_of_classes.collect{|x| x.scan(/\.([\w\-]+)/)}.flatten.uniq!
end
pp class_hash;exit
#file = "application.css"
#parser = CssParser::Parser.new
#
#parser.load_file!(file)
#array_of_classes = []
#
#parser.each_selector do |selector, declarations, specificity|
#  array_of_classes.push(selector) if selector.include? "."
#end

classes_in_file = array_of_classes.collect{|x| x.scan(/\.([\w\-]+)/)}.flatten.uniq!
f = 'index.html.erb'
pcc = PickCssClasses.new(f)
clean_class_references = pcc.pure_class_references
class_references_inside_script_tags = pcc.dynamic_class_references.flatten.compact.uniq
pp class_references_inside_script_tags
pp pcc.partial_class_references
#pp class_references_with_script_tags; exit
classes_found_clean = []
dynamic_class_references = []
puts "#{f}:"
classes_in_file.each do |c|
  classes_found_clean.push(c) if clean_class_references.include?(c)
#  puts "    #{c}" if class_references_with_script_tags.include?(c)
  dynamic_class_references.push(c) if class_references_inside_script_tags.include?(c)
end

pp classes_found_clean
pp dynamic_class_references
#  puts "  Cleanly found:"
#  #  puts "  Cleanly found:"
#puts "    #{c}"
