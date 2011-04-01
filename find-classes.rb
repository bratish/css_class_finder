require 'rubygems'
require 'css_parser'
require 'pp'

include CssParser

file = "application.css"
parser = CssParser::Parser.new

parser.load_file!(file)
array_of_classes = []

parser.each_selector do |selector, declarations, specificity|
  array_of_classes.push(selector) if selector.include? "."
end

classes_in_file = array_of_classes.collect{|x| x.scan(/\.([\w\-]+)/)}.flatten.uniq!

classes_in_file.each do |c|
  
end

