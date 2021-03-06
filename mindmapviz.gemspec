Gem::Specification.new do |s|
  s.name = 'mindmapviz'
  s.version = '0.3.2'
  s.summary = 'Uses Graphviz to make a mindmap.'
  s.authors = ['James Robertson']
  s.files = Dir['lib/mindmapviz.rb']
  s.add_runtime_dependency('pxgraphviz', '~> 0.5', '>=0.5.2')
  s.signing_key = '../privatekeys/mindmapviz.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@jamesrobertson.eu'
  s.homepage = 'https://github.com/jrobertson/mindmapviz'
end
