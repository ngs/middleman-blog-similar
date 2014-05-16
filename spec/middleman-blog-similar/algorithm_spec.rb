require 'spec_helper'
require 'middleman-blog-similar/algorithm/word_frequency'

describe 'Middleman::Blog::Similar::Algorithm' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/08/article0.html' }
  let(:algorithm)  { article.similarity_algorithm }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::WordFrequency  }
    }
  }
  describe(:similarity_algorithm) {
    describe(:articles) {
      subject { algorithm.articles.map(&:url) }
      it {
        should eq [
          "/2014/05/14/article6.html",
          "/2014/05/13/article5.html",
          "/2014/05/12/article4.html",
          "/2014/05/11/article3.html",
          "/2014/05/10/article2.html",
          "/2014/05/09/article1.html",
          "/2014/05/08/article0.html"
        ]
      }
    }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency  }
    }
  }
end
