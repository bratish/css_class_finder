require 'rubygems'
require 'pp'

a = ["fLeft <%= @disable_child ? 'AddChildtabs' : 'tabs' -%> clearFix <%= 'blah' %>",
 "<%= 'selectedBlue' if @topic.blank? %>",
 "<%= 'selectedBlue' if @topic and @topic.id == topic.id %>",
 "width16 pRight5 mLeft10 txt<%= student_assessment.status_to_sting.gsub(' ', '') -%> txtBold"]

#p a.first.index("<%")
#p a.first.index("%>")
s = a[1]
p s
interpolate_arr = []
rest_of_the_str = ''

loop do
  p "loop"
  start_index = s.index("<%")
  end_index = s.index("%>")
  break if start_index.nil? or end_index.nil?
  rest_of_the_str += s[0..start_index-1]
  interpolate_arr.push(s[start_index +2..end_index-1])
  s = s[end_index + 2..s.size]
end

p interpolate_arr
p rest_of_the_str

