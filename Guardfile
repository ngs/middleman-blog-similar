guard 'spork' do
  watch('Gemfile')
  watch('Gemfile.lock')
  watch(/.*\.rb$/)
end

guard 'rspec' do
  watch(%r{^spec/.*\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| ["spec/#{m[1]}_spec.rb"] + Dir["spec/#{m[1]}/*_spec.rb"] }
end

guard 'cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^lib/.*\.rb$})          { 'features' }
end
