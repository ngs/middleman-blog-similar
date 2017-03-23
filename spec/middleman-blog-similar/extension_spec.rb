require 'spec_helper'

describe 'Middleman::Blog::SimilarExtension' do
  let(:app) { middleman_app('test-app') { activate :similar } }
  describe('activation') do
    subject { app.extensions }
    its([:similar]) { is_expected.not_to be_nil }
    its([:blog]) { is_expected.not_to be_nil }
  end
end
