require 'rubygems'
require 'pp'

file = 'index.html.erb'
content = File.open(file, 'r').read

x = content.
      grep(/[:]?class[ ]?=[ >]?/).
        map{|line| line.strip!.match(/[:]?class[ ]?=[ >]?[ ]*[\\]?["|']([\w <%=\->:,?@'"\.\(\)#{}]*)[ ]*[\\]?["|']/)[1]}

x.each do|str|
  
  p str.scan(/(<%[\w =\-:,?@'"\.\(\)#{}]*%>)/)
end

