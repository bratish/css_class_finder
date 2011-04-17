require 'rubygems'
require 'css_parser'
require 'pp'
require 'pick_css_classes'
require 'util'
require 'find_files'

include CssParser

#rail_sroot = "/Users/bratish/solaro"
rails_root = "/home/bratish/gnimmargorp/solaro-projects/solaro_old"
css_class_hash = {}
ff = FindFiles.new(rails_root)

ff.css_files.each do |f|
  parser = CssParser::Parser.new
  parser.load_file!(f)
  array_of_classes = []

  parser.each_selector do |selector, declarations, specificity|
    array_of_classes.push(selector) if selector.include? "."
  end
  css_class_hash[f] = array_of_classes.collect{|x| x.scan(/\.([\w\-]+)/)}.flatten.uniq
end
#pp css_class_hash;exit
css_classes_in_templates = {}
ff.template_files.each do |f|
#  p f
#  f = "/home/bratish/gnimmargorp/solaro-projects/solaro_old/app/views/teacher_classes/_add_existing_class_student.html.haml"
  pcc = PickCssClasses.new(f)
  css_classes_in_templates[f] = {
    "clean_class_references" => pcc.pure_class_references,
    "class_references_inside_script_tags" => pcc.dynamic_class_references,
    "partial_class_references" => pcc.partial_class_references
  }
#  break
end
#pp css_classes_in_templates; exit

css_class_hash.each do |file, classes_array|
  puts "CSS file: #{file}"
  classes_array.each do |css_class|
    css_classes_in_templates.each do |template_file, used_class_hash|
      puts "  Template file: #{template_file}"
      used_class_hash.each do |ref_type, css_ref_name_array|
#        pp ref_type
#        pp css_ref_name_array
#        p "css_class: #{css_class}"
#        css_class = "newSubBtnXL"
        puts "    #{css_class} present in #{ref_type}" if css_ref_name_array.include? css_class
      end
    end
  end
#  break
end