# Introducing the Mindmapviz gem

    require 'mindmapviz'

    s = "
    home # ellipse
      employment
      socialising
      learning
      health
    "

    mmv = Mindmapviz.new s, fields: %w(label shape),delimiter: ' # '
    mmv.to_png 'mindmap.png'

Output

![](http://www.jamesrobertson.eu/r/images/2017/sep/04/mindmap.png)

## Resources

* mindmapviz https://rubygems.org/gems/mindmapviz

mindmapviz mindmap gem graphviz
