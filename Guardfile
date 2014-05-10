guard 'spork' do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch(/.*\.rb$/)
end

guard 'rspec' do
  watch(%r{^spec/.*\.rb$})
  watch(%r{^lib/.*\.rb$}) { 'spec' }
end

guard 'cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^lib/.*\.rb$})          { 'features' }
end
