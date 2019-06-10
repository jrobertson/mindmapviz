#!/usr/bin/env ruby

# file: mindmapviz.rb

require 'shellwords'
require 'pxgraphviz'


# inspired by https://github.com/bingwei/ruby-graphviz-mindmap


=begin
notes:

coloured box for central point
box for nodes
text for leaves

or
ellipse for central point
text for nodes and leaves 

or

coloure dellipse for central point 
text for nodes and leaves
  - larger text and thicker connections for more important things 
coloured branches for different nodes

For text only use shape: 'none'
=end

# inspired by https://github.com/bingwei/ruby-graphviz-mindmap


class Mindmapviz < PxGraphViz
  using ColouredText
  
  
  def initialize(s, fields: %w(label shape), delimiter: ' # ', 
                 style: nil, debug: false, fill: '#ccffcc', 
                 stroke: '#999999', text_color: '#330055')
    

    if s =~ /<?mindmapviz / then
      
      raw_mm = s.clone
      s2 = raw_mm.slice!(/<\?mindmapviz [^>]+\?>/)

      # attributes being sought =>  root fields delimiter id
      attributes = Shellwords::shellwords(s).map {|x| key, 
                         value = x.split(/=/, 2); [key.to_sym, value]}.to_h
      
      h = {
        fields: fields.join(', '), 
        delimiter: delimiter
      }.merge attributes          

      s = if h[:root] then
        "\n\n" + h[:root] + "\n" + 
          raw_mm.strip.lines.map {|line| '  ' + line}.join
      else
        raw_mm
      end
      
      delimiter = h[:delimiter]
      fields = h[:fields].split(/ *, */)

    end
    
schema = "items[type, layout]/item[%s]" % fields.join(', ')
    
raw_doc =<<EOF
<?polyrex schema='#{schema}' delimiter='#{delimiter}'?>
type: graph
layout: neato
#{s}
EOF

    puts ('mindmapviz s: ' + s.inspect).debug if debug

    style ||= default_stylesheet()

    super(raw_doc, style: style, debug: debug, fill: fill, 
          stroke: stroke, text_color: text_color)
    @css = "
      .node ellipse {stroke: #{stroke}; fill: #{fill}}
      .node text {fill: #{text_color}}
      .edge path {stroke: #{stroke}}
      .edge polygon {stroke: #{stroke}; fill: #{stroke}}
    "
 
  end
  
  
  private

  def default_stylesheet()

<<STYLE
  node { 
    color: #ddaa66; 
    fillcolor: #{@fill};
    fontcolor: #{@text_color}; 
    fontname: 'Trebuchet MS'; 
    fontsize: 8; 
    margin: 0.0;
    penwidth: 1; 
    style: filled;
  }
  
  a node {
    color: #0011ee;   
    penwidth: 1;
  }

  edge {
    arrowsize: 0.5;
    color: #{@stroke}; 
    fontcolor: #444444; 
    fontname: Verdana; 
    fontsize: 8; 
    dir: none;
    weight: 1;
  }
STYLE

  end    
end
