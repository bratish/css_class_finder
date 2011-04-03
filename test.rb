require 'rubygems'
require 'pp'

a = ["fLeft <%= @disable_child ? 'AddChildtabs' : 'tabs' -%> clearFix <%= 'blah' %>",
 "<%= 'selectedBlue' if @topic.blank? %>",
 "<%= 'selectedBlue' if @topic and @topic.id == topic.id %>",
 "width16 pRight5 mLeft10 txt<%= student_assessment.status_to_sting.gsub(' ', '') -%> txtBold"]

p a.first.index("<%")
p a.first.index("%>")
s = a.first
interpolate_arr = []
rest_of_the_str = ''

loop do
  start_index = s.index("<%")
  end_index = s.index("%>")
  break if start_index.nil? or end_index.nil?

end

