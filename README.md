middleman-blog-similar
======================

[![Gem Version](https://badge.fury.io/rb/middleman-blog-similar.png)][gem]
[![Build Status](https://travis-ci.org/ngs/middleman-blog-similar.svg?branch=master)][travis]
[![Dependency Status](https://gemnasium.com/ngs/middleman-blog-similar.png?travis)][gemnasium]
[![Code Quality](https://codeclimate.com/github/ngs/middleman-blog-similar.png)][codeclimate]
[![Coverage Status](https://coveralls.io/repos/github/ngs/middleman-blog-similar/badge.svg)][coveralls]

`middleman-blog-similar` is an extension for [middleman-blog] that adds method to lookup similar article.

Usage
-----

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
```

### `config.rb`

```ruby
activate :similar
```

This extension finds similar articles using those are using tags by default.

#### Built-in Tagger

You can set taggers using `tagger:` option. [MeCab] and [EngTagger] adopters are built in this extension.

```ruby
# Find by tags (default)
activate :similar, tagger: :tags

# Using MeCab / Need to add `gem 'natto'` in Gemfile
activate :similar, tagger: :mecab

# Using EngTagger / Need to add `gem 'entagger'` in Gemfile
activate :similar, tagger: :entagger
```

#### Using Lambda

You can use lambda as tagger

```ruby
# Resource is a Middleman::Blog::BlogArticle
activate :similar, tagger: ->(resource) { [resource.data.category] }
```

#### Multiple Taggers

You can configure multiple taggers both built-in and lambda taggers.

```ruby
activate :similar, tagger: {
  # key = tagger, value = weight
  mecab: 1,
  entagger: 1,
  tags: 3,
  # key = (ignored), value[0] = weight, value[1] = lambda
  custom: [5, ->(resource) { resource.data.category ? [resource.data.category] : [] }]
}
```

License
-------

Copyright (c) 2014-2017 [Atsushi Nagase]. MIT Licensed, see [LICENSE] for details.

[middleman]: http://middlemanapp.com
[middleman-blog]: https://github.com/middleman/middleman-blog
[gem]: https://rubygems.org/gems/middleman-blog-similar
[travis]: http://travis-ci.org/ngs/middleman-blog-similar
[gemnasium]: https://gemnasium.com/ngs/middleman-blog-similar
[codeclimate]: https://codeclimate.com/github/ngs/middleman-blog-similar
[LICENSE]: LICENSE.md
[Atsushi Nagase]: https://ngs.io
[coveralls]: https://coveralls.io/github/ngs/middleman-blog-similar
[MeCab]: http://taku910.github.io/mecab/
[EngTagger]: https://github.com/yohasebe/engtagger
