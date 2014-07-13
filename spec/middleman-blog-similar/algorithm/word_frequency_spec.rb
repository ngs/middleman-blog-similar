require 'spec_helper'
require 'middleman-blog-similar/algorithm/word_frequency'

describe 'Middleman::Blog::Similar::Algorithm::WordFrequency' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :word_frequency
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/10/article2.html' }
  let(:algorithm)  { article.similarity_algorithm }
  let(:cache_id) { algorithm.cache_id }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::WordFrequency  }
    }
  }
  describe(:algorithm) {
    subject { algorithm }
    it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency }
  }
  describe(:db) {
    describe('path') {
      subject { algorithm.db_path }
      it { should eq File.join File.expand_path('../../../../', __FILE__), 'tmp/rspec/test-app/tmp/similar.db' }
    }
    describe('exists') {
      before { algorithm.db }
      subject { File.exists? algorithm.db_path }
      it { should be true }
    }
    describe(:cache_id) {
      subject { cache_id }
      it { should eq 1 }
    }
  }
  describe(:unigrams) {
    describe('length of keys') {
      subject { algorithm.unigrams.keys.length }
      it { should be 21089 }
    }
    describe('class') {
      subject { algorithm.unigrams }
      it { should be_a_kind_of Hash }
    }
  }
  describe(:similar_articles) {
    subject { algorithm.similar_articles.map(&:url) }
    it {
      should eq [
        "/2014/05/11/article3.html",
        "/2014/05/08/article0.html",
        "/2014/05/12/article4.html",
        "/2014/05/13/article5.html",
        "/2014/05/09/article1.html",
        "/2014/05/14/article6.html"
      ]
    }
  }
  describe(:tags) {
    subject { algorithm.tags }
    it { should eq ["fox", "quick", "dog", "brown", "the", "jump", "lazi", "over", "articl", "2"] }
  }
  describe(:word_freq) {
    subject { algorithm.word_freq }
    it {
      should eq({
       "brown" => 2,
       "dog" => 3,
       "fox" => 6,
       "jump" => 1,
       "lazi" => 1,
       "over" => 1,
       "quick" => 6,
       "the" => 2,
       "2" => 1,
       "articl" => 1
      })
    }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency }
    }
  }

end
