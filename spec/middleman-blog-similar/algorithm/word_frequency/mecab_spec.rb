# -*- coding: UTF-8 -*-

require 'spec_helper'
require 'middleman-blog-similar/algorithm/word_frequency/mecab'

describe 'Middleman::Blog::Similar::Algorithm::WordFrequency::Mecab' do
  let(:app)     {
    middleman_app('test-app') {
      activate :similar, :algorithm => :'word_frequency/mecab'
    }
  }
  let(:article) { app.sitemap.find_resource_by_destination_path '/2014/05/11/article3.html' }
  let(:algorithm)  { article.similarity_algorithm }
  describe(:app) {
    describe(:similarity_algorithm) {
      subject { app.similarity_algorithm }
      it { should be ::Middleman::Blog::Similar::Algorithm::WordFrequency::Mecab  }
    }
  }
  describe(:similarity_algorithm) {
    subject { algorithm }
    it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency::Mecab }
  }
  describe(:tags) {
    describe(:output) {
      if %x{which mecab}
        subject { algorithm.tags }
        it { should eq ["fox","の","国家","さん","方","誰","私","坊ちゃん","立脚","西洋","矛盾","相違","発会","時分","昨日","講演","教師","拡張","悪口","尻","変","結果","開始","周旋","向","叫び","反駁","反抗","前","人間","ネルソン","よう","関係","なん","ため","それ","そう","院","この世","お話","隙","expect","articl","3"] }
      else
        pending "mecab is not installed."
      end
    }
  }
  describe(:article) {
    describe(:similarity_algorithm) {
      subject { algorithm }
      it { should be_a_kind_of ::Middleman::Blog::Similar::Algorithm::WordFrequency::Mecab }
    }
  }

end
