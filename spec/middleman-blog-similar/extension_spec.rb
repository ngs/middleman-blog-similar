require 'spec_helper'

# rubocop:disable Metrics/BlockLength
describe 'Middleman::Blog::SimilarExtension' do
  before(:all) { @app = middleman_app('test-app') { activate :similar, db: ':memory:' } }
  let(:app) { @app }
  describe 'activation' do
    subject { app.extensions }
    its([:similar]) { is_expected.not_to be_nil }
    its([:blog]) { is_expected.not_to be_nil }
    context 'with unknown tagger' do
      let(:app) { middleman_app('test-app') { activate :similar, db: ':memory:', tagger: 'hoge' } }
      it { expect { app }.to raise_error LoadError, 'cannot load such file -- middleman-blog-similar/tagger/hoge' }
    end
    context 'with invalid tagger' do
      let(:app) { middleman_app('test-app') { activate :similar, db: ':memory:', tagger: 1 } }
      it { expect { app }.to raise_error RuntimeError, /Invalid type for tagger option/ }
    end
  end
  describe 'results' do
    let(:resource) { app.sitemap.resources.select { |res| res.page_id == '2014-05-08-article0' }.first }
    subject { resource.similar_articles.map { |a| [a.page_id, a.data.category || '<none>'].concat a.tags } }
    it { is_expected.to have(4).items }
    its([0]) { is_expected.to eq %w(2014-05-14-article6 <none> dog Brown cat) }
    its([1]) { is_expected.to eq %w(2014-05-12-article4 <none> dog cat fox) }
    its([2]) { is_expected.to eq %w(2014-05-09-article1 test dog cat) }
    its([3]) { is_expected.to eq %w(2014-05-13-article5 <none> dog) }
    context 'when configured with weight map' do
      before :all do
        @app = middleman_app('test-app') do
          activate :similar,
                   db: ':memory:',
                   tagger: {
                     tags: 1,
                     category: [2, ->(article) { article.data.category ? [article.data.category] : [] }]
                   }
        end
      end
      it { is_expected.to have(4).items }
      its([0]) { is_expected.to eq %w(2014-05-09-article1 test dog cat) }
      its([1]) { is_expected.to eq %w(2014-05-14-article6 <none> dog Brown cat) }
      its([2]) { is_expected.to eq %w(2014-05-12-article4 <none> dog cat fox) }
      its([3]) { is_expected.to eq %w(2014-05-13-article5 <none> dog) }
    end
  end
end
