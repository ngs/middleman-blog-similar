guard 'rspec', cmd: 'bundle exec rspec' do
  watch(%r{^spec/.*\.rb$})
  watch(%r{^lib/(.+)\.rb$}) { |m| ["spec/#{m[1]}_spec.rb"] + Dir["spec/#{m[1]}/*_spec.rb"] }
end

guard 'cucumber', cmd: 'bundle exec cucumber' do
  watch(%r{^features/.+\.feature$})
  watch(%r{^features/support/.+$}) { 'features' }
  watch(%r{^lib/.*\.rb$})          { 'features' }
end

guard :rubocop, cmd: 'bundle exec rake rubocop' do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
