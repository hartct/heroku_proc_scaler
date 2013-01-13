require 'rspec'
require 'heroku_proc_scaler'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter     = 'documentation'
end