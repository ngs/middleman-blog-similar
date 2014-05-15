require 'spec_helper'
require 'middleman-blog-similar/algorithm/tag_scored'

describe 'Middleman::Blog::Similar::Algorithm::TagScored' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :tag_scored
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/08/article0.html' }
  let(:algorithm)  { article.similarity_algorithm }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::TagScored  }
    }
  }
  describe(:similarity_algorithm) {
    subject { algorithm }
    it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::TagScored }
    describe(:similar_articles) {
      subject { algorithm.similar_articles.map(&:url) }
      it {
        should eq [] # TODO
      }
    }
  }
  describe(:auto_tags) {
    subject { algorithm.auto_tags }
    it { should eq ['content'] }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::TagScored }
    }
  }

end
