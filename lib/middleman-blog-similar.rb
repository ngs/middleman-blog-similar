require 'middleman-core'
require 'middleman-blog-similar/version'

::Middleman::Extensions.register(:similar) do
  begin
    require 'middleman-blog-similar/extension'
    ::Middleman::Blog::SimilarExtension
  rescue StandardError => e
    warn e
  end
end
