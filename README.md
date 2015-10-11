Middleman-Blog-Similar
======================

`middleman-blog-similar` is an extension for [middleman-blog] that adds method to lookup similar article.

### Usage

`Middleman::Blog::BlogArticle#similar_articles` returns an array of `Middleman::Blog::BlogArticle` instances.

```slim
h2 Similar Entries
ul
  - current_article.similar_articles.first(5).each do|article|
    li= link_to article.title, article.url
```

`similar_articles` helper is also available in article pages.

```slim
h2 Similar Entries
ul
  - similar_articles.first(5).each do|article|
    li= link_to article.title, article.url
```

Configuration
-------------

### `Gemfile`

```ruby
gem 'middleman-blog-similar'
#
# if you have preferred other algorithm:
#
# levenshtein
#   gem 'levenshtein-ffi', :require => 'levenshtein'
#
# damerau levenshtein:
#   gem 'damerau-levenshtein'
```

### `config.rb`

```ruby
# Word frequency sort:
activate :similar # , :algorithm => :word_frequency by default.

# Use TreeTagger
activate :similar, :algorithm => :'word_frequency/tree_tagger'

# Use MeCab
activate :similar, :algorithm => :'word_frequency/mecab'

# Levenshtein distance function:
activate :similar, :algorithm => :levenshtein

# Damerau–Levenshtein distance function:
activate :similar, :algorithm => :damerau_levenshtein
```

This library supports [levenshtein-ffi], [levenshtein] and [damerau-levenshtein].

## Morphological Analysis

### [MeCab]

You need to install `mecab` command in your `PATH`.

#### Mac OS X with Homebrew

```bash
brew install mecab mecab-ipadic
```

### [TreeTagger]

You need to install [TreeTagger] and export path to the tagger script to `TREETAGGER_COMMAND` environment variable.

```bash
# Mac OS X
curl -#o tree-tagger-MacOSX-3.2-intel.tar.gz http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-MacOSX-3.2-intel.tar.gz
# or Linux
curl -#o tree-tagger-linux-3.2.tar.gz http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tree-tagger-linux-3.2.tar.gz
# Your language parameter file.
curl -#o english-par-linux-3.2.bin.gz http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/english-par-linux-3.2.bin.gz
# Tagger scripts
curl -#o tagger-scripts.tar.gz http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/tagger-scripts.tar.gz
# Install script
curl -#o install-tagger.sh http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/data/install-tagger.sh
# Install tagger
sh install-tagger.sh
# Append export variable
echo "export TREETAGGER_COMMAND='`pwd`/cmd/tree-tagger-english'" >> ~/.bash_profile
```

## Customizing

You can use custom algorithm and morphological analyser with implementing modules like this:

```ruby
class Middleman::Blog::Similar::Algorithm::MyFastDistance < ::Middleman::Blog::Similar::Algorithm
  def similar_articles
    # Do stuff and return scores
  end
end
```

```ruby
class Middleman::Blog::Similar::Algorithm::WordFrequency::SuperClever < ::Middleman::Blog::Similar::Algorithm
    def words
      # Do stuff and return words
    end
  end
end
```

then in your `config.rb`

```ruby
activate :similar, :algorithm => :my_fast_distance
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
[TreeTagger]: http://www.cis.uni-muenchen.de/~schmid/tools/TreeTagger/
[MeCab]: http://mecab.googlecode.com/svn/trunk/mecab/doc/index.html
