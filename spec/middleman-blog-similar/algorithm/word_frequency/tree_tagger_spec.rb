require 'spec_helper'
require 'middleman-blog-similar/algorithm/word_frequency/tree_tagger'

describe 'Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :'word_frequency/tree_tagger'
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/10/article2.html' }
  let(:algorithm)  { article.similarity_algorithm }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger  }
    }
  }
  describe(:similarity_algorithm) {
    subject { algorithm }
    it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger }
  }
  describe(:tags) {
    describe(:output) {
      if ENV['TREETAGGER_COMMAND']
        subject { algorithm.tags }
        it { should eq ["quick", "fox", "dog", "brown", "lazi", "articl"] }
      else
        pending "ENV['TREETAGGER_COMMAND'] not set."
      end
    }
    context('if command path is not set') {
      subject { -> { algorithm.tags } }
      before {
        @cmd = ENV['TREETAGGER_COMMAND']
        ENV['TREETAGGER_COMMAND'] = nil
      }
      after {
        ENV['TREETAGGER_COMMAND'] = @cmd if @cmd
      }
      describe('raises error') {
        it { should raise_error Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger::CommandNotFound }
      }
    }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger }
    }
  }

end
