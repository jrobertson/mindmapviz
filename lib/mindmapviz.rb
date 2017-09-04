#!/usr/bin/env ruby

# file: mindmapviz.rb

require 'pxgraphviz'


# inspired by https://github.com/bingwei/ruby-graphviz-mindmap


class Mindmapviz
  
  attr_reader :raw_doc
  
  def initialize(s, fields: %w(label shape), delimiter: ' # ', 
                 style: default_stylesheet())
    


@raw_doc=<<EOF
<?polyrex schema='items[type, layout]/item[#{fields.join(', ')}]' delimiter='#{delimiter}'?>
type: graph
layout: neato
#{s}
EOF

    @pxg = PxGraphViz.new(@raw_doc, style: style)
 
  end
  
  def export(file='gvml.xml')
    File.write file, @pxg.to_doc.xml(pretty: true)    
  end
  
  alias export_as export
  
  def save(s)
    File.write filename, @raw_doc
  end
  
  def to_dot()
    @pxg.to_dot
  end

  # writes to a PNG file (not a PNG blob)
  #
  def to_png(filename)    
    @pxg.to_png filename
  end
  
  # writes to a SVG file (not an SVG blob)
  #
  def to_svg(filename)
    @pxg.to_svg filename
    'SVG file written'
  end    
    
  
  private

  def default_stylesheet()

<<STYLE
  node { 
    color: #ddaa66; 
    fillcolor: #ccffcc;
    fontcolor: #330055; 
    fontname: Trebuchet MS; 
    fontsize: 8; 
    margin: 0.0;
    penwidth: 1; 
    style: filled;
  }

  edge {
    arrowsize: 0.5;
    color: #999999; 
    fontcolor: #444444; 
    fontname: Verdana; 
    fontsize: 8; 
    #{@type == :digraph ? 'dir: forward;' : 'dir: none;'}
    weight: 1;
  }
STYLE

  end    
end