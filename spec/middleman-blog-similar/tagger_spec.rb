require 'spec_helper'

describe 'tagger' do
  before(:all) { @app = middleman_app('test-app') {} }
  let(:app) { @app }
  let(:resource) { app.sitemap.resources.select { |res| res.page_id == page_id }.first }
  let(:page_id) { '2014-05-08-article0' }
  subject { described_class.new.call resource }
  describe ::Middleman::Blog::Similar::Tagger::Tags do
    it { is_expected.to eq %w(dog cat brown) }
  end
  describe ::Middleman::Blog::Similar::Tagger::Mecab do
    let(:page_id) { '2014-05-11-article3' }
    it { is_expected.to eq %w(叫び 悪口 教師 西洋 尻 時分 坊ちゃん 国家 この世 人間 国家 隙) }
    context 'written in English' do
      let(:page_id) { '2014-05-10-article2' }
      it { is_expected.to eq %w(quick brown fox jumps over the lazy dog dog dog) }
    end
  end
  describe ::Middleman::Blog::Similar::Tagger::Entagger do
    let(:page_id) { '2014-05-10-article2' }
    it { is_expected.to eq %w(fox jumps dog) }
  end
end
