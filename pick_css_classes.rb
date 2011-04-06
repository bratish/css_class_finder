require 'rubygems'
require 'pp'

class PickCssClasses

  def initialize(f)
    @file = f
    @content = ''
    @class_references = []
    @class_references_with_script_tags = []
  end

  def content
    @content = File.open(@file, 'r').read
  end

  def class_references
    @class_references = @content.grep(/[:]?class[ ]?=[ >]?/)#.map do |line|
#      line.strip!.match(/[:]?class[ ]?=[ >]?[ ]*[\\]?["|']([\w <%=\->:,?@'"\.\(\)#{}]*)[ ]*[\\]?["|']/)[1]
#    end
    @class_references
  end

  def class_references_with_script_tags
    @class_references_with_script_tags = @class_references.select do |str|
      str.scan(/(<%[\w =\-:,?@'"\.\(\)#{}]*%>)/).size > 0
    end
  end

  def pure_class_references
    (class_references - class_references_with_script_tags).collect{|c| c.split(/["|']/).first.split(" ")}.flatten.uniq!
  end

  def doubtful_class_references
    @class_references_with_script_tags
  end
end

pcc = PickCssClasses.new('index.html.erb')
pp pcc.class_references_with_script_tags
#pp pcc.pure_class_references
#pp pcc.class_references_with_script_tags