require "middleman-core"
require "middleman-blog-similar/version"

::Middleman::Extensions.register(:similar) do
  begin
    require "middleman-blog-similar/extension"
    ::Middleman::Blog::SimilarExtension
  rescue Exception => e
    p e
  end
end
