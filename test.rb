require 'rubygems'
require 'pp'

a = ["fLeft <%= @disable_child ? 'AddChildtabs' : 'tabs' : \'bad\"  -%> clearFix ab c<%= 'blah' %> txt\#{student_assessment.status_to_sting.gsub('123456', \"111\")} 1231txt\#{st}",
  "<%= 'selectedBlue' if @topic.blank? %>",
  "<%= 'selectedBlue' if @topic and @topic.id == topic.id %>",
  "width16 pRight5 mLeft10 txt<%= student_assessment.status_to_sting.gsub(' ', '') -%> txtBold",
  "width16 pRight5 mLeft10 txt\#{student_assessment.status_to_sting.gsub(' ', '')} txtBold"
]
# s.scan(/#\{([a-zA-Z0-9_\.'\(\) ,\?:"]*)\}/)
#s = "#{a[0] } <% %>"
script_tag_arr = []
interpolate_arr = []
partial_class_references = []
class_references_inside_interpolations =[]
class_references_inside_script_tags = []

s = a[0]
p s
#p s.gsub(/[a-zA-Z0-9_]*<%[=]?[ ]*[\w =\-:,?@'"\.\(\)#\{\}]*[ ]*[\-]?%>/, "").gsub(/[a-zA-Z0-9_]*#\{[a-zA-Z0-9_\.'\(\) ,\?:"]*\}/, "").split(" ").compact.uniq
interpolate_arr = s.scan(/#\{([a-zA-Z0-9_\.'\(\) ,\?:"]*)\}/).flatten
script_tag_arr = s.scan(/<%([\w =\-:,?@'"\.\(\)#\{\}]*)%>/).flatten
pure_class_references = s.gsub(/[a-zA-Z0-9_]*<%[=]?[ ]*[\w =\-:,?@'"\.\(\)#\{\}]*[ ]*[\-]?%>/, "").gsub(/[a-zA-Z0-9_]*#\{[a-zA-Z0-9_\.'\(\) ,\?:"]*\}/, "").split(" ").compact.uniq
partial_class_references = (s.scan(/([a-zA-Z0-9]+)#\{[a-zA-Z0-9_\.'\(\) ,\?:"]*\}/)+ s.scan(/([a-zA-Z0-9]+)<%[\w =\-:,?@'"\.\(\)#\{\}]*%>/)).flatten
class_references_inside_interpolations = (interpolate_arr.collect{|elem| elem.scan(/'([\w]+)'/)} + interpolate_arr.collect{|elem| elem.scan(/"([\w]+)"/)}).flatten.compact.uniq
class_references_inside_script_tags = (script_tag_arr.collect{|elem| elem.scan(/'([\w]+)'/)} + script_tag_arr.collect{|elem| elem.scan(/"([\w]+)"/)}).flatten.compact.uniq
p "interpolate_arr"
p interpolate_arr
p "script_tag_arr"
p script_tag_arr
p "pure_class_references"
p pure_class_references
p "partial_class_references"
p partial_class_references
p "class_references_inside_interpolation"
p class_references_inside_interpolations
p "class_references_inside_script_tags"
p class_references_inside_script_tags

#
#loop do
#  start_index = s.index("<%")
#  end_index = s.index("%>")
#  partial_class_reference = ""
#  break if s.strip.size == 0 or start_index.nil? or end_index.nil?
#  if (start_index-1) > 0 and s[start_index-1].chr != " "
#    partial_class_reference = s[0..start_index-1].split(" ").last
#    partial_class_references.push(partial_class_reference)
#  end
#  p s[0..start_index-1]
#  rest_of_the_str += s[0..start_index-1].gsub!(partial_class_reference, "") if start_index-1 > -1
#  script_tag_arr.push(s[start_index +2..end_index-1].scan(/'([\w]+)'|"([\w]+)"/)) # if start_index-1 > -1 and end_index > -1
#
#  interpolate_arr.push()
#
#
#  s = s[end_index + 2..s.size]
#  break if s.strip.size == 0
#end
#
#pure_class_references = rest_of_the_str.strip.split(" ").uniq



