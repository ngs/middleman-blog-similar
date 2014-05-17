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
        it { should eq ["fox", "国家", "隙", "教師", "悪口", "尻", "坊ちゃん", "時分", "向", "叫び", "人間", "ネルソン", "この世", "西洋", "expect", "articl"] }
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
