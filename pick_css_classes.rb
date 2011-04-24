#require 'rubygems'
#require 'pp'

class PickCssClasses
  attr_accessor :class_references, :class_references_with_script_tags, :pure_class_references, :partial_class_references, :dynamic_class_references
  
  def initialize(f)
    @content = File.open(f, 'r').read

    @class_references = @content.grep(/[:]?class[ ]*=[ >]?/).map do |line|
      line.scan(/[:]?class[ ]*=[ >]?[ ]*[\\]?["|']([\w <%=\->:,?@'"\.\(\)#\{\}]*)[ ]*[\\]?["|']/)
    end.flatten.compact.reject { |s| s.strip.empty? }
#    pp @class_references
    @class_references_with_script_tags = @class_references.select do |str|
      str.scan(/(<%[\w =\-:,?@'"\.\(\)#\{\}]*%>)/).size > 0
    end
#    pp @class_references_with_script_tags
#    pp @class_references - @class_references_with_script_tags
    @pure_class_references = (@class_references - @class_references_with_script_tags).collect{|c| c.split(/["|']/).first.split(" ")}.flatten.uniq
#    pp @pure_class_references
    @partial_class_references = []
    @dynamic_class_references = []

    @class_references_with_script_tags.each do |s|
      interpolate_arr = s.scan(/#\{([a-zA-Z0-9_\.'\(\) ,\?:"]*)\}/).flatten
      script_tag_arr = s.scan(/<%([\w =\-:,?@'"\.\(\)#\{\}]*)%>/).flatten
      @pure_class_references.push(s.gsub(/[a-zA-Z0-9_]*<%[=]?[ ]*[\w =\-:,?@'"\.\(\)#\{\}]*[ ]*[\-]?%>/, "").gsub(/[a-zA-Z0-9_]*#\{[a-zA-Z0-9_\.'\(\) ,\?:"]*\}/, "").split(" ").compact.uniq).flatten.uniq
      @partial_class_references = (s.scan(/([a-zA-Z0-9]+)#\{[a-zA-Z0-9_\.'\(\) ,\?:"]*\}([a-zA-Z0-9]+)?/)+ s.scan(/([a-zA-Z0-9]+)<%[\w =\-:,?@'"\.\(\)#\{\}]*%>([a-zA-Z0-9]+)?/)).flatten.compact
      class_references_inside_interpolations = (interpolate_arr.collect{|elem| elem.scan(/'([\w]+)'/)} + interpolate_arr.collect{|elem| elem.scan(/"([\w]+)"/)}).flatten.compact.uniq
      class_references_inside_script_tags = (script_tag_arr.collect{|elem| elem.scan(/'([\w]+)'/)} + script_tag_arr.collect{|elem| elem.scan(/"([\w]+)"/)}).flatten.compact.uniq
      @dynamic_class_references.push((class_references_inside_interpolations + class_references_inside_script_tags))
    end
#    pp @pure_class_references
    @pure_class_references = @pure_class_references.flatten.compact.uniq
    @dynamic_class_references = @dynamic_class_references.flatten.compact.uniq
  end
end

#pcc = PickCssClasses.new('index.html.erb')
#p "class_references"
#pp pcc.class_references
#p "========================="
#p "class_references_with_script_tags"
#pp pcc.class_references_with_script_tags
#p "========================="
#p "pure_class_references"
#pp pcc.pure_class_references.flatten.uniq
#p "========================="
#p "partial_class_references"
#pp pcc.partial_class_references
#p "========================="
#p "dynamic_class_references"
#pp pcc.dynamic_class_references.flatten.compact.uniq
