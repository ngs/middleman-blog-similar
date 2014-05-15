require 'spec_helper'
require 'middleman-blog-similar/algorithm/tag_scored/tree_tagger'

describe 'Middleman::Blog::Similar::Algorithm::TagScored::TreeTagger' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :'tag_scored/tree_tagger'
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/08/article0.html' }
  let(:algorithm)  { article.similarity_algorithm }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::TagScored::TreeTagger  }
    }
  }
  describe(:similarity_algorithm) {
    subject { algorithm }
    it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::TagScored::TreeTagger }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::TagScored::TreeTagger }
    }
  }

end
