require 'pundit_dsl'

require 'bundler/setup'
require 'coveralls'

require_relative 'fixtures/user'
require_relative 'fixtures/post'

begin
  require 'pry'
rescue LoadError
end

Coveralls.wear!

RSpec.configure do |c|
  c.run_all_when_everything_filtered = true
end
