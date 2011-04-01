require 'rubygems'
require 'pp'

file = 'index.html.erb'
content = File.open(file, 'r').read


class_references = content.grep(/[:]?class[ ]?=[ >]?/).map do |line|
  line.strip!.match(/[:]?class[ ]?=[ >]?[ ]*[\\]?["|']([\w <%=\->:,?@'"\.\(\)#{}]*)[ ]*[\\]?["|']/)[1]
end

class_references_with_script_tags = class_references.select do |str|
  str.scan(/(<%[\w =\-:,?@'"\.\(\)#{}]*%>)/).size > 0
end

pure_class_references =  (class_references - class_references_with_script_tags).collect{|c| c.split(/["|']/).first}

pp class_references - class_references_with_script_tags
pp "============================"
pp pure_class_references

