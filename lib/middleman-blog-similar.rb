require 'middleman-core'
require 'middleman-blog-similar/version'

::Middleman::Extensions.register(:similar) do
  require 'middleman-blog-similar/extension'
  ::Middleman::Blog::SimilarExtension
end
