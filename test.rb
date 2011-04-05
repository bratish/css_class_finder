require 'rubygems'
require 'pp'

a = ["fLeft <%= @disable_child ? 'AddChildtabs' : 'tabs' : \'bad\"  -%> clearFix <%= 'blah' %>",
 "<%= 'selectedBlue' if @topic.blank? %>",
 "<%= 'selectedBlue' if @topic and @topic.id == topic.id %>",
 "width16 pRight5 mLeft10 txt<%= student_assessment.status_to_sting.gsub(' ', '') -%> txtBold",
 "width16 pRight5 mLeft10 txt#{"student_assessment.status_to_sting.gsub(' ', '')"} txtBold"
 ]

s = "#{a[0] } <% %>"
interpolate_arr = []
rest_of_the_str = ''
partial_class_references = []

loop do
  start_index = s.index("<%")
  end_index = s.index("%>")
  partial_class_reference = ""
  break if s.strip.size == 0 or start_index.nil? or end_index.nil?
  if (start_index-1) > 0 and s[start_index-1].chr != " "
    partial_class_reference = s[0..start_index-1].split(" ").last
    partial_class_references.push(partial_class_reference)
  end
  p s[0..start_index-1]
  rest_of_the_str += s[0..start_index-1].gsub!(partial_class_reference, "") if start_index-1 > -1
  interpolate_arr.push(s[start_index +2..end_index-1].scan(/'([\w]+)'|"([\w]+)"/)) # if start_index-1 > -1 and end_index > -1
  s = s[end_index + 2..s.size]
  break if s.strip.size == 0 
end

pure_class_references = rest_of_the_str.strip.split(" ").uniq


  p interpolate_arr.flatten.compact
  p pure_class_references
  p partial_class_references

