Middleman-Blog-Similar
======================

`middleman-blog-similar` is an extension for [middleman-blog] that adds method to lookup similar article.

### Usage

`Middleman::Blog::BlogArticle#similar( limit = 5 )` returns an array of `Middleman::Blog::BlogArticle` instances.

```slim
h2 Similar Entries
ul
  - current_article.similar_articles.each do|article|
    li= link_to article.title, article.url
```

`similar_articles` helper is also available in article pages.

```slim
h2 Similar Entries
ul
  - similar_articles(10).each do|article|
    li= link_to article.title, article.url
```

Configuration
-------------

### `Gemfile`

```ruby
gem 'middleman-blog-similar'
gem 'levenshtein-ffi', :require => 'levenshtein' # recommended
#
# or if you prefer:
#
#   gem 'levenshtein'
#   gem 'damerau-levenshtein'
```

### `config.rb`

```ruby
# incase of levenshtein-ffi or levenshtein
activate :similar # , :engine => :levenshtein by default.

# or if you prefer damerau levenshtein
activate :similar, :engine => :damerau_levenshtein
```

This library supports [levenshtein-ffi], [levenshtein] and [damerau-levenshtein].

## Custom engine

You can use custom engine with implementing modules like this:

```ruby
module Middleman
  module Blog
    module Similar
      module Engines
        module MyFastDistance
          def distance(string1, string2)
            # Do stuff and return scores
          end
        end
      end
    end
  end
end
```

then in your `config.rb`

```ruby
activate :similar, :engine => :my_fast_distance
```

Build & Dependency Status
-------------------------

[![Gem Version](https://badge.fury.io/rb/middleman-blog-similar.png)][gem]
[![Build Status](https://travis-ci.org/ngs/middleman-blog-similar.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/ngs/middleman-blog-similar.png?travis)][gemnasium]
[![Code Quality](https://codeclimate.com/github/ngs/middleman-blog-similar.png)][codeclimate]

License
-------

Copyright (c) 2014 [Atsushi Nagase]. MIT Licensed, see [LICENSE] for details.

[middleman]: http://middlemanapp.com
[middleman-blog]: https://github.com/middleman/middleman-blog
[gem]: https://rubygems.org/gems/middleman-blog-similar
[travis]: http://travis-ci.org/ngs/middleman-blog-similar
[gemnasium]: https://gemnasium.com/ngs/middleman-blog-similar
[codeclimate]: https://codeclimate.com/github/ngs/middleman-blog-similar
[LICENSE]: https://github.com/ngs/middleman-blog-similar/blob/master/LICENSE.md
[Atsushi Nagase]: http://ngs.io/
[levenshtein-ffi]: https://github.com/dbalatero/levenshtein-ffi
[levenshtein]: https://github.com/schuyler/levenshtein
[damerau-levenshtein]: https://github.com/GlobalNamesArchitecture/damerau-levenshtein
