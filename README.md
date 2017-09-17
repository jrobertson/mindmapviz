# Introducing the Mindmapviz gem

    require 'mindmapviz'
    
    s = "
    home # box
      employment
      socialising
      learning
      health
    "

    mmv = Mindmapviz.new s, fields: %w(label shape),delimiter: ' # '
    mmv.write '/tmp/mindmap.svg'


see http://www.jamesrobertson.eu/snippets/2017/sep/04/introducing-the-mindmapviz-gem.html
