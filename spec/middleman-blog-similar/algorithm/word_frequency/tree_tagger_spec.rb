require 'spec_helper'
require 'middleman-blog-similar/algorithm/word_frequency/tree_tagger'

describe 'Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :'word_frequency/tree_tagger'
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/08/article0.html' }
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
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency::TreeTagger }
    }
  }

end
